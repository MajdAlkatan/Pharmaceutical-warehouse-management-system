// ignore_for_file: must_be_immutable, missing_required_param, prefer_final_fields, library_private_types_in_public_api, unnecessary_string_interpolations

import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:our_web_app/components/costum_container.dart';
import 'package:our_web_app/components/costum_drawer.dart';
import 'package:our_web_app/generated/l10n.dart';
import 'package:our_web_app/models/sectionmodel.dart';
import 'package:our_web_app/pages/putmidicen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Sections {
  Sections({
    required this.sectionName,
    required this.data,
  });

  final String sectionName;
  final List<Datums> data;

  factory Sections.fromJson(Map<String, dynamic> json) {
    return Sections(
      sectionName: json["section_name"],
      data: List<Datums>.from(json["data"].map((x) => Datums.fromJson(x))),
    );
  }
}

class Datums {
  Datums({
    required this.id,
    required this.name,
    required this.tradeName,
    required this.img,
  });

  final int id;
  final String name;
  final String tradeName;
  final String img;

  factory Datums.fromJson(Map<String, dynamic> json) {
    return Datums(
      id: json["id"],
      name: json["sientific_name"],
      tradeName: json["trade_name"],
      img: json["img"],
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Medicine> searchResults = [];

  List<Medicine> mid = [];
  List<Datum> data1 = [];
  String selectedSectionName = 'ALL';
  List<String> sectionNames = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData();
    fetchMedicines();
  }

  Future<List<Medicine>> fetchMedicinesBySection(String sectionName) async {
    final url =
        Uri.parse('http://127.0.0.1:8000/api/show_medicins/$sectionName');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body) as List<dynamic>;
      final medicines =
          jsonData.map((item) => Medicine.fromJson(item)).toList();
      return medicines;
    } else {
      throw Exception('Failed to fetch medicines');
    }
  }

  Future<dynamic> fetchMedicines() async {
    try {
      final medicines = await fetchMedicinesBySection(selectedSectionName);
      if (mounted) {
        setState(() {
          mid = medicines;
        });
      }
    } catch (e) {
      // Handle error case
      // print(e.toString());
      //print("/////////////////////////////////////////////////////////////");
    }
  }

  Future<dynamic> fetchData() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/api/show_sections'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final section = Section.fromJson(jsonData);
      if (mounted) {
        setState(() {
          data1 = section.data;
        });
      }
    } else {
      // print('erorr${response.statusCode}' '${response.body}');
    }
  }

  dynamic updateSelectedSection(String sectionName) {
    if (mounted) {
      setState(() {
        selectedSectionName = sectionName;
      });
    }
    fetchMedicines();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 75, bottom: 75),
        child: FloatingActionButton(
            clipBehavior: Clip.none,
            backgroundColor: const Color(0xff423636),
            onPressed: () {
              showAwesomeDialog(context);
            },
            child: const Text(
              '+',
              style: TextStyle(fontSize: 24, color: Colors.white),
            )),
      ),
      drawer: const CostumDrawer(),
      appBar: appbar(),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Stack(
          children: [
            ListView(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 300,
                      ),
                      GridView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        padding: const EdgeInsets.all(20),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 75, // Spacing between columns
                          mainAxisSpacing: 100, // Spacing between rows
                        ),
                        itemCount: _searchController.text.isEmpty
                            ? mid.length
                            : searchResults
                                .length, // Number of items in the grid
                        itemBuilder: (BuildContext context, int index) {
                          final medicine = _searchController.text.isEmpty
                              ? mid[index]
                              : searchResults[index];

                          return Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  width: 201,
                                  child: Card(
                                    elevation: 1,
                                    child: SizedBox(
                                        height: 150,
                                        width: 400,
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16),
                                            child: Column(
                                              children: [
                                                InkWell(
                                                  borderRadius:
                                                      BorderRadius.circular(35),
                                                  onTap: () {},
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            35),
                                                    child: Image.asset(
                                                        'assets/bill 3.jpeg',
                                                        height: 150,
                                                        fit: BoxFit.fill),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )),
                                  ),
                                ),
                                Text(
                                  '${medicine.tradeName}',
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 16),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
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
                            style: const TextStyle(
                                color: Colors.white, fontSize: 40),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 25),
                          child: TextButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blue[900]),
                            ),
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const Putmidicen()));
                            },
                            child: Text(
                              S.of(context).putMidicen,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 150, right: 150, top: 10, bottom: 10),
                      child: TextField(
                        controller: _searchController,
                        onChanged: (value) {
                          // Update searchResults based on the search term and selected section
                          setState(() {
                            searchResults = mid.where((product) {
                              final String searchTerm = value.toLowerCase();
                              //  final String selectedSection = selectedSectionName.toLowerCase();

                              // Filter by both search term and selected section name
                              return (product.tradeName
                                      .toString()
                                      .toLowerCase()
                                      .contains(searchTerm) ||
                                  product.sientificname
                                      .toString()
                                      .toLowerCase()
                                      .contains(searchTerm));
                            }).toList();
                          });
                        },
                        decoration: const InputDecoration(
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
                        itemCount: data1.length,
                        itemBuilder: (BuildContext context, int index) {
                          final datum = data1[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 35,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(35),
                                    onTap: () {
                                      updateSelectedSection(
                                          datum.name.toString());
                                    },
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
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  AppBar appbar() {
    return AppBar(
      title: Image.asset('assets/family doctor.jpg', height: 100, width: 250),
      actions: [
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: () {},
            child: Image.asset('assets/user_image.jpg'),
          ),
        ),
      ],
    );
  }
}

class CustomDialogContent extends StatefulWidget {
  const CustomDialogContent({super.key});

  @override
  _CustomDialogContentState createState() => _CustomDialogContentState();
}

class _CustomDialogContentState extends State<CustomDialogContent> {
  late TextEditingController _section1Controller;
  late TextEditingController _section2Controller;

  @override
  void initState() {
    super.initState();
    getAccessToken();
    _section1Controller = TextEditingController();
    _section2Controller = TextEditingController();
  }

  @override
  void dispose() {
    _section1Controller.dispose();
    _section2Controller.dispose();
    super.dispose();
  }

  Future<void> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    accessToken = prefs.getString('access_token');
  }

  // ignore: non_constant_identifier_names
  Future<dynamic> PutSection() async {
    String section1Value = _section1Controller.text;
    String section2Value = _section2Controller.text;
    Map<String, String> header = {};

    setState(() {
      header.addAll({'Authorization': 'Bearer $accessToken'});
    });
    // Perform the PUT request to update the section using the values from the TextFormFields
    try {
      // Replace 'API_URL' with the actual API endpoint URL
      var response =
          await http.post(Uri.parse('http://127.0.0.1:8000/api/put_section'),
              body: {
                'name': section1Value,
                'img': section2Value,
              },
              headers: header);

      if (response.statusCode == 200) {
        // Successful update
        // print('Section updated successfully');
      } else {
        // Failed update
        // print('Failed to update section. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Exception occurred
      // print('Exception occurred while updating section: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextFormField(
            controller: _section1Controller,
            decoration: InputDecoration(
              labelText: S.of(context).sectionName,
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _section2Controller,
            decoration: InputDecoration(
              labelText: S.of(context).sectionImage,
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              PutSection();
              // print(PutSection());
            },
            child: Text(S.of(context).updateSection),
          ),
        ],
      ),
    );
  }
}

void showAwesomeDialog(BuildContext context) {
  AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.scale,
          body: const CustomDialogContent(),
          title: S.of(context).dialogTitle,
          desc: S.of(context).dialogDescription,
          btnOkText: S.of(context).okay,
          btnOkOnPress: () {},
          width: MediaQuery.of(context).size.width * 0.5)
      .show();
}
