import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mycofeekahve/constant/color.dart';
import 'package:mycofeekahve/constant/urunlar.dart';
import 'package:mycofeekahve/models/sepetmodel.dart';
import 'package:mycofeekahve/models/sparismodel.dart';
import 'package:mycofeekahve/models/urunmodel.dart';
import 'package:mycofeekahve/models/usermodel.dart';
import 'package:mycofeekahve/pages/home/sparis_gecmisi.dart';
import 'package:mycofeekahve/pages/home/sparis_ozet.dart';
import 'package:mycofeekahve/services/save_user.dart';
import 'package:uuid/uuid.dart';

class GirisScreen extends StatefulWidget {
  final UserModel userModel;
  const GirisScreen({
    super.key,
    required this.userModel,
  });

  @override
  State<GirisScreen> createState() => _GirisScreenState();
}

class _GirisScreenState extends State<GirisScreen> {
  var firebaseLogin = FrSaveUser();
  final String tatli = 'Tatlılar';
  final String corba = 'Çorbalar';
  final String soguk = 'Soğuk İçecekler';
  final String sicak = 'Sıcak İçecekler';
  final String yemek = 'Yemekler';
  final String siparisiOnayla = 'Sparişi Onayla';

  List<Sepetmodel> sepettekiUrunler = [];
  int toplamFiyat = 0;

  @override
  void initState() {
    super.initState();
    herseyiSifitla();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text('Toplam Fiyat:   '),
              Text(toplamFiyat.toString()),
              const Spacer(),
              IconButton(
                onPressed: () {
                  sepettekilisteGoster(context, 'Sepet', sepettekiUrunler);
                },
                icon: const Icon(
                  Icons.storefront_outlined,
                  color: Colors.brown,
                  size: 30,
                ),
              ),
              Text(
                sepettekiUrunler.length.toString(),
                style: const TextStyle(color: Colors.brown),
              )
            ],
          )),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListTile(
                    leading: const Icon(Icons.cake),
                    title: Text(tatli),
                    onTap: () {
                      listeGoster(context, tatli, TumUrunler.tatlilar);
                    },
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListTile(
                    leading: const Icon(Icons.soup_kitchen),
                    title: Text(corba),
                    onTap: () {
                      listeGoster(context, corba, TumUrunler.corbalar);
                    },
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListTile(
                    leading: const Icon(FontAwesomeIcons.bottleDroplet),
                    title: Text(soguk),
                    onTap: () {
                      listeGoster(context, soguk, TumUrunler.sogukIcecekler);
                    },
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListTile(
                    // ignore: deprecated_member_use
                    leading: const Icon(FontAwesomeIcons.coffee),
                    title: Text(sicak),
                    onTap: () {
                      listeGoster(context, sicak, TumUrunler.sicakIcecekler);
                    },
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListTile(
                    leading: const Icon(Icons.food_bank_outlined),
                    title: Text(yemek),
                    onTap: () {
                      listeGoster(context, yemek, TumUrunler.yemekler);
                    },
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SparisGecmisiScreen(
                                userModel: widget.userModel)),
                      );
                    },
                    child: const Text(
                      ' Spariş Geçmişi',
                      style: TextStyle(color: CoffeeAppColors.milk),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (sepettekiUrunler.isNotEmpty) {
                        List<UrunModel> urunListem = [];
                        for (var element in sepettekiUrunler) {
                          urunListem.add(element.urunModel);
                        }
                        var sparisID = const Uuid().v1();
                        var sparis = SparisModel(
                            userID: widget.userModel.userID,
                            sparisID: sparisID,
                            urunListem: urunListem);

                        await firebaseLogin.sparisEkle(sparis);

                        Navigator.push(
                          // ignore: use_build_context_synchronously
                          context,
                          MaterialPageRoute(
                              builder: (context) => SparisOzetModel(
                                    sepettekiUrunler: sepettekiUrunler,
                                    usermodel: widget.userModel,
                                  )),
                        );
                      } else {}
                    },
                    child: Text(
                      siparisiOnayla,
                      style: const TextStyle(color: CoffeeAppColors.milk),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void listeGoster(BuildContext context, String title, List<UrunModel> items) {
    //Değişkenim
    Map<int, bool> checkedItems = {};

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SizedBox(
            width: double.maxFinite,
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: items.length,
                  itemBuilder: (BuildContext context, int index) {
                    var item = items[index];
                    return CheckboxListTile(
                      value: checkedItems[index] ?? false,
                      onChanged: (bool? value) {
                        setState(() {
                          checkedItems[index] = value ?? false;
                        });
                      },
                      title: Text(item.urunName),
                      secondary: Text('${item.urunFiyat} TL'),
                    );
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                checkedItems.forEach((index, isChecked) {
                  if (isChecked) {
                    var item = items[index];
                    toplamFiyat += item.urunFiyat;
                    var sepetModel = Sepetmodel(
                        urunID:
                            "${item.urunName}_${DateTime.now().millisecondsSinceEpoch}",
                        urunModel: item);
                    sepettekiUrunler.add(sepetModel);
                  }
                });

                setState(() {});

                Navigator.of(context).pop();
              },
              child: const Text('Onayla'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Vazgeç'),
            ),
          ],
        );
      },
    );
  }

  void sepettekilisteGoster(
      BuildContext context, String title, List<Sepetmodel> items) {
    Map<int, bool> checkedItems = {};

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SizedBox(
            width: double.maxFinite,
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: items.length,
                  itemBuilder: (BuildContext context, int index) {
                    var item = items[index];
                    return CheckboxListTile(
                      value: checkedItems[index] ?? false,
                      onChanged: (bool? value) {
                        setState(() {
                          checkedItems[index] = value ?? false;
                        });
                      },
                      title: Text(item.urunModel.urunName),
                      secondary: Text('${item.urunModel.urunFiyat} TL'),
                    );
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                List<Sepetmodel> itemsToRemove = [];

                checkedItems.forEach((index, isChecked) {
                  if (isChecked) {
                    var item = items[index];
                    toplamFiyat -= item.urunModel.urunFiyat;
                    itemsToRemove.add(item);
                  }
                });

                setState(() {
                  for (var itemToRemove in itemsToRemove) {
                    sepettekiUrunler.remove(itemToRemove);
                  }
                });

                Navigator.of(context).pop();
              },
              child: const Text(
                'Sil',
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Vazgeç'),
            ),
          ],
        );
      },
    );
  }

  herseyiSifitla() {
    sepettekiUrunler.clear();
    toplamFiyat = 0;
  }
}
