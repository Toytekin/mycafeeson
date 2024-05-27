class UrunModel {
  String urunKategori;
  String urunName;
  int urunFiyat;

  UrunModel({
    required this.urunKategori,
    required this.urunName,
    required this.urunFiyat,
  });

  // UrunModel nesnesini Map'e dönüştüren metot
  Map<String, dynamic> toMap() {
    return {
      'urunKategori': urunKategori,
      'urunName': urunName,
      'urunFiyat': urunFiyat,
    };
  }

  // Map'i alıp UrunModel nesnesine dönüştüren factory metot
  factory UrunModel.fromMap(Map<String, dynamic> map) {
    return UrunModel(
      urunKategori: map['urunKategori'],
      urunName: map['urunName'],
      urunFiyat: map['urunFiyat'],
    );
  }
}
