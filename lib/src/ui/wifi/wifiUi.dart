import 'package:bluetooth_check/src/common/variables.dart';
import 'package:bluetooth_check/src/utils/connectivity.dart';
import 'package:bluetooth_check/src/utils/notification_manager.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

class WifiContainer extends StatefulWidget {
  @override
  _WifiContainerState createState() => _WifiContainerState();
}

class _WifiContainerState extends State<WifiContainer> {
  String wifiStatus = "Not Connected";
  bool connected = false;
  ConnectivityResult result = ConnectivityResult.none;

  final NotificationsManager notificationsManager = NotificationsManager();
  @override
  void initState() {
    super.initState();
    ConnectivityManager.isConnectedToInternet();
    ConnectivityManager.onConnectiviyChange(context, notify);
       notificationsManager.showNotifications("Connection: $connectionStatus \nBlutooth: $bluStatus");
  
  }

  notify(ConnectivityResult _result, bool _connected) {
    result = _result;
    connected = _connected;
    setState(() {
      print("Result is: $result");
    });
    connectionStatus = result.toString().substring(19);

     notificationsManager.showNotifications("Connection: $connectionStatus \nBlutooth: $bluStatus");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          child: ListTile(
            tileColor: Colors.blueGrey,
            title: Text("Connection"),
            trailing: Text(result.toString().substring(19)),
          ),
        ),
        Container(
          child: ListTile(
            tileColor: Colors.blueGrey,
            title: Text("Internet"),
            trailing: Text(connected.toString()),
          ),
        ),
      ],
    );
  }
}
