import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:our_web_app/generated/l10n.dart';
import 'package:our_web_app/models/sectionmodel.dart';

class Medicine {
  final int id;
  final String sientificname;
  final String tradeName;
  final String img;

  Medicine({
    required this.id,
    required this.sientificname,
    required this.tradeName,
    required this.img,
  });

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      id: json['id'],
      sientificname: json['sientific_name'],
      tradeName: json['trade_name'],
      img: json['img'],
    );
  }
}

class CostumContainer extends StatefulWidget {
  const CostumContainer({Key? key}) : super(key: key);

  @override
  State<CostumContainer> createState() => _CostumContainerState();
}

class _CostumContainerState extends State<CostumContainer> {
  List<Datum> data = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/api/show_sections'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final section = Section.fromJson(jsonData);
      setState(() {
        data = section.data;
      });
    } else {
      // print('erorr${response.statusCode}' '${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 85, right: 85),
      child: Container(
        height: 300,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color.fromARGB(255, 51, 138, 238),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    S.of(context).welcomeBack,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 40),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 25),
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.blue[900]),
                    ),
                    onPressed: () {},
                    child: Text(
                      S.of(context).putMidicen,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            const Padding(
              padding:
                  EdgeInsets.only(left: 150, right: 150, top: 10, bottom: 10),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                ),
              ),
            ),

            // Nested List View
            SizedBox(
              width: 500,
              height: 113,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  final datum = data[index];
                  return Column(
                    children: [
                      CircleAvatar(
                        radius: 35,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(35),
                          onTap: () {},
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(35),
                            child: Image.asset('assets/bill 1.jpg',
                                fit: BoxFit.fill),
                          ),
                        ),
                      ),
                      Text(
                        datum.name.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
