import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Tema Escuro'),
            trailing: Switch(
              value: true,
              onChanged: (value) {
                // Implementar mudança de tema
              },
            ),
          ),
          ListTile(
            title: const Text('Notificações'),
            trailing: Switch(
              value: true,
              onChanged: (value) {
                // Implementar notificações
              },
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text('Privacidade'),
            onTap: () {
              // Ir para página de privacidade
            },
          ),
          ListTile(
            title: const Text('Sobre'),
            onTap: () {
              // Ir para página sobre
            },
          ),
        ],
      ),
    );
  }
}
