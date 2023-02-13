import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toeic_app/test_page.dart';
import 'package:toeic_app/upgrade_page.dart';
import 'practice_page.dart';
import 'settings_page.dart';
import 'constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = (prefs.getBool('DarkMode') ?? false);
      changeColorByTheme();
    });
  }

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static List<Widget> _widgetOptions = <Widget>[
    Practice(),
    Test(),
    Text(
      'Trang 2: Lộ trình',
      style: optionStyle,
    ),
    UpgradePage(),
    SettingsPage()
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
      body: _widgetOptions[_selectedIndex],
      // body: Practice(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: bottomNavColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Luyện tập',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Thi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.workspaces),
            label: 'Lộ trình',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.workspace_premium),
            label: 'Nâng cấp',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Cài đặt',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: orange,
        unselectedItemColor: textNav,
        onTap: _onItemTapped,
      ),
    );
  }
}
