import 'dart:convert';
import 'package:app5/screens/fav_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Favorite {
  Favorite({
    required this.data,
  });

  final List<Datum> data;

  factory Favorite.fromJson(Map<String, dynamic> json) {
    return Favorite(
      data: json["data"] == null
          ? []
          : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }
}

class Datum {
  Datum({
    required this.id,
    required this.img,
    required this.sientificName,
    required this.tradeName,
    required this.price,
    required this.expiration,
    required this.quantity,
    required this.manufactureName,
    required this.details,
    required this.sectionId,
    required this.createdAt,
    required this.updatedAt,
    required this.pivot,
  });

  final int? id;
  final String? img;
  final String? sientificName;
  final String? tradeName;
  final int? price;
  final DateTime? expiration;
  final int? quantity;
  final String? manufactureName;
  final String? details;
  final int? sectionId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Pivot? pivot;

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      id: json["id"],
      img: json["img"],
      sientificName: json["sientific_name"],
      tradeName: json["trade_name"],
      price: json["price"],
      expiration: DateTime.tryParse(json["expiration"] ?? ""),
      quantity: json["quantity"],
      manufactureName: json["manufacture_name"],
      details: json["details"],
      sectionId: json["section_id"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
    );
  }
}

class Pivot {
  Pivot({
    required this.userId,
    required this.medicinId,
  });

  final int? userId;
  final int? medicinId;

  factory Pivot.fromJson(Map<String, dynamic> json) {
    return Pivot(
      userId: json["user_id"],
      medicinId: json["medicin_id"],
    );
  }
}

class FavoriteCard extends StatefulWidget {
  FavoriteCard({Key? key}) : super(key: key);

  @override
  State<FavoriteCard> createState() => _FavoriteCardState();
}

class _FavoriteCardState extends State<FavoriteCard> {
  List<Datum> favorites = [];
  bool isLoading = true;
  String? accessToken;

  @override
  void initState() {
    super.initState();
    getAccessToken();
    fetchFavorites().catchError((e) {
      print('Error fetching favorites: $e');
    });
  }

  Future<void> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      accessToken = prefs.getString('access_token');
    });
  }

  Future<Favorite> fetchFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      accessToken = prefs.getString('access_token');
    });
    final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/api/show_fav'),
        headers: {'Authorization': 'Bearer $accessToken'});
    if (response.statusCode == 200) {
      print(accessToken);
      final Map<String, dynamic> jsonData = json.decode(response.body);

      print(favorites);
      final fav = Favorite.fromJson(jsonData);
      setState(() {
        favorites = fav.data.toList();
        isLoading = false;
      });
      return fav;
    } else {
      print(accessToken);
      throw Exception('${response.statusCode}');
    }
  }

  Future<void> deleteFromFavorites(String medicineId) async {
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/api/delete_fav'),
        body: {'id': medicineId},
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 200) {
        setState(() {
          fetchFavorites();
        });
      } else {
        throw Exception(
            'Failed to delete from favorites: ${response.statusCode}');
      }
    } catch (e) {
      print('Error deleting from favorites: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final favorite = favorites[index];
              return Card(
                color: const Color(0xff1B185B),
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
                          'image/BOITE-MEDICAMENT-02.png',
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      favorite.tradeName.toString(),
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      favorite.sientificName.toString(),
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[400],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          favorite.price.toString(),
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange[400],
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            deleteFromFavorites(favorite.id.toString());
                          },
                          icon: const Icon(
                            Icons.delete_outline_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
  }
}
