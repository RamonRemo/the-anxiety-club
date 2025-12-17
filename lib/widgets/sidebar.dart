import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;
  final VoidCallback onLogout;

  const Sidebar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      selectedIndex: selectedIndex,
      onDestinationSelected: onItemSelected,
      
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'The Anxiety Club',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        const Divider(),
        NavigationDrawerDestination(
          icon: const Icon(Icons.home),
          label: const Text('Home'),
        ),
        NavigationDrawerDestination(
          icon: const Icon(Icons.person),
          label: const Text('Perfil'),
        ),
        NavigationDrawerDestination(
          icon: const Icon(Icons.chat),
          label: const Text('Chat'),
        ),
        NavigationDrawerDestination(
          icon: const Icon(Icons.settings),
          label: const Text('Configurações'),
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: onLogout,
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
              foregroundColor: Theme.of(context).colorScheme.onError,
              minimumSize: const Size(double.infinity, 48),
            ),
            child: const Text('Logout'),
          ),
        ),
      ],
    );
  }
}
