import 'package:flutter/material.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  String dropdownValue = 'One';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Sample Code')),
        body: Center(
            child: DropdownButton<String>(
              value: dropdownValue,
              icon: const Icon(Icons.arrow_downward),
              style: const TextStyle(color: Colors.black54),
              underline: Container(
                height: 2,
                color: Colors.blue,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              items: const[
                DropdownMenuItem<String>(
                  value: 'One',
                  child: Text('One'),
                ),
                DropdownMenuItem<String>(
                    value: 'Two',
                    child: Text('Two')
                ),
                DropdownMenuItem<String>(
                  value: 'Three',
                  child: Text('Three'),
                )
              ],
            )
        )
    );
  }
}
