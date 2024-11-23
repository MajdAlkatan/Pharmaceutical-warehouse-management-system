import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    home: Home_page(),
  ));
}

class Datum {
  final int id;
  final String name;
  final String img;
  final String createdAt;
  final String updatedAt;

  Datum({
    required this.id,
    required this.name,
    required this.img,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      id: json['id'],
      name: json['name'],
      img: json['img'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}

class Section {
  final String sectionName;
  final List<Datum> data;

  Section({
    required this.sectionName,
    required this.data,
  });

  factory Section.fromJson(Map<String, dynamic> json) {
    var dataList = json['data'] as List;
    List<Datum> data =
        dataList.map((datumJson) => Datum.fromJson(datumJson)).toList();

    return Section(
      sectionName: json['name'],
      data: data,
    );
  }
}

class Sections {
  final List<Section> sections;

  Sections({
    required this.sections,
  });

  factory Sections.fromJson(Map<String, dynamic> json) {
    var sectionList = json['name'] as List;
    List<Section> sections = sectionList
        .map((sectionJson) => Section.fromJson(sectionJson))
        .toList();

    return Sections(
      sections: sections,
    );
  }
}

class Datums {
  final List<Datum> data;

  Datums({
    required this.data,
  });

  factory Datums.fromJson(Map<String, dynamic> json) {
    var dataList = json['data'] as List;
    List<Datum> data =
        dataList.map((datumJson) => Datum.fromJson(datumJson)).toList();

    return Datums(
      data: data,
    );
  }
}

class Product {
  final String img;
  final String scientificName;
  final String tradeName;
  final double price;
  final String expiration;
  final int quantity;
  final String manufactureName;
  final String details;
  final int id;

  Product({
    required this.img,
    required this.scientificName,
    required this.tradeName,
    required this.price,
    required this.expiration,
    required this.quantity,
    required this.manufactureName,
    required this.details,
    required this.id,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      img: json['img'],
      scientificName: json['scientificName'],
      tradeName: json['tradeName'],
      price: json['price'],
      expiration: json['expiration'],
      quantity: json['quantity'],
      manufactureName: json['manufactureName'],
      details: json['details'],
      id: json['id'],
    );
  }
}

class Home_page extends StatefulWidget {
  @override
  _Home_pageState createState() => _Home_pageState();
}

class _Home_pageState extends State<Home_page>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _tabLength = 0;

  List<Product> _products = [];
  List<Section> _sections = [];
  Section? _selectedSection;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabLength, vsync: this);
    fetchData();
  }

  Future<void> fetchData() async {
    await fetchSections();
    if (_sections.isNotEmpty) {
      _selectedSection = _sections[0];
      fetchMedicinesBySection(_selectedSection!.sectionName);
    }
  }

  Future<void> fetchSections() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8000/api/sections'));
    if (response.statusCode == 200) {
      final sectionsJson = json.decode(response.body);
      Sections sections = Sections.fromJson(sectionsJson);
      setState(() {
        _sections = sections.sections;
        _tabLength = _sections.length; // Update the tab length
        _tabLength = _tabController.length; // Update the TabController length
      });
    } else {
      throw Exception('Failed to fetch sections');
    }
  }

  Future<void> fetchMedicinesBySection(String sectionName) async {
    final response = await http
        .get(Uri.parse('http://10.0.2.2:8000/api/medicines/$sectionName'));
    if (response.statusCode == 200) {
      final medicinesJson = json.decode(response.body);
      Datums datums = Datums.fromJson(medicinesJson);
      setState(() {
        _products = datums.data.cast<Product>();
      });
    } else {
      throw Exception('Failed to fetch medicines');
    }
  }

  void updateSelectedSection(String sectionName) {
    setState(() {
      _selectedSection =
          _sections.firstWhere((section) => section.sectionName == sectionName);
    });
    fetchMedicinesBySection(sectionName);
  }

  void updateTabLength(int newLength) {
    setState(() {
      _tabLength = newLength;
      _tabLength = _tabController.length;
    });
  }

  List<Product> filterProducts(String query) {
    return _products.where((product) {
      final tradeName = product.tradeName.toLowerCase();
      final scientificName = product.scientificName.toLowerCase();
      return tradeName.contains(query.toLowerCase()) ||
          scientificName.contains(query.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: Container(
            alignment: Alignment.centerLeft,
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              tabs: _sections.map((section) {
                return Tab(
                  text: section.sectionName,
                );
              }).toList(),
              onTap: (index) {
                updateSelectedSection(_sections[index].sectionName);
              },
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _sections.map((section) {
          List<Product> filteredProducts = filterProducts('');
          return ListView.builder(
            itemCount: filteredProducts.length,
            itemBuilder: (BuildContext context, int index) {
              final product = filteredProducts[index];
              return ListTile(
                leading: Image.network(product.img),
                title: Text(product.tradeName),
                subtitle: Text(product.scientificName),
                // Rest of the product details...
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
