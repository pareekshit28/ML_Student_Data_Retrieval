import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:student_details/constants.dart';
import 'package:student_details/screens/verifyfacescreen.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final _controller = MobileScannerController();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      constraints: const BoxConstraints.expand(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 28.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Scan your QR Code",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 5),
              SizedBox(
                  height: getCameraPreviewWidth(),
                  width: getCameraPreviewWidth(),
                  child: MobileScanner(
                    controller: _controller,
                    onDetect: (barcode, args) {
                      _controller.dispose();
                      if (barcode.rawValue != null) {
                        Navigator.of(context).push(CupertinoPageRoute(
                            builder: (context) => VerifyFaceScreen(
                                  usn: barcode.rawValue!,
                                )));
                      }
                    },
                  )),
            ],
          ),
        ),
      ),
    ));
  }

  double getCameraPreviewWidth() {
    final device = getDevice(context);
    switch (device) {
      case devices.mobile:
        return 300;
      case devices.tablet:
        return 300;
      case devices.laptop:
        return 450;
      case devices.desktop:
        return 500;
      case devices.tv:
        return 550;
    }
  }
}
