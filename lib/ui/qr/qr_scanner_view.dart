import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:penger/config/color.dart';
import 'package:penger/helpers/api/api_helper.dart';
import 'package:penger/helpers/socket/socket_helper.dart';
import 'package:penger/providers/scan_pass_provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:socket_io_client/src/socket.dart';
import 'package:fluttertoast/fluttertoast.dart';

class QRScannerPage extends StatefulWidget {
  const QRScannerPage({Key? key}) : super(key: key);

  @override
  _QRScannerPageState createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  final SocketHelper _socketHelper = SocketHelper();
  final ApiHelper _api = ApiHelper();
  final ScanPassModel _scanListener = ScanPassModel();

  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  DateTime? lastScan;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _socketHelper.init();
    _scanListener.addListener(_listenSocket);
  }

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  if (_scanListener.getResult() != null)
                    Text(
                        'Barcode Type: ${describeEnum(_scanListener.getResult()!.format)}   Data: ${_scanListener.getResult()!.code}')
                  else
                    Text('Scan a code'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          margin: const EdgeInsets.all(8),
                          child: IconButton(
                            splashRadius: 20,
                            icon: FutureBuilder(
                              future: controller?.getFlashStatus(),
                              builder: (context, snapshot) {
                                return Icon(
                                    snapshot.data == null ||
                                            snapshot.data == false
                                        ? Icons.flash_off_sharp
                                        : Icons.flash_on_sharp,
                                    size: 18);
                              },
                            ),
                            onPressed: () async {
                              await controller?.toggleFlash();
                              setState(() {});
                            },
                          )),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: IconButton(
                          splashRadius: 20,
                          icon: FutureBuilder(
                            future: controller?.getCameraInfo(),
                            builder: (context, snapshot) {
                              if (snapshot.data != null) {
                                return Text(
                                    'Camera facing ${describeEnum(snapshot.data!)}');
                              } else {
                                return Text('loading');
                              }
                            },
                          ),
                          onPressed: () async {
                            await controller?.flipCamera();
                            setState(() {});
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: IconButton(
                          splashRadius: 20,
                          icon: const Icon(
                            Icons.pause_circle_outline_sharp,
                            size: 18,
                          ),
                          onPressed: () async {
                            await controller?.pauseCamera();
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: IconButton(
                          splashRadius: 20,
                          icon: const Icon(
                            Icons.restart_alt_outlined,
                            size: 18,
                          ),
                          onPressed: () async {
                            // await controller?.pauseCamera();
                            _scanListener.clearResult();
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: IconButton(
                          splashRadius: 20,
                          onPressed: () async {
                            await controller?.resumeCamera();
                          },
                          icon: const Icon(
                            Icons.play_circle_sharp,
                            size: 18,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((Barcode scanData) async {
      final currentScan = DateTime.now();
      if (lastScan == null ||
          currentScan.difference(lastScan!) > const Duration(seconds: 3)) {
        lastScan = currentScan;
        _scanListener.result = scanData;
      }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('no Permission')),
      );
    }
  }

  void _listenSocket() {
    Barcode? result = _scanListener.getResult();

    if (result == null) return;

    final record = jsonDecode(result.code);

    final Map<String, String> fd = {
      "record_id": record['record']['id'].toString(),
    };

    debugPrint(record['record']['id'].toString());

    _api.post('verify-pass', data: fd);

    final Socket instance = _socketHelper.getSocket;
    instance.on("rest-join", (data) {
      instance.emit("join-pass", data);
    });

    instance.on("joined room", (data) {
      debugPrint('joined');
      instance.emit("start verifying", {"to": record["to"]});
    });

    instance.on("verifying", (data) {
      debugPrint('verifying');
    });

    instance.on("verified success", (data) {
      debugPrint('success');
      _showToast(successColor, (data["msg"] ?? "Verified").toString());
    });

    instance.on("verified failed", (data) {
      debugPrint('failed');
      _showToast(successColor, (data["msg"] ?? "Verified failed").toString());
    });

    instance.on("unauthorized", (data) {
      debugPrint('unauthorized');
      _showToast(successColor, "unauthorized");
    });
  }

  void _showToast(Color color, String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0);
  }

  @override
  void dispose() {
    controller?.dispose();
    // _socketHelper.dispose();
    super.dispose();
  }
}
