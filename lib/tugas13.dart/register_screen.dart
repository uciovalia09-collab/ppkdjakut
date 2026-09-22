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

  // Variabel untuk melacak ID user yang sedang diedit (null jika mode Tambah)
  int? _selectedUserId;

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

  // Fungsi untuk mengisi form saat mode Edit aktif
  void _prepareEdit(UserModel user) {
    setState(() {
      _selectedUserId = user.id;
      _namaController.text = user.nama;
      _emailController.text = user.email;
      _hpController.text = user.nomorHp;
      _passwordController.text = user.password;
      _kotaController.text = user.asalKota;
    });
  }

  // Mereset form dan mengembalikan ke mode Tambah
  void _resetForm() {
    _formKey.currentState!.reset();
    _namaController.clear();
    _emailController.clear();
    _hpController.clear();
    _passwordController.clear();
    _kotaController.clear();
    setState(() {
      _selectedUserId = null;
    });
  }

  // Logika Simpan (Bisa berupa Insert Baru atau Update)
  void _submitData() async {
    if (_formKey.currentState!.validate()) {
      UserModel user = UserModel(
        id: _selectedUserId, // Jika null berarti insert, jika ada isinya berarti update
        nama: _namaController.text,
        email: _emailController.text,
        nomorHp: _hpController.text,
        password: _passwordController.text,
        asalKota: _kotaController.text,
      );

      if (_selectedUserId == null) {
        // Proses Insert
        await _dbHelper.insertUser(user);
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Pendaftaran Berhasil Disimpan!')),
        );
      } else {
        // Proses Update
        await _dbHelper.updateUser(user);
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data Berhasil Diperbarui!')),
        );
      }

      _resetForm();
      _refreshUserList();
    }
  }

  // Dialog Konfirmasi Hapus Data
  void _confirmDelete(int id, String nama) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi Hapus'),
          content: Text('Apakah Anda yakin ingin menghapus data "$nama"?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                await _dbHelper.deleteUser(id);
                _refreshUserList();
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Data Berhasil Dihapus'),
                    backgroundColor: Colors.redAccent,
                  ),
                );
              },
              child: const Text(
                'Ya, Hapus',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isEditing = _selectedUserId != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? 'Edit Data Pengguna' : 'Pendaftaran User (SQFlite)',
        ),
        backgroundColor: isEditing ? Colors.orangeAccent : Colors.blue,
      ),
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
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                            backgroundColor: isEditing
                                ? Colors.orange
                                : Colors.blue,
                            foregroundColor: Colors.white,
                          ),
                          onPressed: _submitData,
                          child: Text(
                            isEditing ? 'Perbarui Data' : 'Daftar & Simpan',
                          ),
                        ),
                      ),
                      if (isEditing) ...[
                        const SizedBox(width: 10),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size(80, 50),
                          ),
                          onPressed: _resetForm,
                          child: const Text('Batal'),
                        ),
                      ],
                    ],
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

            // Real-time List menggunakan FutureBuilder dengan Tombol Edit & Delete
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
                          // Tombol Aksi (Edit & Delete)
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                                onPressed: () => _prepareEdit(user),
                                tooltip: 'Edit',
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () =>
                                    _confirmDelete(user.id!, user.nama),
                                tooltip: 'Hapus',
                              ),
                            ],
                          ),
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
