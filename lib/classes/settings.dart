import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});
  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _loadCounter();
    _loadSettings();
    super.initState();
  }
  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  static void muyStatic() {
    _incrementCounter();
  }

  late int countTest = 0;
  void _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      countTest = prefs.getInt('countTest') ?? 0;
    });
  }

  static void _incrementCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int countTest = (prefs.getInt('countTest') ?? 0) + 1;
    prefs.setInt('countTest', countTest);
  }

  Future<String> loadDistanceSetting() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('selectedDistance') ?? '2m';
  }

  Future<String> loadUnitSetting() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('selectedUnit') ?? 'Medida (0.0)';
  }

  void _loadSettings() async {
    selectedDistance = await loadDistanceSetting();
    selectedUnit = await loadUnitSetting();
    setState(() {});
  }

  void _saveDistanceSetting(String distance) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('selectedDistance', distance);
  }

  void _saveUnitSetting(String unit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('selectedUnit', unit);
  }

  String selectedDistance = '';
  String selectedUnit = '';

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        Navigator.popUntil(context, ModalRoute.withName('/'));
        return false;
      },
      child: Scaffold(
      appBar: AppBar(
        title: const Text('Ajustes'),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () async {
              Navigator.popUntil(context, ModalRoute.withName('/'));
            },
          ),
      ),
      body: ListView(
        children: [
          buildListTile('Distancia de prueba', selectedDistance, () {
            _showDistanceOptions(context);
          }),
          buildListTile('Unidades', selectedUnit, () {
            _showUnitsOptions(context);
          }),
          buildListTile('Tests Completados', '$countTest', () {}),
          buildListTileWithButton('Enviar feedback anónimo', () {}),
          buildListTile('Versión', '3.7.0', () {}),
        ],
      ),
      ),
    );
  }

  ListTile buildListTile(String title, String subtitle, VoidCallback onTap) {
    return ListTile(
      leading: const Icon(Icons.info),
      title: Text(title),
      subtitle: Text(subtitle),
      onTap: onTap,
    );
  }

  ListTile buildListTileWithButton(String title, VoidCallback onTap) {
    return ListTile(
      leading: const Icon(Icons.feedback),
      title: Text(title),
      onTap: onTap,
    );
  }

  void _showDistanceOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 200,
          child: Column(
            children: [
              const ListTile(
                title: Text('Selecciona la distancia de prueba'),
              ),
              RadioListTile(
                title: const Text('1m'),
                value: '1m',
                groupValue: selectedDistance,
                onChanged: (value) {
                  setState(() {
                    selectedDistance = value.toString();
                  });
                  _saveDistanceSetting(selectedDistance);
                  Navigator.pop(context);
                },
              ),
              RadioListTile(
                title: const Text('2m'),
                value: '2m',
                groupValue: selectedDistance,
                onChanged: (value) {
                  setState(() {
                    selectedDistance = value.toString();
                  });
                  _saveDistanceSetting(selectedDistance);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showUnitsOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 250,
          child: Column(
            children: [
              const ListTile(
                title: Text('Selecciona la medida'),
              ),
              RadioListTile(
                title: const Text('Medida (0.0)'),
                value: 'Medida (0.0)',
                groupValue: selectedUnit,
                onChanged: (value) {
                  setState(() {
                    selectedUnit = value.toString();
                  });
                  _saveUnitSetting(selectedUnit);
                  Navigator.pop(context);
                },
              ),
              RadioListTile(
                title: const Text('Medida (6/6)'),
                value: 'Medida (6/6)',
                groupValue: selectedUnit,
                onChanged: (value) {
                  setState(() {
                    selectedUnit = value.toString();
                  });
                  _saveUnitSetting(selectedUnit);
                  Navigator.pop(context);
                },
              ),
              RadioListTile(
                title: const Text('Medida (20/20)'),
                value: 'Medida (20/20)',
                groupValue: selectedUnit,
                onChanged: (value) {
                  setState(() {
                    selectedUnit = value.toString();
                  });
                  _saveUnitSetting(selectedUnit);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
