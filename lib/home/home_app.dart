import 'package:flutter/material.dart';
import '../widgets/sidebar.dart';
import '../profile/profile_page.dart';
import '../settings/settings_page.dart';

class HomeApp extends StatefulWidget {
  const HomeApp({super.key, required this.title});

  final String title;

  @override
  State<HomeApp> createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
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
      drawer: Sidebar(
        selectedIndex: _selectedIndex,
        onItemSelected: _onItemSelected,
        onLogout: _onLogout,
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: _pages[_selectedIndex],
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('Bem-vindo ao The Anxiety Club!'),
          const SizedBox(height: 32),
          const Text('Aqui você acompanha seus clubes de leitura'),
        ],
      ),
    );
  }
}
