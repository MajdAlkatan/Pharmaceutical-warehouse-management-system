import 'dart:convert';

import 'package:app5/generated/l10n.dart';
import 'package:app5/screens/home_page.dart';
import 'package:app5/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  String? accessTokens;

  @override
  Widget build(BuildContext context) {
    @override
    void initState() {
      // TODO: implement initState
      super.initState();
    }

    Future<void> sendOrder(List<Product> cartItems) async {
      var url = Uri.parse('http://10.0.2.2:8000/api/order');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        accessTokens = prefs.getString('access_token');
      });
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessTokens'
      };
      print("majd::$accessTokens");

      var cartData = cartItems
          .map((item) => {
                "id": item.id,
                "quantity": item.quantity,
              })
          .toList();

      var body = jsonEncode({'medicins': cartData});

      try {
        http.Response response = await http.post(
          url,
          headers: headers,
          body: body,
        );

        if (response.statusCode == 200) {
          print(response.body);
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(S.of(context).success),
              content: Text(S.of(context).orderSaved),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(S.of(context).ok),
                ),
              ],
            ),
          );
        } else {
          print(response.reasonPhrase);
          print(body);
          print(accessTokens);
          // ignore: use_build_context_synchronously
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(S.of(context).error),
              content: Text(S.of(context).failedsaved),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(S.of(context).ok),
                ),
              ],
            ),
          );
        }
      } catch (e) {
        print('Error: $e');
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(S.of(context).error),
            content: Text(S.of(context).savingError),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(S.of(context).ok),
              ),
            ],
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xff1B185B),
          centerTitle: true,
          title: Text(
            S.of(context).myCart,
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontFamily: 'Merienda',
            ),
          )),
      backgroundColor: LoginPage.primaryColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final cart = Provider.of<Cart>(context, listen: false);
          await sendOrder(cart.cartItems);
        },
        child: Icon(Icons.save),
      ),
      body: Column(
        children: [
          Consumer<Cart>(
            builder: (context, cart, child) {
              return Expanded(
                child: ListView.builder(
                  itemCount: cart.cartItems.length,
                  itemBuilder: (context, i) {
                    return Card(
                      color: const Color(0xff2E2A9B),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: SizedBox.fromSize(
                              size: const Size.fromRadius(48),
                              child: Image.asset(
                                "image/BOITE-MEDICAMENT-04.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cart.cartItems[i].tradeName.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Merienda',
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                cart.cartItems[i].sientificName.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Merienda',
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(
                                width: 250,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${S.of(context).price} ${cart.cartItems[i].price}\$',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Merienda',
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      '${S.of(context).quantity} :${cart.cartItems[i].quantity}'
                                          .toString(),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontFamily: 'Merienda',
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        cart.remove(cart.cartItems[i]);
                                      },
                                      icon: const Icon(
                                        Icons.delete_outline_rounded,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class Cart with ChangeNotifier {
  final List<Product> _items = [];
  double _price = 0;

  double get totalPrice => _price;

  List<Product> get cartItems => _items;

  void add(Product item) {
    final existingItemIndex =
        _items.indexWhere((cartItem) => cartItem.id == item.id);

    if (existingItemIndex != -1) {
      _items[existingItemIndex].quantity += 1;
    } else {
      item.quantity = 1;
      _items.add(item);
    }

    notifyListeners();
  }

  void updateQuantity(Product item, int quantity) {
    item.quantity = quantity;
    _price = _calculateTotalPrice();
    notifyListeners();
  }

  void remove(Product item) {
    _items.remove(item);
    _price = _calculateTotalPrice();
    notifyListeners();
  }

  double _calculateTotalPrice() {
    double total = 0;
    for (var item in _items) {
      total += item.price.toDouble() * item.quantity;
    }
    return total;
  }
}
