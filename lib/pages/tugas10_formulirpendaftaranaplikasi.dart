import 'package:flutter/material.dart' show Widget, BuildContext, StatelessWidget, Text, EdgeInsets, TextStyle, AppBar, TextAlign, FontWeight, Padding, Center, Scaffold;

class HalamanKonfirmasi extends StatelessWidget {
  final String nama;
  final String kota;

  const HalamanKonfirmasi({super.key, required this.nama, required this.kota});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Konfirmasi Pendaftaran')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(
            'Terima kasih, $nama dari $kota telah mendaftar.',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
