import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:student_details/screens/registerscreen.dart';
import 'package:student_details/screens/scanscreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.white,
        title: Image.asset(
          "assets/logo.png",
          height: 68,
        ),
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).push(CupertinoPageRoute(
                      builder: (context) => const ScanScreen()));
                },
                color: Theme.of(context).primaryColor,
                minWidth: 250,
                height: 50,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(
                      Icons.qr_code_outlined,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "SCAN QR",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              MaterialButton(
                onPressed: () async {
                  Navigator.of(context).push(CupertinoPageRoute(
                      builder: (context) => const RegisterScreen()));
                },
                color: Theme.of(context).primaryColor,
                minWidth: 250,
                height: 50,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(
                      Icons.account_box_outlined,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "REGISTER",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
