import 'package:flutter/material.dart';
import 'package:mycofeekahve/constant/color.dart';

// ignore: must_be_immutable
class SbtTextField extends StatelessWidget {
  Widget icon;
  final TextEditingController controller;
  final String label;
  final bool sifrelimi;
  SbtTextField({
    super.key,
    required this.controller,
    required this.label,
    this.sifrelimi = false,
    this.icon = const Icon(Icons.add),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(5.0),
        child: TextField(
          style: const TextStyle(color: CoffeeAppColors.mediumBrown),
          // Bu özellik metni gizler
          obscureText: sifrelimi,
          controller: controller,
          decoration: InputDecoration(
            prefixIcon: icon,
            prefixIconColor: CoffeeAppColors.mediumBrown,
            labelText: label,
            labelStyle: const TextStyle(
                color: CoffeeAppColors.mediumBrown), // Etiket rengi
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                  color: CoffeeAppColors
                      .mediumBrown), // Aktif olduğunda sınır rengi
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                  color: CoffeeAppColors
                      .mediumBrown), // Pasif olduğunda sınır rengi
            ),
          ),
        ));
  }
}

// ignore: must_be_immutable
class SbtTextFieldMesaj extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool sifrelimi;
  Widget icon;
  SbtTextFieldMesaj({
    super.key,
    required this.controller,
    required this.label,
    this.icon = const Icon(Icons.add),
    this.sifrelimi = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          maxLines: 8,
          style: const TextStyle(color: CoffeeAppColors.milk),
          // Bu özellik metni gizler
          obscureText: sifrelimi,
          controller: controller,
          decoration: InputDecoration(
            prefixIconColor: Colors.white,
            prefixIcon: icon,
            labelText: label,
            labelStyle:
                const TextStyle(color: CoffeeAppColors.milk), // Etiket rengi
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                  color: CoffeeAppColors.milk), // Aktif olduğunda sınır rengi
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                  color: CoffeeAppColors.milk), // Pasif olduğunda sınır rengi
            ),
          ),
        ));
  }
}
