// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => Cart(),
//       child: MaterialApp(
//         title: 'Your App',
//         home: CartPage(),
//         // Other configurations...
//       ),
//     );
//   }
// }
//  Future<void> searchMedicine(String sectionName) async {
//     final response = await http.post(
//       Uri.parse('http://10.0.2.2:8000/api/search/$sectionName'),
//       body: {'word': _searchController.text},
//     );
//     print("sectionname : ${sectionName}");
//     print(_searchController);
//     if (response.statusCode == 200) {
//       final List<dynamic> jsonResponse = json.decode(response.body);

//       setState(() {
//         searchResults =
//             jsonResponse.map((item) => Product.fromJson(item)).toList();
//         searchResults = searchResults.where((medicine) {
//           final String tradeName = medicine.tradeName.toString().toLowerCase();
//           final String scientificName =
//               medicine.sientificName.toString().toLowerCase();
//           final String lowercaseQuery = sectionName.toLowerCase();

//           return tradeName.contains(lowercaseQuery) ||
//               scientificName.contains(lowercaseQuery);
//         }).toList();
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content:
//               Text('Failed to search for medicines: ${response.statusCode}'),
//         ),
//       );
//     }
//   }

// class CartPage extends StatefulWidget {
//   const CartPage({Key? key}) : super(key: key);

//   @override
//   State<CartPage> createState() => _CartPageState();
// }

// class _CartPageState extends State<CartPage> {
//   @override
//   Widget build(BuildContext context) {
//     final cart = Provider.of<Cart>(context);

//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           final cart = Provider.of<Cart>(context, listen: false);
//           sendOrder(cart.cartItems);
//         },
//         child: Icon(Icons.save),
//       ),
//       body: Column(
//         children: [
//           Consumer<Cart>(
//             builder: (context, cart, child) {
//               return Expanded(
//                 child: ListView.builder(
//                   itemCount: cart.cartItems.length,
//                   itemBuilder: (context, i) {
//                     return Card(
//                       color: const Color(0xff2E2A9B),
//                       child: Row(
//                         children: [
//                           ClipRRect(
//                             borderRadius: BorderRadius.circular(15),
//                             child: SizedBox.fromSize(
//                               size: const Size.fromRadius(48),
//                               child: Image.asset(
//                                 "image/BOITE-MEDICAMENT-04.png",
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           ),
//                           const SizedBox(
//                             width: 10,
//                           ),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 cart.cartItems[i].tradeName.toString(),
//                                 style: const TextStyle(
//                                   color: Colors.white,
//                                   fontFamily: 'Merienda',
//                                   fontSize: 14,
//                                 ),
//                               ),
//                               Text(
//                                 cart.cartItems[i].sientificName.toString(),
//                                 style: const TextStyle(
//                                   color: Colors.white,
//                                   fontFamily: 'Merienda',
//                                   fontSize: 12,
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: 250,
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       'price: ${cart.cartItems[i].price}\$',
//                                       style: const TextStyle(
//                                         color: Colors.white,
//                                         fontFamily: 'Merienda',
//                                         fontSize: 14,
//                                       ),
//                                     ),
//                                     Text(cart.cartItems[i].quantity.toString()),
//                                     IconButton(
//                                       onPressed: () {
//                                         cart.remove(cart.cartItems[i]);
//                                       },
//                                       icon: const Icon(
//                                         Icons.delete_outline_rounded,
//                                         color: Colors.white,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> sendOrder(List<Product> cartItems) async {
//     var url = Uri.parse('http://10.0.2.2:8000/api/order');

//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? accessToken = prefs.getString('access_token');

//     var headers = {
//       'Content-Type': 'application/json',
//       'Authorization': 'Bearer $accessToken'
//     };

//     var cartData = cartItems
//         .map((item) => {
//               'id': item.id,
//               'quantity': item.quantity,
//             })
//         .toList();

//     var body = json.encode({
//       'medicins': cartData,
//     });

//     try {
//       var response = await http.post(
//         url,
//         headers: headers,
//         body: body,
//       );

//       if (response.statusCode == 200) {
//         print(await response.body);
//         showDialog(
//           context: context,
//           builder: (context) => AlertDialog(
//             title: Text('Success'),
//             content: Text('Order saved successfully.'),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text('OK'),
//               ),
//             ],
//           ),
//         );
//       } else {
//         print(response.reasonPhrase);
//         showDialog(
//           context: context,
//           builder: (context) => AlertDialog(
//             title: Text('Error'),
//             content: Text('Failed to save the order.'),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text('OK'),
//               ),
//             ],
//           ),
//         );
//       }
//     } catch (e) {
//       print('Error: $e');
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Text('Error'),
//           content: Text('An error occurred while saving the order.'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('OK'),
//             ),
//           ],
//         ),
//       );
//     }
//   }
// }

// class Cart with ChangeNotifier {
//   final List<Product> _items = [];
//   double _price = 0;

//   double get totalPrice => _price;

//   List<Product> get cartItems => _items;

//   void add(Product item) {
//     final existingItemIndex =
//         _items.indexWhere((cartItem) => cartItem.id == item.id);

//     if (existingItemIndex != -1) {
//       _items[existingItemIndex].quantity += 1;
//     } else {
//       item.quantity = 1;
//       _items.add(item);
//     }

//     notifyListeners();
//   }

//   void updateQuantity(Product item, int quantity) {
//     item.quantity = quantity;
//     _price = _calculateTotalPrice();
//     notifyListeners();
//   }

//   void remove(Product item) {
//     _items.remove(item);
//     _price = _calculateTotalPrice();
//     notifyListeners();
//   }

//   double _calculateTotalPrice() {
//     double total = 0;
//     for (var item in _items) {
//       total += item.price.toDouble() * item.quantity;
//     }
//     return total;
//   }
// }

// class Product {
//   final int id;
//   final String tradeName;
//   final String sientificName;
//    int quantity;
//   final double price;

//   Product({
//     required this.id,
//     required this.tradeName,
//     required this.sientificName,
//     required this.quantity,
//     required this.price,
//   });
// }
