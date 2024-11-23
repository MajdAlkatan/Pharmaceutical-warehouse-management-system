import 'dart:convert';

import 'package:app5/generated/l10n.dart';
import 'package:app5/screens/cartpage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page.dart';

class ItemsDetails extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables

  static String id = "itemdetails";
  // ignore: prefer_const_constructors_in_immutables
  ItemsDetails({super.key, required this.data});
  final Product data;

  @override
  State<ItemsDetails> createState() => _ItemsDetailsState();
}

class _ItemsDetailsState extends State<ItemsDetails> {
  int? y;
  int x = 0;
  String? accessToken;
  bool isFavorited = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAccessToken();
  }

  Future<void> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      accessToken = prefs.getString('access_token');
    });
  }

  Future<void> addToFavorites(int medicineId) async {
    // Your endpoint URL to add to favorites
    const String apiUrl = 'http://10.0.2.2:8000/api/add_fav';

    try {
      final response = await http.post(Uri.parse(apiUrl), headers: {
        'Authorization': 'Bearer $accessToken'
      }, body: {
        'id': medicineId.toString(),
      });

      if (response.statusCode == 200) {
        // Handle success6
        print('Added to favorites successfully');
        print(accessToken);
        print(widget.data.id);
        setState(() {
          isFavorited = true;
        });
        // You may add further UI updates or navigate back to the previous screen
      } else {
        // Handle other status codes or errors

        print('Failed to add to favorites: ${response.statusCode}');
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(S.of(context).failedToAddToFavorites),
              content: Text(S.of(context).failedToAddToFavorites),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(S.of(context).ok),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      print('Exception while adding to favorites: $e');
      // Handle exception
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1B185B),

      // ignore: prefer_const_constructors
      endDrawer: Drawer(),
      appBar: AppBar(
        backgroundColor: const Color(0xff1B185B),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.grey),
        title: Text(
          S.of(context).detailsPage,
          style: TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontFamily: 'Merienda',
          ),
        ),
      ),
      body: ListView(children: [
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset('image/BOITE-MEDICAMENT-04.png')),
        ),
        const SizedBox(
          height: 10,
        ),
        // ignore: avoid_unnecessary_containers
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,

            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${S.of(context).scientificName} : ${widget.data.sientificName}",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.orange[400]),
              ),
              const SizedBox(
                height: 10,
              ),
              // ignore: avoid_unnecessary_containers
              Container(
                child: Text(
                  "${S.of(context).tradeName} : ${widget.data.tradeName}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.orange[400], fontWeight: FontWeight.bold),
                ),
              ),

              const SizedBox(
                height: 10,
              ),
              Text(
                "${S.of(context).manufactureCompany} :${widget.data.manufactureName}",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.orange[400], fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "${S.of(context).category} :",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.orange[400], fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "${S.of(context).thePrice} :${widget.data.price}",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.orange[400], fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "${S.of(context).expriationDate} :${widget.data.expiration}",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.orange[400], fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "${S.of(context).quantity} :${widget.data.quantity} ",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.orange[400], fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 10,
              ),

              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Consumer<Cart>(builder: (context, cart, child) {
              return ElevatedButton(
                  onPressed: () {
                    setState(() {
                      addToFavorites(widget.data.id);
                    });
                  },
                  child: Center(
                    child: Text(S.of(context).addToFavorites),
                  ));
            }),
            Icon(
              isFavorited ? Icons.favorite : Icons.favorite_border,
              color: isFavorited ? Colors.red : null,
            ),
          ],
        )
      ]),
    );
  }
}
