import 'package:circle_book/screens/group_main_screen.dart';
import 'package:circle_book/screens/main_group_screen.dart';
import 'package:circle_book/screens/main_books_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(Object context) {
    return MaterialApp(
      home: LandingPage(),
    );
  }
}

class TabPage extends StatefulWidget {
  const TabPage({super.key});

  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  int _selectedIndex = 0; // ó���� ���� ȭ�� ����

  // �̵��� ������
  final List _pages = [
    MainBooksScreen(),
    const MainGroupScreen(),
    const GroupMainScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: _pages[_selectedIndex], // �������� ����
        ),
        bottomNavigationBar: BottomNavigationBar(
          //type: BottomNavigationBarType.fixed, // bottomNavigationBar item�� 4�� �̻��� ���

          onTap: _onItemTapped,

          currentIndex: _selectedIndex,

          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.menu_book_rounded), label: "Books"),
            BottomNavigationBarItem(
                icon: Icon(Icons.groups_rounded), label: "Group"),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_rounded), label: "Profile"),
          ],
        ));
  }

  void _onItemTapped(int index) {
    // state ����
    setState(() {
      _selectedIndex = index;
    });
  }
}
