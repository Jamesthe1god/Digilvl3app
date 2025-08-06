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
  String amount = 'Zero';
  String grade = 'Zero';
  late File jsonFile;
  List<dynamic> upload = [];

  @override
  void initState() {
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

  Future<void> _addUpload(String subject, String standard, String amount) async {
    upload.add({'subject': subject, 'standard': standard, 'amount': amount});
    await jsonFile.writeAsString(json.encode(upload));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: const Text('Upload Page')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Enter Details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              /// Subject Input
              TextField(
                onChanged: (value) => subject = value,
                decoration: const InputDecoration(
                  labelText: 'Subject (spell in full)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Standard Input
              TextField(
                onChanged: (value) => standard = value,
                maxLength: 10,
                decoration: const InputDecoration(
                  labelText: 'Standard Number',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Amount Dropdown
              DropdownButtonFormField<String>(
                value: amount,
                decoration: const InputDecoration(
                  labelText: 'How many credits?',
                  border: OutlineInputBorder(),
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    amount = newValue!;
                  });
                },
                items: const [
                  DropdownMenuItem(value: 'Zero', child: Text('Zero')),
                  DropdownMenuItem(value: 'One', child: Text('One')),
                  DropdownMenuItem(value: 'Two', child: Text('Two')),
                  DropdownMenuItem(value: 'Three', child: Text('Three')),
                ],
              ),
              const SizedBox(height: 16),

              /// Grade Dropdown
              DropdownButtonFormField<String>(
                value: grade,
                decoration: const InputDecoration(
                  labelText: 'What type of credits?',
                  border: OutlineInputBorder(),
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    grade = newValue!;
                  });
                },
                items: const [
                  DropdownMenuItem(value: 'Zero', child: Text('Select Type')),
                  DropdownMenuItem(value: 'E', child: Text('E')),
                  DropdownMenuItem(value: 'M', child: Text('M')),
                  DropdownMenuItem(value: 'A', child: Text('A')),
                  DropdownMenuItem(value: 'N', child: Text('N')),
                ],
              ),
              const SizedBox(height: 24),

              // Save Button
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    if (subject.isNotEmpty && standard.isNotEmpty) {
                      _addUpload(subject, standard, amount);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Upload saved')),
                      );
                    }
                  },
                  icon: const Icon(Icons.save),
                  label: const Text('Save'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}