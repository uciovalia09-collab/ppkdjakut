import 'package:flutter/material.dart';
import 'package:ppkdjakut/navigation.dart';
import 'package:ppkdjakut/preference_handier.dart';
import 'package:ppkdjakut/preference_handler.dart';

// Ubah jalur import ini agar sesuai dengan letak file di folder lib/
import 'homescreen.dart';
import 'loginscreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkSession();
  }

  Future<void> _checkSession() async {
    // Delay selama 2 detik
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;
    if (PreferenceHandler.isLogin == true) {
      context.pushAndRemoveAll(HomeScreen());
    } else {
      context.pushAndRemoveAll(LoginScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlutterLogo(size: 100),
            SizedBox(height: 24),
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text(
              'Memuat Aplikasi...',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
