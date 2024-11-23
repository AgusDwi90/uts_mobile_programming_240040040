class Plant {
  String id;
  String namaSpesies;
  String namaIndonesia;
  String deskripsi;
  String gambar;

  Plant({
    required this.id,
    required this.namaSpesies,
    required this.namaIndonesia,
    required this.deskripsi,
    required this.gambar,
  });

  // Konversi ke JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'namaSpesies': namaSpesies,
      'namaIndonesia': namaIndonesia,
      'deskripsi': deskripsi,
      'gambar': gambar,
    };
  }

  // Konversi dari JSON
  factory Plant.fromJson(Map<String, dynamic> json) {
    return Plant(
      id: json['id'],
      namaSpesies: json['namaSpesies'],
      namaIndonesia: json['namaIndonesia'],
      deskripsi: json['deskripsi'],
      gambar: json['gambar'],
    );
  }
}
