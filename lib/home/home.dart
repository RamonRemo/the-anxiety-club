import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/sidebar.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({
    super.key,
    required this.title,
    required this.navigationShell,
  });

  final String title;
  final StatefulNavigationShell navigationShell;

  void _onItemSelected(int index) {
    // Navegar usando navigationShell sem adicionar ao histórico
    navigationShell.goBranch(index);
  }

  void _onLogout(BuildContext context) {
    // TODO: Implementar logout
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Logout realizado')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWideScreen = constraints.maxWidth >= 600;

        if (isWideScreen) {
          return _DesktopLayout(
            title: title,
            selectedIndex: navigationShell.currentIndex,
            child: navigationShell,
            onItemSelected: _onItemSelected,
            onLogout: () => _onLogout(context),
          );
        }

        return _MobileLayout(
          title: title,
          selectedIndex: navigationShell.currentIndex,
          child: navigationShell,
          onItemSelected: _onItemSelected,
          onLogout: () => _onLogout(context),
        );
      },
    );
  }
}


// Layout para telas grandes (web/desktop) - sidebar sempre visível
class _DesktopLayout extends StatelessWidget {
  final String title;
  final int selectedIndex;
  final Widget child;
  final Function(int) onItemSelected;
  final VoidCallback onLogout;

  const _DesktopLayout({
    required this.title,
    required this.selectedIndex,
    required this.child,
    required this.onItemSelected,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Sidebar(
            selectedIndex: selectedIndex,
            onItemSelected: onItemSelected,
            onLogout: onLogout,
          ),
          Expanded(
            child: Column(
              children: [
                if (!kIsWeb)
                  AppBar(
                    backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                    title: Text(title),
                    automaticallyImplyLeading: false,
                  ),
                Expanded(child: child),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Layout para mobile - sidebar como drawer
class _MobileLayout extends StatelessWidget {
  final String title;
  final int selectedIndex;
  final Widget child;
  final Function(int) onItemSelected;
  final VoidCallback onLogout;

  const _MobileLayout({
    required this.title,
    required this.selectedIndex,
    required this.child,
    required this.onItemSelected,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Sidebar(
        selectedIndex: selectedIndex,
        onItemSelected: onItemSelected,
        onLogout: onLogout,
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: child,
    );
  }
}
