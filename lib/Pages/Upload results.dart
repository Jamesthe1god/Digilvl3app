import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(), // Needed to make the subject all uppercase so there are no duplicates
      selection: newValue.selection,
    );
  }
}

class _UploadPageState extends State<UploadPage> {
  String dropdownValue = '0';
  String subject = '';
  String standard = '';
  String amount = '0';
  String grade = '0';
  late File jsonFile;
  List<dynamic> upload = [];

  @override
  void initState() {
    super.initState();
    _initFile();
  }

  // Saves locally so I dont loose the information after resetting the page
  Future<void> _initFile() async {
    final dir = await getApplicationDocumentsDirectory();
    jsonFile = File('${dir.path}/upload.json');

    if (!await jsonFile.exists()) {
      // If the file doesn't exist it will create one
      await jsonFile.writeAsString(json.encode([]));
      upload = [];
    } else {
      // Load existing data into the upload list
      final content = await jsonFile.readAsString();
      upload = json.decode(content);
    }
  }

  Future<void> _addUpload(
    String subject,
    String standard,
    String amount,
    String grade,
  ) async {
    upload.add({
      'subject': subject,
      'standard': standard,
      'amount': amount,
      'grade': grade,
    });
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

              // Subject input
              TextField(
                onChanged: (value) => subject = value.toUpperCase(),
                textCapitalization: TextCapitalization.characters,
                inputFormatters: [UpperCaseTextFormatter()],
                decoration: const InputDecoration(
                  labelText: 'Subject (spell in full)',
                  border: OutlineInputBorder(),
                ),
              ),

              // Standard input
              TextField(
                onChanged: (value) => standard = value,
                maxLength: 10,
                decoration: const InputDecoration(
                  labelText: 'Standard Number',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // How many credits dropdown
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
                // All of the values shown on the drop down menu
                items: const [
                  DropdownMenuItem(value: '0', child: Text('0')),
                  DropdownMenuItem(value: '1', child: Text('1')),
                  DropdownMenuItem(value: '2', child: Text('2')),
                  DropdownMenuItem(value: '3', child: Text('3')),
                  DropdownMenuItem(value: '4', child: Text('4')),
                  DropdownMenuItem(value: '5', child: Text('5')),
                  DropdownMenuItem(value: '6', child: Text('6')),
                ],
              ),
              const SizedBox(height: 16),

              // Grade dropdown
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
                  DropdownMenuItem(value: '0', child: Text('Select Type')),
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
                      // Check for duplicate standard
                      final alreadyExists = upload.any(
                        (entry) => entry['standard'] == standard,
                      );

                      if (alreadyExists) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'This standard number has already been added.',
                            ),
                          ),
                        );
                      } else {
                        _addUpload(subject, standard, amount, grade);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Upload saved')),
                        );
                      }
                    }
                  },
                  icon: const Icon(Icons.save),
                  label: const Text('Save'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
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
