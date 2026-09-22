import 'package:flutter/material.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();

  // Controller untuk mengambil data dari input field
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nomorHpController = TextEditingController();
  final TextEditingController _kotaController = TextEditingController();

  @override
  void dispose() {
    _namaController.dispose();
    _emailController.dispose();
    _nomorHpController.dispose();
    _kotaController.dispose();
    super.dispose();
  }

  void _submitForm() {
    // Validasi state formulir
    if (_formKey.currentState!.validate()) {
      // Ambil nilai dari controller
      String nama = _namaController.text;
      String email = _emailController.text;
      String nomorHp = _nomorHpController.text.isEmpty
          ? 'Tidak diisi'
          : _nomorHpController.text;
      String kota = _kotaController.text;

      // Tampilkan AlertDialog ringkasan data
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Ringkasan Data Pendaftaran'),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text('Nama: $nama'),
                  const SizedBox(height: 8),
                  Text('Email: $email'),
                  const SizedBox(height: 8),
                  Text('Nomor HP: $nomorHp'),
                  const SizedBox(height: 8),
                  Text('Kota Asal: $kota'),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Tutup Dialog
                },
                child: const Text('Batal'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Tutup Dialog dulu

                  // Navigasi ke Halaman Konfirmasi dengan membawa data
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ConfirmationPage(nama: nama, kota: kota),
                    ),
                  );
                },
                child: const Text('Lanjut'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulir Pendaftaran'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Field Nama Lengkap (Wajib)
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(
                  labelText: 'Nama Lengkap *',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama lengkap wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Field Email (Wajib & mengandung @)
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email *',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Email wajib diisi';
                  }
                  if (!value.contains('@')) {
                    return 'Email harus mengandung karakter @';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Field Nomor HP (Boleh kosong)
              TextFormField(
                controller: _nomorHpController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Nomor HP (Opsional)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                ),
              ),
              const SizedBox(height: 16),

              // Field Tambahan: Kota Asal (Wajib)
              TextFormField(
                controller: _kotaController,
                decoration: const InputDecoration(
                  labelText: 'Kota Asal *',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.location_city),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Kota asal wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Tombol Daftar
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Daftar', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Halaman Konfirmasi Pendaftaran
class ConfirmationPage extends StatelessWidget {
  final String nama;
  final String kota;

  const ConfirmationPage({super.key, required this.nama, required this.kota});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Konfirmasi Pendaftaran')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(
            'Terima kasih, $nama dari $kota telah mendaftar.',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

