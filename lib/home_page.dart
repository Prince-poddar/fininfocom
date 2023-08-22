import 'package:fininfocom/profile_page.dart';
import 'package:fininfocom/randon_images.dart';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  static const platform = MethodChannel("channel");
  var bluetoothStatus = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("FinInfocom"),
      ),
      body: homeWidgets(),
    );
  }

  Widget homeWidgets() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              bluetoothStatus,
              style: const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
          const SizedBox(height:50),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => RandomImage()));
              },
              style: ElevatedButton.styleFrom(
                  elevation: 5.0,
                  minimumSize: const Size.fromHeight(50),
                  textStyle: const TextStyle(color: Colors.white)),
              child: const Text('Random dog images'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                _getBluetoothStatus();
              },
              style: ElevatedButton.styleFrom(
                  elevation: 5.0,
                  minimumSize: const Size.fromHeight(50),
                  textStyle: const TextStyle(color: Colors.white)),
              child: const Text('Enable Bluetooth'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ProfilePage()));
              },
              style: ElevatedButton.styleFrom(
                  elevation: 5.0,
                  minimumSize: const Size.fromHeight(50),
                  textStyle: const TextStyle(color: Colors.white)),
              child: const Text('Profile'),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _getBluetoothStatus() async {
    String bluetoothCurrentStatus;
    try {
      bluetoothCurrentStatus =
          await platform.invokeMethod('getBluetoothStatus');
    } on PlatformException catch (e) {
      bluetoothCurrentStatus = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      bluetoothStatus = bluetoothCurrentStatus;
    });
  }
}
