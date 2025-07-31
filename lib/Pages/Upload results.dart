import 'package:flutter/material.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  String dropdownValue = 'Zero';


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
                    decoration: const InputDecoration(
                        label: Text('Subject (spell in full)')
                    ),)
              ),
              Container(
                  child: TextField(
                    maxLength: 10,
                    decoration: const InputDecoration(
                        label: Text('Standard Number')
                    ),)
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
            ],
          ),
        ),
      ),
    );
  }
}
