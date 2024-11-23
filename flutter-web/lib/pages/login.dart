import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:our_web_app/generated/l10n.dart';
import 'package:our_web_app/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});
  static String id = "loginpage";
  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  TextEditingController numberco = TextEditingController();
  TextEditingController passwordco = TextEditingController();
  @override
  void initState() {
    super.initState();
    cheklogin();
  }

  Future<void> cheklogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      String? val = prefs.getString('access_token');
      if (val != null) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const HomePage()),
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
        MaterialPageRoute(builder: (context) => const HomePage()),
        (route) => false);
  }

  Future<void> login() async {
    try {
      http.Response response = await http.post(
        Uri.parse("http://127.0.0.1:8000/api/login_for_admin"),
        body: {'number': numberco.text, 'password': passwordco.text},
      );

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        String token = json['token'];
        storeAccessToken(token);
      } else {
        // print("Login failed");
      }
    } catch (e) {
      // print("::::::::::::::::::");
    }
  }

  bool isPasswordVisible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          shadowColor: Colors.black,
          elevation: 1,
          centerTitle: true,
          title:
              Image.asset('assets/family doctor.jpg', height: 100, width: 250),
        ),
        body: Stack(
          children: [
            Image.asset(
              'images.jpeg',
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Center(
              child: SizedBox(
                width: 900,
                height: 500,
                child: Card(
                  color: Colors.blueGrey[10],
                  borderOnForeground: true,
                  elevation: 1.0,
                  shadowColor: Colors.black,
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          topLeft: Radius.circular(10),
                        ),
                        child: Image.asset(
                          'assets/login.jpg', // Replace with the path to your image file
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 80),
                                child: Text(
                                  S.of(context).welcomeBack,
                                  style: const TextStyle(fontSize: 40),
                                ),
                              ),
                              Text(
                                S.of(context).loginToContinue,
                                style: const TextStyle(color: Colors.grey),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: TextFormField(
                                  controller: numberco,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(RegExp(
                                        r'[0-9]')), // Allow only numeric input
                                  ],
                                  decoration: InputDecoration(
                                      border: const OutlineInputBorder(),
                                      labelText: S.of(context).number),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                child: TextFormField(
                                  controller: passwordco,
                                  obscureText: isPasswordVisible,
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isPasswordVisible =
                                              !isPasswordVisible;
                                        });
                                      },
                                      icon: Icon(
                                        isPasswordVisible
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                      ),
                                    ),
                                    border: const OutlineInputBorder(),
                                    label: Text(S.of(context).password),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 100),
                                child: ElevatedButton(
                                  style: const ButtonStyle(
                                      backgroundColor:
                                          MaterialStatePropertyAll(Colors.blue),
                                      elevation: MaterialStatePropertyAll(1),
                                      fixedSize: MaterialStatePropertyAll(
                                          Size(300, 50))),
                                  onPressed: () async {
                                    await login();
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.login_outlined,
                                        color:
                                            Color.fromARGB(180, 255, 255, 255),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        S.of(context).login,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            color: Color.fromARGB(
                                                180, 255, 255, 255)),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      // Add some spacing between the text field and the image
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
