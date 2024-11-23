// import 'package:app5/screens/home_page.dart';
// import 'package:flutter/material.dart';



// class Cart with ChangeNotifier {
//   final List<Product> _items = [];
//   double _price = 0;

//   double get totalPrice => _price;

//   List<Product> get cartItems => _items;

//   void add(Product item) {
//     final existingItemIndex = _items.indexWhere((cartItem) => cartItem.id == item.id);

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
//        total += item.price.toDouble() * item.quantity;
//     }
//     return total;
//   }
// }