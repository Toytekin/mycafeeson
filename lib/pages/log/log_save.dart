import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mycofeekahve/constant/color.dart';
import 'package:mycofeekahve/constant/text_field.dart';
import 'package:mycofeekahve/constant/textstyle.dart';
import 'package:mycofeekahve/models/usermodel.dart';
import 'package:mycofeekahve/pages/log/giris.dart';
import 'package:mycofeekahve/services/login.dart';
import 'package:mycofeekahve/services/save_user.dart';
import 'package:uuid/uuid.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class LogSaveScreen extends StatefulWidget {
  const LogSaveScreen({super.key});

  @override
  State<LogSaveScreen> createState() => _LogSaveScreenState();
}

class _LogSaveScreenState extends State<LogSaveScreen> {
  var firebaseLogin = FrLogin();
  var firebaseUser = FrSaveUser();

  final String appbarTitle = 'Kayıt Ekranı';
  final String adTF = 'Ad';
  final String mailTF = 'Mail';
  final String sifreTF = 'Şifre';
  final String sifreTF2 = 'Şifre';
  final String butonOnay = 'Kaydol';
  final String snacTitle = 'Uyarı';
  final String snacMessaj =
      'Lütfen tüm alanların dolu ve şifreyi 7 karakter girdiğine emin olduktan sonra tekrar dene';

  var nameCont = TextEditingController();
  var mailCont = TextEditingController();
  var pasword1Cont = TextEditingController();
  var pasword2Cont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: CoffeeAppColors.darkBrown,
            )),
        title: Text(appbarTitle),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icons(size),
              SbtTextField(
                controller: nameCont,
                label: adTF,
                icon: const Icon(Icons.person),
              ),
              SbtTextField(
                controller: mailCont,
                label: mailTF,
                icon: const Icon(Icons.mail),
              ),
              SbtTextField(
                controller: pasword1Cont,
                label: sifreTF,
                icon: const Icon(Icons.password),
              ),
              SbtTextField(
                controller: pasword2Cont,
                label: sifreTF2,
                icon: const Icon(Icons.password),
              ),
              ElevatedButton(
                  onPressed: () {
                    kaydet();
                  },
                  child: Text(
                    butonOnay,
                    style: SbtTextStyle().normalStyle,
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Padding icons(Size size) {
    return Padding(
      padding: EdgeInsets.only(
        left: size.width * 0.05,
        bottom: size.width * 0.05,
      ),
      child: Row(
        children: [
          Icon(
            FontAwesomeIcons.paperPlane,
            size: size.height * 0.09,
            color: CoffeeAppColors.darkBrown,
          ),
        ],
      ),
    );
  }

  Future<void> kaydet() async {
    if (nameCont.text.isNotEmpty &&
        mailCont.text.isNotEmpty &&
        pasword1Cont.text.isNotEmpty &&
        pasword1Cont.text == pasword2Cont.text) {
      var userID = const Uuid().v1();
      var newUser = UserModel(
        userID: userID,
        userName: nameCont.text,
        userMail: mailCont.text,
        userSifre: pasword1Cont.text,
      );

      await firebaseLogin.kaydet(newUser);
      sayfaKapat();

      textfieldClear();
    } else {
      snacbarsGel();
    }
  }

  textfieldClear() {
    nameCont.clear();
    mailCont.clear();
    pasword1Cont.clear();
    pasword2Cont.clear();
  }

  snacbarsGel() {
    final snackBar = SnackBar(
      /// need to set following properties for best effect of awesome_snackbar_content
      elevation: 10,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: snacTitle,
        message: snacMessaj,

        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
        contentType: ContentType.warning,
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  void sayfaKapat() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }
}
