import 'package:flutter/material.dart';
import 'package:student_details/components/register1.dart';
import 'package:student_details/components/register2.dart';
import 'package:student_details/components/register3.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _pageController = PageController();
  String? _usn;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        child: Center(
          child: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Register1(
                callback: (value) {
                  setState(() {
                    _usn = value.toUpperCase();
                  });

                  _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn);
                },
              ),
              Register2(
                usn: _usn,
                callback: (value) {
                  _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn);
                },
              ),
              Register3(usn: _usn),
            ],
          ),
        ),
      ),
    );
  }
}
