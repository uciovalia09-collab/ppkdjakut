import 'package:flutter/material.dart';
import 'package:ppkdjakut/preference_handler.dart';
import 'package:ppkdjakut/tugas11.dart/splashscreen.dart';
import 'package:ppkdjakut/tugas12.dart/register_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferenceHandler.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Pendaftaran SQFlite',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
