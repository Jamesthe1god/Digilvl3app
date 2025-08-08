import 'package:flutter/material.dart';

class QualificationsPage extends StatelessWidget {
  const QualificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NCEA Requirements',
      home: Scaffold(
        appBar: AppBar(
          title: Text('NCEA Level 2, 3 & UE Requirements'), //Title of page
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Level 2 Requirements',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text('• Achieve at least 60 credits at Level 2 or above.'),
                Text('• Gain 20 additional credits from any level (Level 1, 2, or 3).'),
                Text('• Meet the literacy requirement (10 credits at Level 1 or above).'),
                Text('• Meet the numeracy requirement (10 credits at Level 1 or above).'),

                SizedBox(height: 24),
                Text(
                  'Level 3 Requirements',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text('• Achieve at least 60 credits at Level 3.'),
                Text('• Gain 20 additional credits from Level 2 or above.'),
                Text('• Must have already met the Level 1 literacy and numeracy requirements.'),

                SizedBox(height: 24),
                Text(
                  'University Entrance (UE) Requirements',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text('• Achieve NCEA Level 3.'),
                Text('• Achieve 14 credits in each of three approved subjects.'),
                Text('• Gain UE literacy:'),
                Text('   • 10 credits at Level 2 or above 5 reading & 5 writing.'),
                Text('• Gain UE numeracy:'),
                Text('   • 10 numeracy credits at Level 1 or above.'),

                SizedBox(height: 24),
                Text(
                  'Endorsement Requirements',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text('• Certificate Endorsement with Merit:'),
                Text('   • At least 50 credits at Merit or better at the certificate level or above.'),
                Text('• Certificate Endorsement with Excellence:'),
                Text('   • At least 50 credits at Excellence at the certificate level or above.'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}