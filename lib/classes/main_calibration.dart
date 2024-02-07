import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';

class MainCalibrationPage extends StatefulWidget {
  const MainCalibrationPage({super.key});

  @override
  MainCalibrationPageState createState() => MainCalibrationPageState();
}

class MainCalibrationPageState extends State<MainCalibrationPage> {
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    _loadCheckboxState();
  }

  _loadCheckboxState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isChecked = prefs.getBool('isChecked') ?? false;
    });
  }

  _saveCheckboxState(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isChecked', value);
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
            const SizedBox(height: 30),
            Container(
              height: 90,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Text(
                      "Comprobar Calibracion",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 100),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                constraints: const BoxConstraints(
                                  maxHeight: 300,
                                  maxWidth: 300,
                                ),
                                child: const Text(
                                  'Con una regla, comprueba la anchura y la altura de la E. Para que la prueba sea válida, ambas deben medir entre 38 mm y 42 mm. ',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Checkbox(
                                    value: isChecked,
                                    onChanged: (value) {
                                      setState(() {
                                        isChecked = value!;
                                        _saveCheckboxState(value);
                                      });
                                    },
                                  ),
                                  const Text(
                                      'He comprobado la altura y el ancho de la E'),
                                ],
                              ),
                              if (isChecked)
                                ElevatedButton(
                                  onPressed: () async {
                                    Navigator.popUntil(context, ModalRoute.withName('/'));
                                  },
                                  child: const Text('Confirmar'),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),
                        Container(
                          color: Colors.black,
                          width: 250,
                          height: 250,
                          child: Transform.rotate(
                            angle: 0,
                            child: Image.asset(
                              'assets/images/letter.jpg',
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
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
