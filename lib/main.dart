import 'package:flutter/material.dart';

const Color colorApp = Color.fromRGBO(0, 181, 204, 1);

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'TOEIC APP';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Trang 0: Luyện tập',
      style: optionStyle,
    ),
    Text(
      'Trang 1: Thi',
      style: optionStyle,
    ),
    Text(
      'Trang 2: Lộ trình',
      style: optionStyle,
    ),
    Text(
      'Trang 3: Nâng cấp',
      style: optionStyle,
    ),
    Text(
      'Trang 4: Cài đặt',
      style: optionStyle,
    ),
  ];

  static const List<String> appBarTitle = [
    "Awsome TOEIC",
    "Thi",
    "Lộ trình",
    "Nâng cấp",
    "Cài đặt"
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle.elementAt(_selectedIndex)),
        backgroundColor: colorApp,
        centerTitle: true,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Luyện tập',
            backgroundColor: colorApp,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Thi',
            backgroundColor: colorApp,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.workspaces),
            label: 'Lộ trình',
            backgroundColor: colorApp,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.workspace_premium),
            label: 'Nâng cấp',
            backgroundColor: colorApp,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Cài đặt',
            backgroundColor: colorApp,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[600],
        onTap: _onItemTapped,
      ),
    );
  }
}
