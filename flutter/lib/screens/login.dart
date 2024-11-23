import 'dart:convert';
import 'package:app5/generated/l10n.dart';
import 'package:app5/screens/home_page.dart';
import 'package:app5/screens/rigestre.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:app5/services/loginservice.dart';
import 'package:app5/widget/alitextdaild.dart';
import 'package:app5/widget/textbuttoncustom.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatefulWidget {
  static String id = 'loginpage';
  static Color primaryColor = const Color(0xff1B185B);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController numberco = TextEditingController();
  TextEditingController passwordco = TextEditingController();

  bool isLoading = false;
  String? accessToken;
  @override
  void initState() {
    super.initState();
    // cheklogin();
  }

  Future<void> cheklogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      String? val = prefs.getString('access_token');
      if (val != null) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Home_page()),
            (route) => false);
      }
    });
  }

  Future<void> storeAccessToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', token);

    // setState(() {
    //   accessToken = token;
    // });
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Home_page()), (route) => false);
  }

  Future<void> login() async {
    try {
      http.Response response = await http.post(
        Uri.parse("http://10.0.2.2:8000/api/login_for_user"),
        body: {'number': numberco.text, 'password': passwordco.text},
      );

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        String token = json['token'];
        print("Token login :" + token);
        storeAccessToken(token);
        print(storeAccessToken(token).toString());
      } else {
        print("Login failed");
      }
    } catch (e) {
      print("::::::::::::::::::");
    }
  }

  Future<dynamic> handleFormSubmission() async {
    setState(() {
      isLoading = true;
    });

    try {
      await Loginservice().loginservic(
        number: numberco.toString(),
        password: passwordco.toString(),
      );
    } catch (e) {
      print(e.toString());
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: LoginPage.primaryColor,
        body: ListView(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset('image/logoo.jpg'),
                // ignore: missing_required_param
                MyTextField(
                  controller: numberco,
                  iconName: "+963",
                ),
                MyTextField(
                  controller: passwordco,
                  icon: const Icon(
                    Icons.lock_outline,
                    color: Color(0xffAC82FE),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                // InkWell(
                //   borderRadius: BorderRadius.circular(8),
                //   onTap: () {},
                //   child: const Text(
                //     'forgot your password?',
                //     style: TextStyle(fontSize: 13, color: Colors.white),
                //   ),
                // ),
                SizedBox(
                  height: 16,
                ),
                MyTextButton(
                  text: S.of(context).singIn,
                  onpressed: () async {
                    await login();
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      S.of(context).Dont,
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => register()));
                      },
                      child: Text(
                        S.of(context).regester,
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xffAC82FE),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                // Row(
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     const Text(
                //       'Continue with ',
                //       style: TextStyle(fontSize: 12, color: Colors.white),
                //     ),
                //     InkWell(
                //       borderRadius: BorderRadius.circular(8),
                //       onTap: () {},
                //       child: const Text(
                //         'GUEST',
                //         style: TextStyle(
                //           fontSize: 13,
                //           color: Color(0xffAC82FE),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
