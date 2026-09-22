import 'package:flutter/material.dart';
import 'package:ppkdjakut/tugas12.dart/flutterpubget.dart';

import 'database_helper.dart';
import 'user_model.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _emailController = TextEditingController();
  final _hpController = TextEditingController();
  final _passwordController = TextEditingController();
  final _kotaController = TextEditingController();

  final DatabaseHelper _dbHelper = DatabaseHelper();
  late Future<List<UserModel>> _userListFuture;

  @override
  void initState() {
    super.initState();
    _refreshUserList();
  }

  // Memperbarui data list dari database
  void _refreshUserList() {
    setState(() {
      _userListFuture = _dbHelper.getUsers();
    });
  }

  @override
  void dispose() {
    _namaController.dispose();
    _emailController.dispose();
    _hpController.dispose();
    _passwordController.dispose();
    _kotaController.dispose();
    super.dispose();
  }

  void _submitData() async {
    if (_formKey.currentState!.validate()) {
      UserModel newUser = UserModel(
        nama: _namaController.text,
        email: _emailController.text,
        nomorHp: _hpController.text,
        password: _passwordController.text,
        asalKota: _kotaController.text,
      );

      await _dbHelper.insertUser(newUser);

      // Bersihkan form setelah disimpan
      _formKey.currentState!.reset();
      _namaController.clear();
      _emailController.clear();
      _hpController.clear();
      _passwordController.clear();
      _kotaController.clear();

      // Perbarui tampilan list secara real-time
      _refreshUserList();

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pendaftaran Berhasil Disimpan!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pendaftaran User (SQFlite)')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Form Input
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _namaController,
                    decoration: const InputDecoration(
                      labelText: 'Nama Lengkap',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        value!.isEmpty ? 'Nama tidak boleh kosong' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => value!.isEmpty || !value.contains('@')
                        ? 'Masukkan email yang valid'
                        : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _hpController,
                    decoration: const InputDecoration(
                      labelText: 'Nomor HP',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) =>
                        value!.isEmpty ? 'Nomor HP tidak boleh kosong' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                    validator: (value) => value!.length < 6
                        ? 'Password minimal 6 karakter'
                        : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _kotaController,
                    decoration: const InputDecoration(
                      labelText: 'Asal Kota',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        value!.isEmpty ? 'Asal kota tidak boleh kosong' : null,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                    ),
                    onPressed: _submitData,
                    child: const Text('Daftar & Simpan'),
                  ),
                ],
              ),
            ),
            const Divider(height: 40, thickness: 2),
            const Text(
              'Daftar Pengguna Terdaftar:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Real-time List menggunakan FutureBuilder
            SizedBox(
              height: 250,
              child: FutureBuilder<List<UserModel>>(
                future: _userListFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Terjadi kesalahan: ${snapshot.error}'),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text('Belum ada data pendaftaran.'),
                    );
                  }

                  final users = snapshot.data!;
                  return ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final user = users[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text(user.nama[0].toUpperCase()),
                          ),
                          title: Text(
                            user.nama,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            '${user.email} - ${user.asalKota}\nHP: ${user.nomorHp}',
                          ),
                          isThreeLine: true,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
