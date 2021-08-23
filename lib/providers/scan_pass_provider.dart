import 'package:flutter/foundation.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanPassModel extends ChangeNotifier {
  Barcode? _result;

  Barcode? getResult() {
    return _result;
  }

  set result(Barcode result) {
    _result = result;
    notifyListeners();
  }

  void clearResult() {
    _result = null;
    notifyListeners();
  }
}
