import 'dart:async';
import 'dart:developer' as developer;
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_get_wifimacadress/snackbar_helper.dart';
import 'package:network_info_plus/network_info_plus.dart';

// Sets a platform override for desktop to avoid exceptions. See
// https://flutter.dev/desktop#target-platform-override for more info.
void _enablePlatformOverrideForDesktop() {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux)) {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }
}

void main() {
  _enablePlatformOverrideForDesktop();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0x9f4376f8),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final NetworkInfo _networkInfo = NetworkInfo();

  @override
  void initState() {
    super.initState();
    _initNetworkInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NetworkInfoPlus example'),
        elevation: 4,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showConnectionStatusSnackBar();
          },
          child: const Text('Bağlantı Durumu'),
        ),
      ),
    );
  }

  Future<void> _initNetworkInfo() async {
    // Bu kısımları olduğu gibi bırakabilirsiniz
    //...
    //...
  }

  void showConnectionStatusSnackBar() async {
    String? wifiSubmask = "Failed to get Wifi submask address";

    try {
      wifiSubmask = await _networkInfo.getWifiSubmask();
    } on PlatformException catch (e) {
      developer.log('Failed to get Wifi submask address', error: e);
      wifiSubmask = 'Failed to get Wifi submask address';
    }

    // WiFi'ye bağlıysanız SnackBar'ı gösterin, aksi takdirde mesajı gösterin
    if (wifiSubmask == "255.255.255.0") {
      showCustomSnackBar(context, 'WiFi\'ye bağlısınız!');
    } else {
      showCustomSnackBar(context, 'WiFi\'ye bağlı değilsiniz!', isError: true);
    }
  }
}
