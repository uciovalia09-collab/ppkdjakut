// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class Tugas6LoginScreen extends StatelessWidget {
//   const Tugas6LoginScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Tugas 7 Flutter',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
//         useMaterial3: true,
//       ),
//       home: const HomePage(),
//     );
//   }
// }

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   // Menu yang dipilih
//   String menuAktif = 'Checkbox';

//   // Variabel Checkbox
//   bool setuju = false;

//   // Variabel Switch
//   bool modeGelap = false;

//   // Variabel Dropdown
//   String? kategori;

//   // Variabel Date Picker
//   DateTime? tanggalLahir;

//   // Variabel Time Picker
//   TimeOfDay? waktuPengingat;

//   // Fungsi untuk memilih tanggal
//   Future<void> pilihTanggal() async {
//     final DateTime? tanggal = await showDatePicker(
//       context: context,
//       initialDate: DateTime(2000),
//       firstDate: DateTime(1900),
//       lastDate: DateTime.now(),
//     );

//     if (tanggal != null) {
//       setState(() {
//         tanggalLahir = tanggal;
//       });
//     }
//   }

//   // Fungsi untuk memilih waktu
//   Future<void> pilihWaktu() async {
//     final TimeOfDay? waktu = await showTimePicker(
//       context: context,
//       initialTime: const TimeOfDay(hour: 7, minute: 30),
//     );

//     if (waktu != null) {
//       setState(() {
//         waktuPengingat = waktu;
//       });
//     }
//   }

//   // Fungsi format tanggal Bahasa Indonesia
//   String formatTanggal(DateTime tanggal) {
//     const List<String> namaBulan = [
//       'Januari',
//       'Februari',
//       'Maret',
//       'April',
//       'Mei',
//       'Juni',
//       'Juli',
//       'Agustus',
//       'September',
//       'Oktober',
//       'November',
//       'Desember',
//     ];

//     return '${tanggal.day} ${namaBulan[tanggal.month - 1]} ${tanggal.year}';
//   }

//   // Fungsi format waktu
//   String formatWaktu(TimeOfDay waktu) {
//     final int jam = waktu.hourOfPeriod == 0 ? 12 : waktu.hourOfPeriod;

//     final String menit = waktu.minute.toString().padLeft(2, '0');

//     final String periode = waktu.period == DayPeriod.am ? 'AM' : 'PM';

//     return '${jam.toString().padLeft(2, '0')}:$menit $periode';
//   }

//   // Judul AppBar berdasarkan menu
//   String getJudul() {
//     switch (menuAktif) {
//       case 'Checkbox':
//         return 'Syarat & Ketentuan';
//       case 'Switch':
//         return 'Mode Gelap';
//       case 'Dropdown':
//         return 'Pilih Kategori Produk';
//       case 'Tanggal':
//         return 'Pilih Tanggal Lahir';
//       case 'Jam':
//         return 'Atur Pengingat';
//       default:
//         return 'Tugas 7 Flutter';
//     }
//   }

//   // Body berdasarkan menu
//   Widget getBody() {
//     switch (menuAktif) {
//       case 'Checkbox':
//         return halamanCheckbox();

//       case 'Switch':
//         return halamanSwitch();

//       case 'Dropdown':
//         return halamanDropdown();

//       case 'Tanggal':
//         return halamanTanggal();

//       case 'Jam':
//         return halamanJam();

//       default:
//         return halamanCheckbox();
//     }
//   }

//   // ==============================
//   // HALAMAN CHECKBOX
//   // ==============================

//   Widget halamanCheckbox() {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Icon(Icons.check_box, size: 50, color: Colors.blue),

//             const SizedBox(height: 15),

//             const Text(
//               'Syarat & Ketentuan',
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),

//             const SizedBox(height: 20),

//             CheckboxListTile(
//               contentPadding: EdgeInsets.zero,
//               title: const Text(
//                 'Saya menyetujui semua persyaratan yang berlaku',
//               ),
//               value: setuju,
//               onChanged: (value) {
//                 setState(() {
//                   setuju = value ?? false;
//                 });
//               },
//             ),

//             const Divider(),

//             const SizedBox(height: 10),

//             const Text(
//               'Hasil:',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),

//             const SizedBox(height: 10),

//             Text(
//               setuju
//                   ? 'Lanjutkan pendaftaran diperbolehkan'
//                   : 'Anda belum bisa melanjutkan',
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//                 color: setuju ? Colors.green : Colors.red,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // ==============================
//   // HALAMAN SWITCH
//   // ==============================

//   Widget halamanSwitch() {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Icon(
//               modeGelap ? Icons.dark_mode : Icons.light_mode,
//               size: 50,
//               color: modeGelap ? Colors.deepPurple : Colors.orange,
//             ),

//             const SizedBox(height: 15),

//             const Text(
//               'Mode Gelap',
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),

//             const SizedBox(height: 20),

//             SwitchListTile(
//               contentPadding: EdgeInsets.zero,
//               title: const Text('Aktifkan Mode Gelap'),
//               value: modeGelap,
//               onChanged: (value) {
//                 setState(() {
//                   modeGelap = value;
//                 });
//               },
//             ),

//             const Divider(),

//             const SizedBox(height: 10),

//             const Text(
//               'Hasil:',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),

//             const SizedBox(height: 10),

//             Text(
//               modeGelap ? 'Mode Gelap Aktif' : 'Mode Terang Aktif',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: modeGelap ? Colors.white : Colors.orange,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // ==============================
//   // HALAMAN DROPDOWN
//   // ==============================

//   Widget halamanDropdown() {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Icon(Icons.category, size: 50, color: Colors.blue),

//             const SizedBox(height: 15),

//             const Text(
//               'Pilih Kategori Produk',
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),

//             const SizedBox(height: 20),

//             DropdownButtonFormField<String>(
//               decoration: const InputDecoration(
//                 labelText: 'Pilih Kategori',
//                 border: OutlineInputBorder(),
//               ),
//               value: kategori,
//               items: const [
//                 DropdownMenuItem(
//                   value: 'Elektronik',
//                   child: Text('Elektronik'),
//                 ),
//                 DropdownMenuItem(value: 'Pakaian', child: Text('Pakaian')),
//                 DropdownMenuItem(value: 'Makanan', child: Text('Makanan')),
//                 DropdownMenuItem(value: 'Lainnya', child: Text('Lainnya')),
//               ],
//               onChanged: (value) {
//                 setState(() {
//                   kategori = value;
//                 });
//               },
//             ),

//             const SizedBox(height: 25),

//             const Text(
//               'Hasil:',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),

//             const SizedBox(height: 10),

//             Text(
//               kategori == null
//                   ? 'Belum memilih kategori'
//                   : 'Anda memilih kategori: $kategori',
//               style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // ==============================
//   // HALAMAN DATE PICKER
//   // ==============================

//   Widget halamanTanggal() {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Icon(Icons.calendar_month, size: 50, color: Colors.blue),

//             const SizedBox(height: 15),

//             const Text(
//               'Pilih Tanggal Lahir',
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),

//             const SizedBox(height: 20),

//             ElevatedButton.icon(
//               onPressed: pilihTanggal,
//               icon: const Icon(Icons.calendar_today),
//               label: const Text('Pilih Tanggal Lahir'),
//             ),

//             const SizedBox(height: 25),

//             const Text(
//               'Hasil:',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),

//             const SizedBox(height: 10),

//             Text(
//               tanggalLahir == null
//                   ? 'Belum memilih tanggal lahir'
//                   : 'Tanggal Lahir: ${formatTanggal(tanggalLahir!)}',
//               style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // ==============================
//   // HALAMAN TIME PICKER
//   // ==============================

//   Widget halamanJam() {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Icon(Icons.access_time, size: 50, color: Colors.blue),

//             const SizedBox(height: 15),

//             const Text(
//               'Atur Pengingat',
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),

//             const SizedBox(height: 20),

//             ElevatedButton.icon(
//               onPressed: pilihWaktu,
//               icon: const Icon(Icons.access_time),
//               label: const Text('Pilih Waktu Pengingat'),
//             ),

//             const SizedBox(height: 25),

//             const Text(
//               'Hasil:',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),

//             const SizedBox(height: 10),

//             Text(
//               waktuPengingat == null
//                   ? 'Belum mengatur waktu pengingat'
//                   : 'Pengingat diatur pukul: '
//                         '${formatWaktu(waktuPengingat!)}',
//               style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // ==============================
//   // DRAWER
//   // ==============================

//   Widget drawerMenu() {
//     return Drawer(
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: [
//           DrawerHeader(
//             decoration: const BoxDecoration(color: Colors.blue),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: const [
//                 Icon(Icons.flutter_dash, size: 50, color: Colors.white),

//                 SizedBox(height: 10),

//                 Text(
//                   'Tugas 7 Flutter',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),

//                 Text(
//                   'Form Input Interaktif',
//                   style: TextStyle(color: Colors.white70),
//                 ),
//               ],
//             ),
//           ),

//           // Checkbox
//           ListTile(
//             leading: const Icon(Icons.check_box),
//             title: const Text('Checkbox'),
//             selected: menuAktif == 'Checkbox',
//             onTap: () {
//               setState(() {
//                 menuAktif = 'Checkbox';
//               });

//               Navigator.pop(context);
//             },
//           ),

//           // Switch
//           ListTile(
//             leading: const Icon(Icons.dark_mode),
//             title: const Text('Switch'),
//             selected: menuAktif == 'Switch',
//             onTap: () {
//               setState(() {
//                 menuAktif = 'Switch';
//               });

//               Navigator.pop(context);
//             },
//           ),

//           // Dropdown
//           ListTile(
//             leading: const Icon(Icons.category),
//             title: const Text('Dropdown'),
//             selected: menuAktif == 'Dropdown',
//             onTap: () {
//               setState(() {
//                 menuAktif = 'Dropdown';
//               });

//               Navigator.pop(context);
//             },
//           ),

//           // Tanggal
//           ListTile(
//             leading: const Icon(Icons.calendar_month),
//             title: const Text('Tanggal'),
//             selected: menuAktif == 'Tanggal',
//             onTap: () {
//               setState(() {
//                 menuAktif = 'Tanggal';
//               });

//               Navigator.pop(context);
//             },
//           ),

//           // Jam
//           ListTile(
//             leading: const Icon(Icons.access_time),
//             title: const Text('Jam'),
//             selected: menuAktif == 'Jam',
//             onTap: () {
//               setState(() {
//                 menuAktif = 'Jam';
//               });

//               Navigator.pop(context);
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   // ==============================
//   // BUILD UTAMA
//   // ==============================

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(getJudul()),
//         backgroundColor: modeGelap ? Colors.grey[850] : Colors.blue,
//         foregroundColor: Colors.white,
//       ),

//       drawer: drawerMenu(),

//       body: AnimatedContainer(
//         duration: const Duration(milliseconds: 300),
//         color: modeGelap ? Colors.grey[900] : Colors.grey[100],

//         child: Center(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.all(16),
//             child: getBody(),
//           ),
//         ),
//       ),
//     );
//   }
// }
