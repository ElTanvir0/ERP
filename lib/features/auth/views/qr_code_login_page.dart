import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_qr_reader/flutter_qr_reader.dart';
import 'package:get/get.dart';
import 'package:new_ways_app/features/auth/controller/authentication_provider.dart';
import 'package:new_ways_app/utils/constants.dart';
import 'package:permission_handler/permission_handler.dart';

class QrLogin extends StatefulWidget {
  @override
  _QrLoginState createState() => _QrLoginState();
}

class _QrLoginState extends State<QrLogin> {
  RxDouble pos = 0.0.obs;
  bool isScanning = true;
  Timer? _looper;
  AuthenticationController _authController =
      Get.find<AuthenticationController>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  QrReaderViewController? _controller;
  bool ismakingRequest = false;

  loopPosition() {
    _looper = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        print('Ran ${timer.tick}');
        if (isScanning) {
          if (pos == 0.0) {
            pos.value = 350.0;
          } else if (pos == 350.0) {
            pos.value = 0.0;
          }
        }
      },
    );
  }

  @override
  void initState() {
    permission();
    super.initState();
    loopPosition();
  }

  @override
  void dispose() {
    super.dispose();
    _looper!.cancel();
  }

  void alert(String tip) {
    ScaffoldMessenger.of(scaffoldKey.currentContext!)
        .showSnackBar(SnackBar(content: Text(tip)));
  }

  Future<bool> permission() async {
    var status = await Permission.camera.status;
    print(status);
    if (status.isDenied || status.isPermanentlyDenied) {
      status = await Permission.camera.request();
      print(status);
    }

    if (status.isRestricted) {
      alert("Camera Permission Restricted");
      await Future.delayed(Duration(seconds: 3));
      openAppSettings();
      return false;
    }

    if (!status.isGranted) {
      alert("Camera Permission Denied");

      return false;
    }
    setState(() {});
    return true;
  }

  Future startScan() async {
    _controller?.startCamera((String result, _) async {
      isScanning = false;
      await stopScan().then((value) async {
        if (!ismakingRequest) {
          print('Got IN....');
          if (result.contains('json/app-login')) {
            ismakingRequest = true;
            await _authController.loginViaQrCode(result)!.then((value) {
              if (value!.statusCode == 200) {
                showToast('Login Successfull......');
                Get.back();
              } else {
                showToast('Something went wrong....');
              }
              ismakingRequest = false;
            });
          } else {
            showToast('Not A valid QR code');
          }
        }
      });
    });
  }

  Future stopScan() async {
    await _controller!.stopCamera();
    print('Camera Stopped');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: const Text('MainScan'),
          centerTitle: true,
        ),
        body: Builder(builder: (context) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Scan QR Code To Login',
                  style: kTitleText.copyWith(fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 320,
                  height: 350,
                  child: Stack(
                    children: [
                      QrReaderView(
                        width: 320,
                        height: 350,
                        callback: (container) {
                          this._controller = container;
                          this.startScan();
                        },
                      ),
                      Obx(() => AnimatedPositioned(
                          top: pos.value,
                          child: Container(
                            decoration:
                                BoxDecoration(color: Colors.green, boxShadow: [
                              BoxShadow(
                                color: Colors.green.withOpacity(0.8),
                                spreadRadius: 4,
                                blurRadius: 10,
                              ),
                              BoxShadow(
                                color: Colors.green.withOpacity(0.8),
                                spreadRadius: -4,
                                blurRadius: 5,
                              )
                            ]),
                            height: 1,
                            width: 320,
                          ),
                          duration: Duration(seconds: 1)))
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Icon(
                  Icons.qr_code_scanner,
                  size: 100,
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
