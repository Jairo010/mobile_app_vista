import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../main.dart';
import 'settings.dart';

class ResultWidget extends StatefulWidget {
  final double size;
  const ResultWidget({super.key, required this.size});
  @override
  ResultWidgetPageState createState() => ResultWidgetPageState(size: size);
}

class ResultWidgetPageState extends State<ResultWidget> {
  double size;

  ResultWidgetPageState({required this.size});

  @override
  void initState() {
    cargarDistancia();
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  String selectedUnit = '';
  String sizeFinal = '';
  SettingsPageState settingsDistance = SettingsPageState();

  void cargarDistancia() {
    settingsDistance.loadUnitSetting().then((value) {
      setState(() {
        selectedUnit = value;
        if (size == 0.0 && selectedUnit == 'Medida (0.0)' || (size > 0.0 && selectedUnit == 'Medida (0.0)')) {
          sizeFinal = '0.0';
          if (size > 0.0) {
            sizeFinal = size.toString();
          }
        } else {
          if (size == 0.0 && selectedUnit == 'Medida (6/6)' || (size > 0.0 && selectedUnit == 'Medida (6/6)')) {
            sizeFinal = '6/6';
            if (size > 0.0) {
              sizeFinal = '6/${((size * 10) * 6).toStringAsFixed(0)}';
            }
          } else {
            if (size == 0.0 && selectedUnit == 'Medida (20/20)' || (size > 0.0 && selectedUnit == 'Medida (20/20)')) {
              sizeFinal = '20/20';
              if (size > 0.0) {
                sizeFinal = '20/${((size * 10) * 20).toStringAsFixed(0)}';
              }
            }
          }
        }
      });
    });
  }

  void setResutls(String currentLevel) {
    if (size == 0.0 && currentLevel == 'Medida (0.0)' || (size > 0.0 && currentLevel == 'Medida (0.0)')) {
      sizeFinal = '0.0';
      if (size > 0.0) {
        sizeFinal = size.toString();
      }
    } else {
      if (size == 0.0 && currentLevel == 'Medida (6/6)' || (size > 0.0 && currentLevel == 'Medida (6/6)')) {
        sizeFinal = '6/6';
        if (size > 0.0) {
          sizeFinal = '6/${((size * 10) * 6).toStringAsFixed(0)}';
        }
      } else {
        if (size == 0.0 && currentLevel == 'Medida (20/20)' || (size > 0.0 && currentLevel == 'Medida (20/20)')) {
          sizeFinal = '20/20';
          if (size > 0.0) {
            sizeFinal = '20/${((size * 10) * 20).toStringAsFixed(0)}';
          }
          int.parse('2');
        }
      }
    }
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Container(
            height: 80,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Text(
                    "Resultados",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      SettingsPageState.muyStatic();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyApp(),
                        ),
                      );
                    },
                    child: const Text("Hecho"),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Container(
            height: 80,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: IconButton(
                    icon: const Icon(Icons.settings),
                    onPressed: () {
                      showSettingsMenu(context);
                    },
                    color: const Color.fromARGB(255, 75, 72, 72),
                    iconSize: 40,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 100),
          Center(
            child: Container(
              width: 170,
              height: 170,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    sizeFinal,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Column(
            children: [
              Text(
                'TU VISION',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )
        ],
      ),
      ),
    );
  }

  void showSettingsMenu(BuildContext context) {
    showMenu<String>(
      context: context,
      position: const RelativeRect.fromLTRB(120, 120, 0, 0),
      items: <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'Medida (0.0)',
          child: RadioListTile<String>(
            title: const Text('En medida (0.0)'),
            value: 'Medida (0.0)',
            groupValue: selectedUnit,
            onChanged: (value) {
              setState(() {
                selectedUnit = value!;
              });
              setResutls(selectedUnit);
              Navigator.pop(context);
            },
          ),
        ),
        PopupMenuItem<String>(
          value: 'Medida (6/6)',
          child: RadioListTile<String>(
            title: const Text('En medida (6/6)'),
            value: 'Medida (6/6)',
            groupValue: selectedUnit,
            onChanged: (value) {
              setState(() {
                selectedUnit = value!;
              });
              setResutls(selectedUnit);
              Navigator.pop(context);
            },
          ),
        ),
        PopupMenuItem<String>(
          value: 'Medida (20/20)',
          child: RadioListTile<String>(
            title: const Text('En medida (20/20)'),
            value: 'Medida (20/20)',
            groupValue: selectedUnit,
            onChanged: (value) {
              setState(() {
                selectedUnit = value!;
              });
              setResutls(selectedUnit);
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }
}
