import 'dart:io';

import 'package:bluetooth_check/src/common/variables.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

class ConnectivityManager {
  static final Connectivity _connectivity = Connectivity();

  static bool connected = false;
  static onConnectiviyChange(BuildContext context, Function notify) {
    _connectivity.onConnectivityChanged
        .listen((ConnectivityResult result) async {
      print("_connectivity result is: $result");

    connectionStatus = result.toString().substring(19);
      await checkInternet();
      notify(result, connected);
      if (result == ConnectivityResult.none) {
        print("No internet");
      } else {}
    });
  }

  static Future<bool> isConnectedToInternet() async {
    var result = await _connectivity.checkConnectivity();

    print("result is: $result");
    await checkInternet();
    if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }

  static Future<void> checkInternet() async {
    try {
      connected = false;
      await Future.delayed(
        Duration(milliseconds: 100),
      );
      final result = await InternetAddress.lookup('google.com');

      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        connected = true;
      }
    } on SocketException catch (err) {
      print('not connected 0: $err');
    } catch (err) {
      print('not connected');
      print("error is: $err");
    }
  }
}
