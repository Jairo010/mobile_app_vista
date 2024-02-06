import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'results.dart';
import 'settings.dart';

class MainCalibrationPage extends StatefulWidget {
  const MainCalibrationPage({Key? key}) : super(key: key);

  @override
  MainCalibrationPageState createState() => MainCalibrationPageState();
}

class MainCalibrationPageState extends State<MainCalibrationPage> {

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        Navigator.popUntil(context, ModalRoute.withName('/'));
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                      constraints: const BoxConstraints(
                        maxHeight: 300,
                        maxWidth: 180,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 130),
                          Expanded(
                            child: Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    'leftIndication',
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 130,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.only(top: 70, right: 80),
                child: Container(
                  color: Colors.black,
                  width: 250,
                  height: 250,
                    child: Transform.rotate(
                      angle: pi,
                      child: Image.asset(
                        'assets/images/letter.jpg',
                        height: 250,
                        width: 250,
                        fit: BoxFit.cover,
                      ),
                    ),
                  
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }
}
