import 'package:flutter/material.dart';
import 'package:ghibli_movie_site/custom_widgets/custom_scroll.dart';
import 'package:ghibli_movie_site/views/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
      useMaterial3: true,
    );

    return MaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      title: 'Ghibli Movies',
      theme: theme,
      home: const HomeView(),
    );
  }
}
