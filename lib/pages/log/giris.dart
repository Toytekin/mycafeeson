import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mycofeekahve/constant/color.dart';
import 'package:mycofeekahve/constant/text_field.dart';
import 'package:mycofeekahve/constant/textstyle.dart';
import 'package:mycofeekahve/models/havamodel.dart';
import 'package:mycofeekahve/pages/admin/admn_giris.dart';
import 'package:mycofeekahve/pages/home/giris.dart';
import 'package:mycofeekahve/pages/log/log_save.dart';
import 'package:mycofeekahve/services/havadurumu.dart';
import 'package:mycofeekahve/services/save_user.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var mailCont = TextEditingController();
  var paswrdCont = TextEditingController();

  final String myCofee = 'My Cafee';
  final String butonText = 'Giriş';
  final String mailTextField = 'Mail';
  final String paswordTextField = 'Şifre';
  final String snacTitle = 'Uyarı';
  final String snacMessaj =
      'Lütfen tüm alanların dolu ve şifreyi 7 karakter girdiğine emin olduktan sonra tekrar dene';

  var frAuth = FrSaveUser();

  HavaModel? havadurumu;

  @override
  void initState() {
    super.initState();
    havadurumunuAl();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                logo(size),
                SizedBox(height: size.height * 0.06),
                SbtTextField(
                  controller: mailCont,
                  label: mailTextField,
                  icon: const Icon(Icons.mail),
                ),
                SbtTextField(
                  sifrelimi: true,
                  controller: paswrdCont,
                  label: paswordTextField,
                  icon: const Icon(Icons.password),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LogSaveScreen()),
                          );
                        },
                        child: const Text(
                          'Kaydol',
                          style: TextStyle(color: CoffeeAppColors.darkGreen),
                        ))
                  ],
                ),
                ElevatedButton(
                    onPressed: () {
                      girisYap();
                    },
                    child: Text(
                      butonText,
                      style: SbtTextStyle().normalStyle,
                    )),

                //
                //

                //
                //
                SizedBox(height: size.height * 0.02),
                havadurumu != null
                    ? Text(
                        ' ${havadurumu?.name}:  ${havadurumu!.main.temp}°C',
                        style: const TextStyle(
                          fontSize: 18,
                          color: CoffeeAppColors.mediumBrown,
                        ),
                      )
                    : const Text(
                        'Hava durumu alınamadı',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.red,
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row logo(Size size) {
    return Row(
      children: [
        Expanded(
          child: Icon(
            // ignore: deprecated_member_use
            FontAwesomeIcons.coffee,
            size: size.height * 0.1,
            color: CoffeeAppColors.mediumBrown,
          ),
        ),
        Expanded(
          child: Text(
            myCofee,
            style: TextStyle(
              color: CoffeeAppColors.mediumBrown,
              fontSize: size.height * 0.06,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> girisYap() async {
    if (mailCont.text.isNotEmpty && paswrdCont.text.isNotEmpty) {
      if (mailCont.text == 'admin' && paswrdCont.text == '1234567') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AdminGirisSAyfasi()),
        );
      } else {
        var data = await frAuth.getUserByEmail(mailCont.text, paswrdCont.text);

        //User varmı yok mu
        if (data != null) {
          Navigator.push(
            // ignore: use_build_context_synchronously
            context,
            MaterialPageRoute(
                builder: (context) => GirisScreen(userModel: data)),
          );
        } else {
          snacbarsGel();
        }
      }
    } else {
      snacbarsGel();
    }
  }

  void snacbarsGel() {
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

  Future<void> havadurumunuAl() async {
    var hava = LocationHelper();
    try {
      havadurumu = await hava.getLocation();
    } catch (e) {
      debugPrint('Hava durumu alınamadı: $e');
    }
    setState(() {});
  }
}
