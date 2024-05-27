import 'package:mycofeekahve/models/urunmodel.dart';

class SparisModel {
  String sparisID;
  String userID;
  List<UrunModel> urunListem;
  bool sparisTamamlandi;

  SparisModel({
    required this.sparisID,
    required this.userID,
    required this.urunListem,
    this.sparisTamamlandi = false,
  });

  // SparisModel nesnesini Map'e dönüştüren metot
  Map<String, dynamic> toMap() {
    return {
      'sparisID': sparisID,
      'userID': userID,
      'urunListem': urunListem.map((urun) => urun.toMap()).toList(),
      'sparisTamamlandi': sparisTamamlandi,
    };
  }

  // Map'i alıp SparisModel nesnesine dönüştüren factory metot
  factory SparisModel.fromMap(Map<String, dynamic> map) {
    return SparisModel(
      sparisID: map['sparisID'],
      userID: map['userID'],
      urunListem: List<UrunModel>.from(
        map['urunListem'].map((urunMap) => UrunModel.fromMap(urunMap)),
      ),
      sparisTamamlandi: map['sparisTamamlandi'] ?? false,
    );
  }
}
