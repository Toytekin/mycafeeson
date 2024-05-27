import 'package:flutter/material.dart';
import 'package:mycofeekahve/models/sepetmodel.dart';
import 'package:mycofeekahve/models/usermodel.dart';
import 'package:mycofeekahve/pages/home/giris.dart';

class SparisOzetModel extends StatefulWidget {
  final UserModel usermodel;
  final List<Sepetmodel> sepettekiUrunler;
  const SparisOzetModel(
      {super.key, required this.sepettekiUrunler, required this.usermodel});

  @override
  State<SparisOzetModel> createState() => _SparisOzetModelState();
}

class _SparisOzetModelState extends State<SparisOzetModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        GirisScreen(userModel: widget.usermodel)),
              );
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.brown,
            )),
        title: const Text('Spariş Özetiniz'),
      ),
      // ignore: deprecated_member_use
      body: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Center(
          child: ListView.builder(
            itemCount: widget.sepettekiUrunler.length,
            itemBuilder: (context, index) {
              var item = widget.sepettekiUrunler[index];
              return Card(
                child: ListTile(
                  leading: Text((index + 1).toString()),
                  title: Text(item.urunModel.urunName),
                  trailing: Text(item.urunModel.urunFiyat.toString()),
                  subtitle: Text(
                    item.urunModel.urunKategori,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
