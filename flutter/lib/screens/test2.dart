import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product {
  Product({
    this.img,
    this.sientificName,
    this.tradeName,
    this.price,
  });

  final String? img;
  final String? sientificName;
  final String? tradeName;
  final String? price;

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      img: json["img"],
      sientificName: json["sientific_name"],
      tradeName: json["trade_name"],
      price: json["price"],
    );
  }
}

class ProductCatalog extends StatefulWidget {
  static String id = 'product_catalog';

  @override
  _ProductCatalogState createState() => _ProductCatalogState();
}

class _ProductCatalogState extends State<ProductCatalog> {
  List<Product> _filteredProducts = [];
  List<Product> _products = [];

  @override
  void initState() {
    super.initState();
    // Initialize the products list
    fetchProducts("ALL").then((products) {
      setState(() {
        _products = products;
        _filteredProducts = products;
      });
    }).catchError((error) {
      print('Error: $error');
    });
  }
// Future<List<Product>> fetchProducts(String sectionName) async {
  //   final response = await http.get(
  //     Uri.parse('hhttp://127.0.0.1:8000/api/show_medicins/$sectionName'),

  //     headers: {
  //       'Content-Type': 'application/json',
  //     },
  //   );

  //   if (response.statusCode == 200) {
  //     final List<dynamic> responseData = jsonDecode(response.body);
  //     return responseData
  //         .map(
  //           (productData) => Product(
  //               tradeName: productData["trade_name"],
  //               sientificName: productData["sientific_name"],
  //               price: productData["price"],
  //               manufactureName: productData['manufacture_name'],
  //               expiration: productData['expiration'.toString()],
  //               quantity: productData['quantity'.toString()],
  //               id: productData['id']),
  //         )
  //         .toList();
  //   } else {
  //     throw Exception('Failed to fetch products');
  //   }
  // }
  Future<List<Product>> fetchProducts(String sectionName) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/show_medicin_by_section'),
      body: jsonEncode({'name': sectionName}),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      return responseData
          .map((productData) => Product(
                tradeName: productData["trade_name"],
                sientificName: productData["sientific_name"],
                price: productData["price"],
              ))
          .toList();
    } else {
      throw Exception('Failed to fetch products');
    }
  }

  
  void filterProducts(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredProducts = _products;
      } else {
        _filteredProducts = _products
            .where((product) =>
                product.tradeName!
                    .toLowerCase()
                    .contains(query.toLowerCase()) ||
                product.sientificName!
                    .toLowerCase()
                    .contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Product Catalog'),
        ),
        body: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (query) => filterProducts(query),
                decoration: InputDecoration(
                  labelText: 'Search',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),

            // Product Grid
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: _filteredProducts.length,
                itemBuilder: (BuildContext context, int index) {
                  final product = _filteredProducts[index];
                  return InkWell(
                    onTap: () {
                      // Handle product tap
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Card(
                        color: Color(0xff1B185B),
                        elevation: 20,
                        child: Column(
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
                                  "image/BOITE-MEDICAMENT-01.png",
                                  height: 99,
                                  width: 600,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              product.tradeName.toString(),
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              product.sientificName.toString(),
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[400],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              product.price.toString(),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange[400],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ProductCatalog(),
  ));
}
