import 'package:flutter/material.dart';
import 'package:mycofeekahve/models/sparismodel.dart';
import 'package:mycofeekahve/pages/admin/siparis_detay.dart';
import 'package:mycofeekahve/services/save_user.dart';

class AdminGirisSAyfasi extends StatefulWidget {
  const AdminGirisSAyfasi({super.key});

  @override
  State<AdminGirisSAyfasi> createState() => _AdminGirisSAyfasiState();
}

class _AdminGirisSAyfasiState extends State<AdminGirisSAyfasi> {
  List<SparisModel> allSparis = [];

  @override
  void initState() {
    super.initState();
    siparsleriCek();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Siparişler'),
      ),
      // ignore: deprecated_member_use
      body: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Center(
          child: ListView.builder(
            itemCount: allSparis.length,
            itemBuilder: (context, index) {
              var item = allSparis[index];

              return Card(
                child: ListTile(
                  leading: Text((index + 1).toString()),
                  title: const Text('Spariş'),
                  subtitle: Text('${item.urunListem.length} Adet'),
                  trailing: Text('${toplamFiyat(item)} TL'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SparisDetay(siparisModel: item),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> siparsleriCek() async {
    var data = await FrSaveUser().getAllSparis();

    if (data != null) {
      for (var element in data) {
        if (element.sparisTamamlandi == false) {
          allSparis.add(element);
        }
      }
    }
    setState(() {});
  }

  String toplamFiyat(SparisModel siparisModel) {
    int toplamFiyat = 0;
    for (var element in siparisModel.urunListem) {
      toplamFiyat = toplamFiyat + element.urunFiyat;
    }
    return toplamFiyat.toString();
  }
}
