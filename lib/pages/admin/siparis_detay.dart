import 'package:flutter/material.dart';
import 'package:mycofeekahve/models/sparismodel.dart';
import 'package:mycofeekahve/pages/admin/admn_giris.dart';
import 'package:mycofeekahve/services/save_user.dart';

class SparisDetay extends StatefulWidget {
  final SparisModel siparisModel;
  const SparisDetay({
    super.key,
    required this.siparisModel,
  });

  @override
  State<SparisDetay> createState() => _SparisDetayState();
}

class _SparisDetayState extends State<SparisDetay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Sipariş Detay'),
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AdminGirisSAyfasi()),
              );
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.brown,
            )),
      ),
      // ignore: deprecated_member_use
      body: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Center(
            child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: widget.siparisModel.urunListem.length,
                itemBuilder: (context, index) {
                  var item = widget.siparisModel.urunListem[index];
                  return Card(
                    child: ListTile(
                      title: Text(item.urunName),
                      subtitle: Text(item.urunKategori),
                      leading: Text((index + 1).toString()),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  await sparisTamamla();
                  Navigator.push(
                    // ignore: use_build_context_synchronously
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AdminGirisSAyfasi()),
                  );
                },
                child: const Text(
                  'Siparişi Tamaamla',
                  style: TextStyle(color: Colors.white),
                ))
          ],
        )),
      ),
    );
  }

  Future<void> sparisTamamla() async {
    await FrSaveUser()
        .updateSparisTamamlandi(widget.siparisModel.sparisID, true);
  }
}
