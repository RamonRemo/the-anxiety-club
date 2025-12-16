import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:the_anxiety_club/home/home_web.dart';
import 'package:the_anxiety_club/home/home_app.dart';


class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return kIsWeb ? HomeWeb(title: title) : HomeApp(title: title);
  }
}
