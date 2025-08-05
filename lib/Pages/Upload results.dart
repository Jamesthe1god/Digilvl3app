import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  String dropdownValue = 'Zero';
  String subject = '';
  String standard = '';
  late File jsonFile;
  List<dynamic> upload = [];

  @override
  void initSate() {
    super.initState();
    _initFile();
  }

  Future<void> _initFile() async {
    final dir = await getApplicationDocumentsDirectory();
    jsonFile = File('${dir.path}/upload.json');

    if (!await jsonFile.exists()) {
      await jsonFile.writeAsString(json.encode([]));
    }
  }

  Future<void> _addUpload(String subject, String standard) async {
    upload.add({'subject': subject, 'standard': standard});
    await jsonFile.writeAsString(json.encode(upload)); //sorts the file 
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: const Text('app')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: TextField(
                  onChanged:
                      (value) =>
                          subject =
                              value, //When changed it will add it to the variable
                  decoration: const InputDecoration(
                    label: Text('Subject (spell in full)'),
                  ),
                ),
              ),
              Container(
                child: TextField(
                  onChanged: (value) => standard = value,
                  maxLength: 10,
                  decoration: const InputDecoration(
                    label: Text('Standard Number'),
                  ),
                ),
              ),
              Container(
                child: DropdownButton<String>(
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_downward),
                  style: const TextStyle(color: Colors.black54),
                  underline: Container(height: 2, color: Colors.blue),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                  items: const [
                    DropdownMenuItem<String>(
                      value: 'Zero',
                      child: Text('How many credits?'),
                    ),
                    DropdownMenuItem<String>(value: 'One', child: Text('One')),
                    DropdownMenuItem<String>(value: 'Two', child: Text('Two')),
                    DropdownMenuItem<String>(
                      value: 'Three',
                      child: Text('Three'),
                    ),
                  ],
                ),
              ),
              Container(
                child: ElevatedButton(
                  onPressed: () {
                    if (subject.isNotEmpty && standard.isNotEmpty) {
                      _addUpload(subject, standard);
                    }
                  },
                  child: const Text('save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
