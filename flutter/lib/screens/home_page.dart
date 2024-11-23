import 'dart:async' show Future, Timer;
import 'dart:convert';
import 'package:app5/generated/l10n.dart';
import 'package:app5/main.dart';
import 'package:app5/screens/bills.dart';
import 'package:app5/screens/cartpage.dart';
import 'package:app5/screens/fav_page.dart';
import 'package:app5/screens/reportspage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:app5/screens/detiles.dart';
import 'package:app5/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Datum {
  Datum({
    required this.id,
    required this.name,
    required this.img,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final String? name;
  final dynamic img;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      id: json["id"],
      name: json["name"],
      img: json["img"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }
}

class Section {
  Section({
    required this.data,
  });

  final List<Datum> data;

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      data: json["data"] == null
          ? []
          : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }
}

class Product {
  Product(
      {this.img,
      this.sientificName,
      this.tradeName,
      this.price,
      this.expiration,
      this.quantity,
      this.manufactureName,
      this.details,
      this.id});

  final String? img;
  final String? sientificName;
  final String? tradeName;
  final dynamic price;
  final String? expiration;
  dynamic quantity;
  final String? manufactureName;
  final String? details;
  dynamic id;

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      img: json["img"],
      sientificName: json["sientific_name"],
      tradeName: json["trade_name"],
      price: json["price".toString()],
      expiration: json["expiration"],
      quantity: json["quantity"],
      manufactureName: json["manufacture_name"],
      details: json["details"],
      id: json["id"],
    );
  }
}

class Home_page extends StatefulWidget {
  static String id = "homepage";

  @override
  State<Home_page> createState() => _Home_pageState();
}

class _Home_pageState extends State<Home_page>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  List<Product> _products = [];
  List<Datum> data1 = [];
  int _tabLength = 1;
  List<Product> searchResults = [];
  GlobalKey<ScaffoldState> Scaffoldkey = GlobalKey<ScaffoldState>();
  TextEditingController _searchController = TextEditingController();
  Timer? _debounceTimer;
  String selectedSectionName = 'ALL';

  @override
  void initState() {
    super.initState();
    getAccessToken();
    fetchMedicines();
    fetchData();
    searchResults = _products;
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  Future<dynamic> fetchData() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8000/api/show_sections'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final section = Section.fromJson(jsonData);
      if (mounted) {
        setState(() {
          data1 = section.data;
          print('data1 length: ${data1.length}');
          _tabLength = data1.length;
          _tabController = TabController(
            length: data1.length,
            vsync: this,
          );
          print(_tabLength);
        });
      }
    } else {
      print('erorr${response.statusCode}' '${response.body}');
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

  Future<void> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    accessToken = prefs.getString('access_token');
  }

  Future<void> clearAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
  }

  Future logout() async {
    Map<String, String> header = {};

    setState(() {
      header.addAll({'Authorization': 'Bearer $accessToken'});
    });
    var response = await http.get(
        Uri.parse('http://10.0.2.2:8000/api/logaout_for_user'),
        headers: header);
    if (response.statusCode == 200) {
      clearAccessToken();
      print(header);

      return jsonDecode(response.body.toString());
    } else {
      throw Exception(
          'there is a problem with status code ${response.statusCode} , the error is${response.body} ');
    }
  }

  Future<List<Product>> fetchMedicinesBySection(String sectionName) async {
    final url =
        Uri.parse('http://10.0.2.2:8000/api/show_medicins/$sectionName');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body) as List<dynamic>;
      final medicines = jsonData.map((item) => Product.fromJson(item)).toList();
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
          _products = medicines;
        });
      }
    } catch (e) {
      // Handle error case
      // print(e.toString());
      print("/////////////////////////////////////////////////////////////");
    }
  }

  // Modify filterProducts method to work with code

  String? accessToken;
  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    return Scaffold(
      backgroundColor: const Color(0xff1B185B),
      key: Scaffoldkey,
      drawer: Drawer(
        backgroundColor: const Color.fromARGB(255, 29, 29, 29).withOpacity(0.9),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 300,
              height: 230,
              color: const Color.fromARGB(255, 35, 35, 35).withOpacity(0.5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 10, top: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: const Image(
                            width: 100,
                            height: 100,
                            image: AssetImage("image/images (1).png"),
                          ),
                        ),
                        // IconButton(
                        //   onPressed: () {},
                        //   icon: const Icon(
                        //     Icons.nightlight_outlined,
                        //     size: 40,
                        //     color: Colors.white,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, left: 20),
                    child: Text(
                      S.of(context).userName,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 20),
                    child: Text(
                      "+963988365145",
                      style: TextStyle(
                          fontSize: 16, color: Colors.white.withOpacity(0.5)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 90),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => BillsPage()));
                      },
                      child: Text(
                        S.of(context).bills,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                  Container(
                    height: 2,
                    width: 200,
                    decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide()),
                        color: Colors.white),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 90),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const favorite()));
                      },
                      child: Text(
                        S.of(context).favorate,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                  Container(
                    height: 2,
                    width: 200,
                    decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide()),
                        color: Colors.white),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 90),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Reports()));
                      },
                      child: Text(
                        S.of(context).report,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                  Container(
                    height: 2,
                    width: 200,
                    decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide()),
                        color: Colors.white),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        Locale newLocale =
                            languageProvider.currentLocale == const Locale('en')
                                ? const Locale('ar')
                                : const Locale('en');
                        languageProvider.changeLanguage(newLocale);
                      },
                      child: const Text('Switch Language'),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    onPressed: () {
                      print('logot=ut');
                      logout();

                      // logout();
                    },
                    child: Text(S.of(context).logout),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: IconButton(
                    onPressed: <dunamic>() {
                      Scaffoldkey.currentState?.openDrawer();
                    },
                    icon: const Icon(
                      Icons.menu,
                      size: 40,
                      color: Colors.white,
                    )),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      controller: _searchController,
                      onChanged: (value) {
                        // Update searchResults based on the search term and selected section
                        setState(() {
                          searchResults = _products.where((product) {
                            final String searchTerm = value.toLowerCase();
                            //  final String selectedSection = selectedSectionName.toLowerCase();

                            // Filter by both search term and selected section name
                            return (product.tradeName
                                    .toString()
                                    .toLowerCase()
                                    .contains(searchTerm) ||
                                product.sientificName
                                    .toString()
                                    .toLowerCase()
                                    .contains(searchTerm));
                          }).toList();
                        });
                      },
                      decoration:
                          const InputDecoration(hoverColor: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          // Check if _tabController is initialized
          if (_tabController != null)
            TabBar(
              enableFeedback: true,
              unselectedLabelColor: Colors.white,
              labelColor: Colors.orange,
              indicatorColor: Colors.orange,
              indicatorWeight: 10,
              controller: _tabController!,
              isScrollable: true,
              onTap: (index) async {
                await updateSelectedSection(data1[index].name.toString());
                print("data:${data1.length}");
              },
              tabs: data1.map((datum) {
                return Tab(
                  text: datum.name.toString(),
                );
              }).toList(),
            ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: _searchController.text.isEmpty
                    ? _products.length
                    : searchResults.length,
                itemBuilder: (BuildContext context, int index) {
                  final product = _searchController.text.isEmpty
                      ? _products[index]
                      : searchResults[index];
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ItemsDetails(
                                data: product,
                              )));
                    },
                    child: Card(
                      color: const Color(0xff1B185B),
                      elevation: 20,
                      child: Consumer<Cart>(
                        builder: (context, cart, child) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                width: double.infinity,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.asset(
                                    'image/Betapharm-15.jpg',
                                    height: 80,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Text(
                                product.tradeName.toString(),
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                product.sientificName.toString(),
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[400],
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    product.price.toString(),
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.orange[400],
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      cart.add(product);
                                    },
                                    icon: const Icon(Icons.add),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(eccentricity: 1),
          tooltip: "cart",
          autofocus: true,
          backgroundColor: const Color.fromARGB(255, 85, 0, 255),
          child: const Padding(
            padding: EdgeInsets.only(right: 3),
            child: Icon(
              FontAwesomeIcons.cartShopping,
              color: Colors.white,
            ),
          ),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return const CartPage();
                },
              ),
            );
          }),
    );
  }
}
