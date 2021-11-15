import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketHelper {
  factory SocketHelper() {
    return _instance;
  }

  SocketHelper._constructor();

  static final _instance = SocketHelper._constructor();

  final String uri = "${dotenv.env['HOST']}";
  late Socket socket;

  Future<void> init() async {
    try {
      connectToServer();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void connectToServer() {
    try {
      // Configure socket transports must be sepecified
      socket = io(uri, <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
        'forceNew': true,
      });

      debugPrint("socket init before ${socket.connected}");

      // Connect to websocket
      socket.connect();

      // Handle socket events
      socket.on('connect', (_) => debugPrint('connect: ${socket.id}'));
      socket.on('disconnect', (_) => debugPrint('disconnect'));
      socket.on('news', (data) {
        debugPrint("data: $data");
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Socket get getSocket => socket;
}
