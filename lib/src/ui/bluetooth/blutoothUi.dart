import 'package:bluetooth_check/src/common/variables.dart';
import 'package:bluetooth_check/src/utils/notification_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BluetoothContainer extends StatefulWidget {
  @override
  _BluetoothContainerState createState() => _BluetoothContainerState();
}

class _BluetoothContainerState extends State<BluetoothContainer> {
  // Initializing the Bluetooth connection state to be unknown
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;

  final NotificationsManager notificationsManager = NotificationsManager();
  @override
  void initState() {
    super.initState();
    // Get current state
    FlutterBluetoothSerial.instance.state.then((state) {
      setState(() {
        _bluetoothState = state;
      });

      bluStatus = _bluetoothState.stringValue;
      notificationsManager.showNotifications(
          "Connection: $connectionStatus \nBlutooth: $bluStatus");
    });

    // Listen for further state changes
    FlutterBluetoothSerial.instance
        .onStateChanged()
        .listen((BluetoothState state) {
      setState(() {
        _bluetoothState = state;
      });
      bluStatus = _bluetoothState.stringValue;
      notificationsManager.showNotifications(
          "Connection: $connectionStatus \nBlutooth: $bluStatus");
    });
  }

  onChanged(bool value) async {
    if (value) {
      // Enable Bluetooth
      await FlutterBluetoothSerial.instance.requestEnable();
    } else {
      // Disable Bluetooth
      await FlutterBluetoothSerial.instance.requestDisable();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SwitchListTile(
        onChanged: (val) => onChanged(val),
        title: Text("Bluetooth"),
        subtitle: Text(_bluetoothState.stringValue),
        value: _bluetoothState.isEnabled,
      ),
    );
  }
}
