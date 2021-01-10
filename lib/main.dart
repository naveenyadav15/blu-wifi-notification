import 'package:bluetooth_check/src/utils/notification_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'src/common/variables.dart';
import 'src/ui/bluetooth/blutoothUi.dart';
import 'src/ui/wifi/wifiUi.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StartApp(),
    );
  }
}

class StartApp extends StatefulWidget {
  @override
  _StartAppState createState() => _StartAppState();
}

class _StartAppState extends State<StartApp> {
  final NotificationsManager notificationsManager = NotificationsManager();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startNoti();
  }

  startNoti() async {

    await notificationsManager.initializeNotifications();
     notificationsManager.showNotifications("Connection: $connectionStatus \nBlutooth: $bluStatus");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: CupertinoColors.activeBlue,
      appBar: AppBar(
        title: Text(
          "Wifi with Bluetooth",
        ),
      ),
      body: Column(
        children: [
          Expanded(child: WifiContainer()),
          Divider(
            color: Colors.black,
          ),
          Expanded(child: BluetoothContainer()),
          // BleDevice(),
        ],
      ),
    );
  }
}
