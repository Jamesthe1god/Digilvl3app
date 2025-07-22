import 'package:flutter/material.dart';

class UploadPage extends StatelessWidget {
  const UploadPage ({super.key})
  String dropdownValue = '3';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sample Code')),
      body: Center(
          child: DropdownButton<String>(
            value: dropdownValue,
            icon: const Icon(Icons.arrow_downward),
            style: const TextStyle(color: Colors.white),
            underline: Container(
              height: 2,
              color: Colors.white,
            ),
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
              })
            },
        )
      )
    );
  }
}