import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ResultWidget extends StatefulWidget {
  final double size;
  const ResultWidget({Key? key, required this.size}) : super(key: key);
  @override
  ResultWidgetPageState createState() => ResultWidgetPageState(size: size);
}

class ResultWidgetPageState extends State<ResultWidget> {
  String? _selectedOption;

  final double size;

  ResultWidgetPageState({required this.size});

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      // Acción del botón
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
              width: 150,
              height: 150,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$size',
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
    );
  }
  void showSettingsMenu(BuildContext context) {
    showMenu<String>(
      context: context,
      position: const RelativeRect.fromLTRB(120, 120, 0, 0),
      items: <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'option1',
          child: RadioListTile<String>(
            title: const Text('Opción 1'),
            value: 'option1',
            groupValue: _selectedOption,
            onChanged: (value) {
              setState(() {
                _selectedOption = value;
              });
              Navigator.pop(context);
            },
          ),
        ),
        PopupMenuItem<String>(
          value: 'option2',
          child: RadioListTile<String>(
            title: const Text('Opción 2'),
            value: 'option2',
            groupValue: _selectedOption,
            onChanged: (value) {
              setState(() {
                _selectedOption = value;
              });
              Navigator.pop(context);
            },
          ),
        ),
        PopupMenuItem<String>(
          value: 'option3',
          child: RadioListTile<String>(
            title: const Text('Opción 3'),
            value: 'option3',
            groupValue: _selectedOption,
            onChanged: (value) {
              setState(() {
                _selectedOption = value;
              });
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }
}
