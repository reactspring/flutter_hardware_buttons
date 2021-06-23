import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hardware_buttons/hardware_buttons.dart' as HardwareButtons;

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? _latestHardwareButtonEvent;

  late StreamSubscription<HardwareButtons.VolumeButtonEvent>
      _volumeButtonSubscription;

  @override
  void initState() {
    super.initState();
    _volumeButtonSubscription =
        HardwareButtons.volumeButtonEvents!.listen((event) {
      setState(() {
        _latestHardwareButtonEvent = event.toString();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _volumeButtonSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Value: $_latestHardwareButtonEvent\n'),
            ],
          ),
        ),
      ),
    );
  }
}
