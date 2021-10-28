class User {
  String nama;
  int luaslahan;
  String jenislahan;

  User({
    required this.nama,
    required this.luaslahan,
    required this.jenislahan,
  });

  factory User.fromJson(Map json) {
    return User(
        nama: json['nama'],
        luaslahan: json['luaslahan'],
        jenislahan: json['jenislahan']);
  }
}
