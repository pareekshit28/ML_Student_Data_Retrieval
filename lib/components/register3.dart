import 'dart:convert';
import 'package:universal_html/html.dart' as html;
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';

class Register3 extends StatelessWidget {
  final String? usn;
  Register3({Key? key, required this.usn}) : super(key: key);
  final _screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(28.0),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Download QR Code",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(
              height: 10,
            ),
            Screenshot(
              controller: _screenshotController,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: QrImage(
                    data: usn!,
                    size: 300,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                MaterialButton(
                  minWidth: 100,
                  onPressed: () {
                    _screenshotController.capture().then((value) {
                      if (value != null) {
                        final base64Data = base64Encode(value);
                        final a = html.AnchorElement(
                            href: 'data:image/jpeg;base64,$base64Data');

                        a.download = '$usn.jpg';

                        a.click();

                        a.remove();
                      }
                    }).catchError((e) {
                      debugPrint(e);
                    });
                  },
                  color: const Color.fromARGB(255, 223, 223, 223),
                  child: const Text("Download"),
                ),
                const SizedBox(
                  width: 15,
                ),
                MaterialButton(
                  minWidth: 100,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  color: const Color.fromARGB(255, 223, 223, 223),
                  child: const Text("Go to Home"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
