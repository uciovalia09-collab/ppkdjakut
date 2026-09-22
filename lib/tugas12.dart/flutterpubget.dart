class UserModel {
  final int? id;
  final String nama;
  final String email;
  final String nomorHp;
  final String password;
  final String asalKota;

  UserModel({
    this.id,
    required this.nama,
    required this.email,
    required this.nomorHp,
    required this.password,
    required this.asalKota,
  });

  // Mengubah objek UserModel ke Map untuk disimpan ke database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'email': email,
      'nomorHp': nomorHp,
      'password': password,
      'asalKota': asalKota,
    };
  }

  // Mengubah Map dari database menjadi objek UserModel
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      nama: map['nama'],
      email: map['email'],
      nomorHp: map['nomorHp'],
      password: map['password'],
      asalKota: map['asalKota'],
    );
  }
}
