// ignore_for_file: use_build_context_synchronously, camel_case_types

import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:our_web_app/components/costum_drawer.dart';
import 'package:our_web_app/generated/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Putmidicen extends StatefulWidget {
  const Putmidicen({super.key});
  static String id = "putmidicen";
  @override
  State<Putmidicen> createState() => _PutmidicenState();
}

class _PutmidicenState extends State<Putmidicen> {
  late TextEditingController sientificname;
  late TextEditingController tradename;
  late TextEditingController img;
  late TextEditingController expiration;
  late TextEditingController quantity;
  late TextEditingController manufacturename;
  late TextEditingController sectionname;
  late TextEditingController details;
  late TextEditingController price;

  @override
  void initState() {
    super.initState();
    getAccessToken();
    tradename = TextEditingController();
    sientificname = TextEditingController();

    manufacturename = TextEditingController();
    sectionname = TextEditingController();
    price = TextEditingController();
    img = TextEditingController();
    expiration = TextEditingController();
    quantity = TextEditingController();
    details = TextEditingController();
  }

  @override
  dispose() {
    super.dispose();
    tradename.dispose();
    sientificname.dispose();
    manufacturename.dispose();
    sectionname.dispose();
    price.dispose();
    img.dispose();
    expiration.dispose();
    quantity.dispose();
    details.dispose();
  }

  Future<void> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    accessToken = prefs.getString('access_token');
  }

  Future<dynamic> putNewMedicine() async {
    Map<String, String> headers = {};

    setState(() {
      headers.addAll({'Authorization': 'Bearer $accessToken'});
    });

    http.Response response =
        await http.post(Uri.parse('http://127.0.0.1:8000/api/put_medicin'),
            body: {
              'sientific_name': sientificname.text,
              'trade_name': tradename.text,
              'price': price.text,
              'img': img.text,
              'expiration': expiration.text,
              'quantity': quantity.text,
              'manufacture_name': manufacturename.text,
              'section_name': sectionname.text,
              'details': details.text,
            },
            headers: headers);

    if (response.statusCode == 200) {
      // Success
      // print('Medicine added successfully');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(S.of(context).success),
            content: Text(S.of(context).medicineAddedSuccessfully),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  // Navigate to home page
                  Navigator.of(context).pop(); // Close the dialog
                  Navigator.pushNamed(context,
                      'HomePage'); // Replace '/home' with your home route
                },
                child: Text(S.of(context).ok),
              ),
            ],
          );
        },
      );
    } else {
      // Failure
      // print('Failed to add medicine. Error: ${response.reasonPhrase}');
      // print(accessToken);
      // print(response.statusCode);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Icon(Icons.warning_amber_rounded),
            content: Text(S.of(context).failedToAddMedicine),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  // Navigate to home page
                  Navigator.of(context).pop(); // Close the dialog
                  // Replace '/home' with your home route
                },
                child: Text(S.of(context).ok),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CostumDrawer(),
      appBar: AppBar(
        title: Image.asset('assets/family doctor.jpg', height: 100, width: 250),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_suggest_sharp),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications_active_outlined),
            onPressed: () {},
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: InkWell(
              borderRadius: BorderRadius.circular(50),
              onTap: () {},
              child: Image.asset('assets/user_image.jpg'),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('200w.gif'),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
              child: Container(
                color: const Color.fromARGB(121, 255, 255, 255),
              ),
            ),
          ),
          ListView(
            children: [
              Positioned(
                top: 10,
                left: 20,
                right: 20,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(9.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                S.of(context).putMidicen,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 500, vertical: 10),
                                child: TextFormField(
                                  controller: tradename,
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor:
                                          Colors.blueGrey.withOpacity(0.5),
                                      labelText: S.of(context).tradeName,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(16))),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 500, vertical: 10),
                                child: TextFormField(
                                  controller: sientificname,
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor:
                                          Colors.blueGrey.withOpacity(0.5),
                                      labelText: S.of(context).sientificName,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(16))),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 500, vertical: 10),
                                child: TextFormField(
                                  controller: manufacturename,
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor:
                                          Colors.blueGrey.withOpacity(0.5),
                                      labelText: S.of(context).manufactureName,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(16))),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 500, vertical: 10),
                                child: TextFormField(
                                  controller: sectionname,
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor:
                                          Colors.blueGrey.withOpacity(0.5),
                                      labelText: S.of(context).sectionName,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(16))),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 500, vertical: 10),
                                child: TextFormField(
                                  controller: price,
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor:
                                          Colors.blueGrey.withOpacity(0.5),
                                      labelText: S.of(context).price,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(16))),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 500, vertical: 10),
                                child: TextFormField(
                                  controller: expiration,
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor:
                                          Colors.blueGrey.withOpacity(0.5),
                                      labelText: S.of(context).expiration,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(16))),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 500, vertical: 10),
                                child: TextFormField(
                                  controller: quantity,
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor:
                                          Colors.blueGrey.withOpacity(0.5),
                                      labelText: S.of(context).quantity,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(16))),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 500, vertical: 10),
                                child: TextFormField(
                                  controller: img,
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor:
                                          Colors.blueGrey.withOpacity(0.5),
                                      labelText: S.of(context).image,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(16))),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 500, vertical: 10),
                                child: TextFormField(
                                  controller: details,
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor:
                                          Colors.blueGrey.withOpacity(0.5),
                                      labelText: S.of(context).details,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(16))),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  await putNewMedicine();
                                },
                                child: Text(S.of(context).submit),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class putmidicen {
  putmidicen({
    required this.sientificName,
    required this.tradeName,
    required this.price,
    required this.img,
    required this.expiration,
    required this.quantity,
    required this.manufactureName,
    required this.sectionId,
    required this.details,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  final String? sientificName;
  final String? tradeName;
  final int? price;
  final String? img;
  final DateTime? expiration;
  final String? quantity;
  final String? manufactureName;
  final int? sectionId;
  final String? details;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final int? id;

  factory putmidicen.fromJson(Map<String, dynamic> json) {
    return putmidicen(
      sientificName: json["sientific_name"],
      tradeName: json["trade_name"],
      price: json["price"],
      img: json["img"],
      expiration: DateTime.tryParse(json["expiration"] ?? ""),
      quantity: json["quantity"],
      manufactureName: json["manufacture_name"],
      sectionId: json["section_id"],
      details: json["details"],
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      id: json["id"],
    );
  }
}
