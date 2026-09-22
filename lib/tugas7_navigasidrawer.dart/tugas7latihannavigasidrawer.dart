import 'package:flutter/material.dart';

void main() {
  runApp(const Tugas7NavigasiDrawer());
}

class Tugas7NavigasiDrawer extends StatelessWidget {
  const Tugas7NavigasiDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tugas 7 Flutter',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Simpan variabel state di dalam State class
  bool isChecked = false;
  bool isDarkMode = false;
  String? selectedCategory;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  // =========================
  // DATE PICKER
  // =========================
  Future<void> pilihTanggal() async {
    final DateTime? tanggal = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (tanggal != null) {
      setState(() {
        selectedDate = tanggal;
      });
    }
  }

  // =========================
  // TIME PICKER
  // =========================
  Future<void> pilihWaktu() async {
    final TimeOfDay? waktu = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 7, minute: 30),
    );

    if (waktu != null) {
      setState(() {
        selectedTime = waktu;
      });
    }
  }

  // =========================
  // FORMAT TANGGAL
  // =========================
  String formatTanggal(DateTime tanggal) {
    const bulan = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];

    return '${tanggal.day} ${bulan[tanggal.month - 1]} ${tanggal.year}';
  }

  // =========================
  // FORMAT WAKTU
  // =========================
  String formatWaktu(TimeOfDay waktu) {
    final hour = waktu.hour.toString().padLeft(2, '0');
    final minute = waktu.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tugas 7 Flutter - Form Components')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Contoh implementasi fungsi yang sudah dibuat:
            ElevatedButton(
              onPressed: pilihTanggal,
              child: Text(
                selectedDate == null
                    ? 'Pilih Tanggal'
                    : 'Tanggal: ${formatTanggal(selectedDate!)}',
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: pilihWaktu,
              child: Text(
                selectedTime == null
                    ? 'Pilih Waktu'
                    : 'Waktu: ${formatWaktu(selectedTime!)}',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
