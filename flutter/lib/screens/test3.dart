import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

// Step 1: Create a data model for the shopping cart
class CartItem {
  final int id;
  final String name;
  final double price;
  int quantity;

  CartItem({required this.id, required this.name, required this.price, this.quantity = 1});
}

// Step 2: Manage the cart state
class CartProvider with ChangeNotifier {
  List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  void addToCart(CartItem item) {
    _cartItems.add(item);
    notifyListeners();
  }

  void removeFromCart(CartItem item) {
    _cartItems.remove(item);
    notifyListeners();
  }

  void updateQuantity(CartItem item, int quantity) {
    item.quantity = quantity;
    notifyListeners();
  }

  Future<void> saveCartToApi() async {
    final List<Map<String, dynamic>> cartData = _cartItems.map((item) => {
      'id': item.id,
      'quantity': item.quantity,
    }).toList();

    final apiUrl = 'https://your-api-url.com/saveCart';
    final headers = {'Content-Type': 'application/json'};

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: jsonEncode(cartData),
      );

      if (response.statusCode == 200) {
        // Cart saved successfully
        print('Cart saved!');
      } else {
        // Handle API error
        print('Failed to save cart. Status code: ${response.statusCode}');
      }
    } catch (error) {
      // Handle network or other errors
      print('Failed to save cart. Error: $error');
    }
  }
}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping Cart Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Step 3: Add products to the cart
                final cartProvider = Provider.of<CartProvider>(context, listen: false);
                final product = CartItem(id: 1, name: 'Product 1', price: 10.0);
                cartProvider.addToCart(product);
              },
              child: Text('Add to Cart'),
            ),
            Consumer<CartProvider>(
              builder: (context, cartProvider, child) {
                // Step 4: Display the cart
                final cartItems = cartProvider.cartItems;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cartItems[index];
                    return ListTile(
                      title: Text(item.name),
                      subtitle: Text('Quantity: ${item.quantity}'),
                      trailing: IconButton(
                        icon: Icon(Icons.remove_shopping_cart),
                        onPressed: () {
                          // Step 5: Remove from cart
                          cartProvider.removeFromCart(item);
                        },
                      ),
                    );
                  },
                );
              },
            ),
            ElevatedButton(
              onPressed: () async {
                // Step 6: Save the cart to API
                final cartProvider = Provider.of<CartProvider>(context, listen: false);
                await cartProvider.saveCartToApi();
              },
              child: Text('Save Cart'),
            ),
          ],
        ),
      ),
    );
  }
}