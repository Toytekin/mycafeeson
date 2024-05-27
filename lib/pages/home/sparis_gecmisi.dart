import 'package:flutter/material.dart';
import 'package:mycofeekahve/models/sparismodel.dart';
import 'package:mycofeekahve/models/usermodel.dart';
import 'package:mycofeekahve/pages/home/siparis_gec_detay.dart';
import 'package:mycofeekahve/services/save_user.dart';

class SparisGecmisiScreen extends StatefulWidget {
  final UserModel userModel;
  const SparisGecmisiScreen({
    super.key,
    required this.userModel,
  });

  @override
  State<SparisGecmisiScreen> createState() => _SparisGecmisiScreenState();
}

class _SparisGecmisiScreenState extends State<SparisGecmisiScreen> {
  List<SparisModel> sparisler = [];

  @override
  void initState() {
    super.initState();

    siparisGecmisiniCek();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Spariş Geçmişi'),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: sparisler.length,
          itemBuilder: (context, index) {
            var item = sparisler[index];

            if (sparisler.isEmpty) {
              return const Center(
                child: Text('Herhangi bir sparişiniz sistemde bulunmamaktadır'),
              );
            } else {
              return Card(
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SparisGecmisDetay(sparisModel: item)),
                    );
                  },
                  leading: Text(
                    "${index + 1}.",
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  title: const Text('Spariş'),
                  subtitle: Text("${item.urunListem.length}   Adet"),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Future<void> siparisGecmisiniCek() async {
    var data = await FrSaveUser().getAllSparisler(widget.userModel);
    if (data == null) {
    } else {
      sparisler = data;
    }
    setState(() {});
  }
}
