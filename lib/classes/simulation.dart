import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:ui';
import 'package:mobile_app/classes/instructions.dart';

class SimulationPage extends StatefulWidget {
  const SimulationPage({Key? key}) : super(key: key);
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
    initializeCameras();
  }

  Future<void> initializeCameras() async {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
    runApp(CameraApp());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),        
        actions: <Widget>[
          IconButton(icon: const Icon(Icons.arrow_forward),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => InstructionsPage(),
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
                Text(_sliderValue.toStringAsFixed(1), style: const TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold)),
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
              child: Theme(data: Theme.of(context).copyWith(canvasColor: Colors.black),
              child: DropdownButton<String>(                
                value: dropdownButtonText,
                items: <String>['Pizarra', 'Aula', 'Cámara']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: const TextStyle(color: Colors.white)),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownButtonText = newValue!;
                    if (newValue == 'Pizarra') {                      
                      _image = AssetImage('assets/images/BlackboardSpanish.jpg');
                    } else if (newValue == 'Aula') {
                      _image = AssetImage('assets/images/classroom.jpg');
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
    );
  }

  late CameraController controller;
  double _sliderValue = 0.0;
  ImageProvider _image = AssetImage('assets/images/BlackboardSpanish.jpg');
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
    super.dispose();
  }
}

class CameraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CameraScreen(),
    );
  }
}

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  @override
  void initState() {
    super.initState();
    controller = CameraController(cameras[0], ResolutionPreset.medium);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  late CameraController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),        
        actions: <Widget>[
          IconButton(icon: const Icon(Icons.arrow_forward),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => InstructionsPage(),
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
                Text(_sliderValue.toStringAsFixed(1), style: const TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold)),
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
              child : Theme(data: Theme.of(context).copyWith(canvasColor: Colors.black),
              child: DropdownButton<String>(                
                value: dropdownButtonText,
                items: <String>['Pizarra', 'Aula', 'Cámara']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: const TextStyle(color: Colors.white)),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownButtonText = newValue!;
                    if (newValue == 'Pizarra') {
                      _image = AssetImage('assets/images/BlackboardSpanish.jpg');
                    } else if (newValue == 'Aula') {
                      _image = AssetImage('assets/images/classroom.jpg');
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
    );
  }

  double _sliderValue = 0.0;
  ImageProvider _image = AssetImage('assets/images/BlackboardSpanish.jpg');
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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }
}
