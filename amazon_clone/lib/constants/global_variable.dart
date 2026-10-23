import 'dart:io';

import 'package:flutter/material.dart';

const int apiPort = 3000;

const List<String> apiHosts = ['127.0.0.1', '192.168.1.65', '10.0.2.2'];

String uri = 'http://192.168.1.67:$apiPort';

Future<void> resolveApiUri() async {
  for (final host in apiHosts) {
    try {
      final socket = await Socket.connect(
        host,
        apiPort,
        timeout: const Duration(seconds: 1),
      );
      socket.destroy();
      uri = 'http://$host:$apiPort';
      return;
    } catch (_) {}
  }
}

class GlobalVariable {
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 29, 201, 192),
      Color.fromARGB(255, 125, 221, 216),
    ],
    stops: [0.5, 1.0],
  );

  static const secondaryColor = Color.fromRGBO(255, 153, 0, 1);
  static const backgroundColor = Colors.white;
  static const Color greyBackgroundCOlor = Color(0xffebecee);
  static var selectedNavBarColor = Colors.cyan[800]!;
  static const unselectedNavBarColor = Colors.black87;
}
