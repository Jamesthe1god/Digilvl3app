import 'package:flutter/material.dart';
import 'package:my_project/Pages/Qualifications.dart';
import 'package:my_project/Pages/Home page (dashboard).dart';
import 'package:my_project/Pages/Upload results.dart';
//Imported all of the pages so it can call upon them

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  final List<Widget> pages = [
    const HomePage(),
    const QualificationsPage(),
    const UploadPage(),
  ];

  int currentpage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentpage],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentpage,
        onTap: (value) {setState(() {      //When it is clicked it will change to which ever value you clicked
          currentpage = value;
        });},
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home",),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: "Qualifications",),
          BottomNavigationBarItem(icon: Icon(Icons.file_upload_outlined), label: "Upload Results",),
        ], // This Items list is the list of the different pages and how they are displayed in the navigationbar
      ),
    );
  }
}
