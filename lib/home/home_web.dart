import 'package:flutter/material.dart';
import '../widgets/sidebar.dart';
import '../profile/profile_page.dart';
import '../settings/settings_page.dart';

class HomeWeb extends StatefulWidget {
  const HomeWeb({super.key, required this.title});

  final String title;

  @override
  State<HomeWeb> createState() => _HomeWebState();
}

class _HomeWebState extends State<HomeWeb> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const ProfilePage(),
    const SettingsPage(),
  ];

  void _onItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onLogout() {
    // TODO: Implementar logout
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Logout realizado')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Sidebar(
            selectedIndex: _selectedIndex,
            onItemSelected: _onItemSelected,
            onLogout: _onLogout,
          ),
          Expanded(
            child: _pages[_selectedIndex],
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('The Anxiety Club'),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Bem-vindo ao The Anxiety Club!'),
            const SizedBox(height: 32),
            const Text('Aqui você acompanha seus clubes de leitura'),
          ],
        ),
      ),
    );
  }
}
