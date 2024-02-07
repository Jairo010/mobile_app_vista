import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:ui';
import 'package:mobile_app/classes/instructions.dart';
import '../main.dart';

class SimulationPage extends StatefulWidget {
  const SimulationPage({super.key});
  @override
  SimulationPageState createState() => SimulationPageState();
}

List<CameraDescription> cameras = [];
String dropdownButtonText = 'Pizarra';

class SimulationPageState extends State<SimulationPage> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    super.initState();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    cameras = await availableCameras();
    controller = CameraController(cameras[0], ResolutionPreset.medium);
    await controller.initialize();
    if (!mounted) {
      return;
    }
    setState(() {});
  }

  Future<void> disposeCamera() async {
    await controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        disposeCamera();
       Navigator.popUntil(context, ModalRoute.withName('/'));
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              disposeCamera();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyApp(),
                ),
              );
            },
          ),
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: () {
                  disposeCamera();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const InstructionsPage(),
                    ),
                  );
                }),
          ],
        ),
        body: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Image(image: _image, fit: BoxFit.cover),
            ),
            if (_sliderValue > 0)
              Positioned.fill(
                left: 0,
                right: MediaQuery.of(context).size.width / 2,
                child: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                        sigmaX: _sliderValue * 10, sigmaY: _sliderValue * 10),
                    child: Container(
                      color: Colors.black.withOpacity(0),
                    ),
                  ),
                ),
              ),
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Visión Simulada',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 255, 132))),
              ),
            ),
            const Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Visión Normal',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 255, 132))),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(_sliderValue.toStringAsFixed(1),
                      style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                  Slider(
                    value: _sliderValue,
                    min: 0.0,
                    max: 1.3,
                    divisions: 13,
                    onChanged: (newValue) {
                      setState(() {
                        _sliderValue = newValue;
                      });
                    },
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Theme(
                  data: Theme.of(context).copyWith(canvasColor: Colors.black),
                  child: DropdownButton<String>(
                    value: dropdownButtonText,
                    items: <String>['Pizarra', 'Aula', 'Cámara']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value,
                            style: const TextStyle(color: Colors.white)),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownButtonText = newValue!;
                        if (newValue == 'Pizarra') {
                          _image = const AssetImage(
                              'assets/images/BlackboardSpanish.jpg');
                        } else if (newValue == 'Aula') {
                          _image =
                              const AssetImage('assets/images/classroom.jpg');
                        } else if (newValue == 'Cámara') {
                          getImage();
                        }
                      });
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  late CameraController controller;
  double _sliderValue = 0.0;
  ImageProvider _image =
      const AssetImage('assets/images/BlackboardSpanish.jpg');
  final picker = ImagePicker();

  Future<void> getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = FileImage(File(pickedFile.path));
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    disposeCamera();
    super.dispose();
  }
}
