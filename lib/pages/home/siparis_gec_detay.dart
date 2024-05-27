import 'package:flutter/material.dart';
import 'package:mycofeekahve/models/sparismodel.dart';

class SparisGecmisDetay extends StatefulWidget {
  final SparisModel sparisModel;
  const SparisGecmisDetay({
    super.key,
    required this.sparisModel,
  });

  @override
  State<SparisGecmisDetay> createState() => _SparisGecmisDetayState();
}

class _SparisGecmisDetayState extends State<SparisGecmisDetay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sipariş Detay'),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: widget.sparisModel.urunListem.length,
          itemBuilder: (context, index) {
            var item = widget.sparisModel.urunListem[index];

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
    );
  }
}
