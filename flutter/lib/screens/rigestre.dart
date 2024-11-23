import 'dart:convert';
import 'dart:io';

import 'package:app5/generated/l10n.dart';
import 'package:app5/screens/home_page.dart';
import 'package:app5/widget/coustomfaild.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';

class register extends StatefulWidget {
  register({super.key});
  static String id = "register";

  @override
  State<register> createState() => _registerState();
}

// String? username,
//     email,
//     number,
//     location,
//     pharmecyname,
//     speicheal,
//     password,
//     passwordconfirm,
//     token;
bool isLoading = false;
// Future<void> getAccessToken() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();

//   accessToken = prefs.getString('access_token');
// }

Future<void> storeAccessToken(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('access_token', token);

  // setState(() {
  //   accessToken = token;
  // });
  // ignore: use_build_context_synchronously
  // Navigator.of(context).pushAndRemoveUntil(
  //     MaterialPageRoute(builder: (context) => Home_page()), (route) => false);
}

class _registerState extends State<register> {
  Future<void> handleFormSubmission() async {
    setState(() {
      isLoading = true;
    });

    try {
      // ignore: missing_required_param
      http.Response response = await http
          .post(Uri.parse("http://10.0.2.2:8000/api/register"), body: {
        'name': usernamecontroller.text,
        'number': numbercontroller.text,
        'email': emailController.text,
        'speicheal': spshelizedcontroller.text,
        'pharmacy_name': pharmacycontroller.text,
        'location': locationcontroller.text,
        'password': passwordController.text,
      });

      var json = jsonDecode(response.body);
      String token = json['token'];

      storeAccessToken(token);
      print(storeAccessToken(token));
    } catch (e) {
      print("object");
      print(e.toString());
    }

    setState(() {
      isLoading = false;
    });
  }

  GlobalKey<FormState> formState = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernamecontroller = TextEditingController();
  final TextEditingController numbercontroller = TextEditingController();
  final TextEditingController locationcontroller = TextEditingController();
  final TextEditingController spshelizedcontroller = TextEditingController();
  final TextEditingController pharmacycontroller = TextEditingController();

  File? image;
  final imagepicker = ImagePicker();
  Future uploadimage() async {
    var pickedimage = await imagepicker.pickImage(source: ImageSource.gallery);
    if (pickedimage != null) {
      setState(() {
        image = File(pickedimage.path);
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    // String users = ModalRoute.of(context)!.settings.arguments == null
    //     ? "NULL"
    //     : ModalRoute.of(context)!.settings.arguments as String;
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: const Color(0xff1B185B),
        body: Stack(
          children: [
            ListView(
              children: [
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        navigator!.pop();
                      },
                      icon: Icon(Icons.arrow_back),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.grey),
                        child: image != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.file(
                                  image!,
                                  fit: BoxFit.cover,
                                ))
                            : Image.asset("image/images (1).png"),
                      ),
                    ),
                    Center(
                        child: IconButton(
                            onPressed: () {
                              uploadimage();
                            },
                            icon: const Icon(Icons.camera_alt))),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 170,
                          child: CustomTextField(
                            validator: (text) {
                              if (text.length < 4) {
                                return "you must write more";
                              } else {
                                return null;
                              }
                            },
                            controller: usernamecontroller,
                            hintText: S.of(context).userName,
                            inputType: TextInputType.name,
                          ),
                        ),
                        Container(
                          width: 170,
                          child: CustomTextField(
                            controller: spshelizedcontroller,
                            hintText: S.of(context).sphilezed,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15, left: 20),
                      child: CustomTextField(
                        controller: pharmacycontroller,
                        hintText: S.of(context).pharmacyName,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15, left: 20),
                      child: CustomTextField(
                          controller: locationcontroller,
                          hintText: S.of(context).location),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15, left: 20),
                      child: CustomTextField(
                          controller: emailController,
                          hintText: S.of(context).email),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15, left: 20),
                      child: CustomTextField(
                        controller: numbercontroller,
                        hintText: "+963",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15, left: 20),
                      child: CustomTextField(
                        controller: passwordController,
                        hintText: S.of(context).password,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: InkWell(
                        onTap: () async {
                          await handleFormSubmission();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Home_page()));
                        },
                        child: Container(
                          width: 200,
                          height: 60,
                          decoration: BoxDecoration(
                              color: Color(0xffAC82FF),
                              borderRadius: BorderRadius.circular(50)),
                          child: Padding(
                            padding: EdgeInsets.only(top: 15),
                            child: Text(
                              S.of(context).submit,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          S.of(context).haveAccount,
                          style: const TextStyle(
                              fontSize: 18, color: Colors.white),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            S.of(context).account,
                            style: TextStyle(
                                color: Colors.purple[800], fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<File>('image', image));
  }
}

// Future<void> updateProduct(User user) async {
//   await Addusers().adduser(
//     name: username,
//     email: email,
//     location: location,
//     number: number,
//     pharmecyName: pharmecyname,
//     speicheal: speicheal,
//     password: password,
//     confirmpassword: passwordconfirm,
   
//   );
// }
