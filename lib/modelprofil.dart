class Profil {
  String nama;
  int jenislahan;
  int luaslahan;
  String foto;

  Profil({
    required this.nama,
    required this.jenislahan,
    required this.luaslahan,
    required this.foto,
  });

  factory Profil.fromJson(Map json) {
    return Profil(
        nama: json['nama'],
        jenislahan: json['jenislahan'],
        luaslahan: json['luaslahan'],
        foto: json['foto']);
  }
}
