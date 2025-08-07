import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, Map<String, int>> creditSummary = {};

  Future<void> _loadUploadData() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/upload.json');

    if (!await file.exists()) {
      setState(() {
        creditSummary = {}; // Clear data if file doesn't exist
      });
      return;
    }

    final String content = await file.readAsString();
    final List<dynamic> data = json.decode(content);

    Map<String, Map<String, int>> summary = {};

    for (var item in data) {
      final subject = item['subject'] as String? ?? '';
      final grade = item['grade'] as String? ?? '0';
      final amountStr = item['amount'] as String? ?? '0';

      if (subject.isEmpty || grade == '0') continue;

      final int credits = int.tryParse(amountStr) ?? 0;
      if (credits == 0) continue;

      summary.putIfAbsent(subject, () => {'E': 0, 'M': 0, 'A': 0, 'N': 0});
      if (summary[subject]!.containsKey(grade)) {
        summary[subject]![grade] = summary[subject]![grade]! + credits;
      }
    }

    setState(() {
      creditSummary = summary;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Credit Summary')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:
            creditSummary.isEmpty
                ? const Center(
                  child: Text('No data found. Tap the button to load.'),
                )
                : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('Subject')),
                      DataColumn(label: Text('E')),
                      DataColumn(label: Text('M')),
                      DataColumn(label: Text('A')),
                      DataColumn(label: Text('N')),
                    ],
                    rows:
                        creditSummary.entries.map((entry) {
                          final subject = entry.key;
                          final grades = entry.value;
                          return DataRow(
                            cells: [
                              DataCell(Text(subject)),
                              DataCell(Text('${grades['E'] ?? 0}')),
                              DataCell(Text('${grades['M'] ?? 0}')),
                              DataCell(Text('${grades['A'] ?? 0}')),
                              DataCell(Text('${grades['N'] ?? 0}')),
                            ],
                          );
                        }).toList(),
                  ),
                ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _loadUploadData,
        tooltip: 'Load Data',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
