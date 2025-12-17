import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Text('Bem-vindo ao The Anxiety Club!'),
          SizedBox(height: 32),
          Text('Aqui você acompanha seus clubes de leitura'),
        ],
      ),
    );
  }
}
