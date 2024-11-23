import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:our_web_app/generated/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Reportweb {
  Reportweb({
    required this.data,
  });

  final List<Datum> data;

  factory Reportweb.fromJson(Map<String, dynamic> json) {
    return Reportweb(
      data: json["data"] == null
          ? []
          : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }
}

class Datum {
  Datum({
    required this.id,
    required this.userId,
    required this.medicinId,
    required this.sectionId,
    required this.medicinMany,
    required this.billsDidntK,
    required this.time,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    required this.section,
    required this.medicin,
  });

  final int? id;
  final int? userId;
  final int? medicinId;
  final int? sectionId;
  final int? medicinMany;
  final int? billsDidntK;
  final String? time;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final User? user;
  final Section? section;
  final Medicin? medicin;

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      id: json["id"],
      userId: json["user_id"],
      medicinId: json["medicin_id"],
      sectionId: json["section_id"],
      medicinMany: json["medicin_many"],
      billsDidntK: json["bills_didnt_k"],
      time: json["time"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      user: json["user"] == null ? null : User.fromJson(json["user"]),
      section:
          json["section"] == null ? null : Section.fromJson(json["section"]),
      medicin:
          json["medicin"] == null ? null : Medicin.fromJson(json["medicin"]),
    );
  }
}

class Medicin {
  Medicin({
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

  factory Medicin.fromJson(Map<String, dynamic> json) {
    return Medicin(
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
    );
  }
}

class Section {
  Section({
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

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      id: json["id"],
      name: json["name"],
      img: json["img"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }
}

class User {
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.pharmacyName,
    required this.location,
    required this.number,
    required this.img,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final String? name;
  final String? email;
  final String? pharmacyName;
  final String? location;
  final String? number;
  final dynamic img;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      pharmacyName: json["pharmacy_name"],
      location: json["location"],
      number: json["number"],
      img: json["img"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }
}

// Define the User, Section, and Medicin classes similarly
class ReportsPage extends StatefulWidget {
  const ReportsPage({Key? key}) : super(key: key);

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  String? accessToken;
  Reportweb? fetchedReport;

  @override
  void initState() {
    super.initState();
    fetchReports();
  }

  Future<void> fetchReports() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      accessToken = prefs.getString('access_token');
    });

    try {
      final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/api/ShowReports'),
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        setState(() {
          fetchedReport = Reportweb.fromJson(jsonData);
        });
        // print(accessToken);
      } else {
        throw Exception('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      // print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/family doctor.jpg', height: 100, width: 250),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_suggest_sharp),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications_active_outlined),
            onPressed: () {},
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: InkWell(
              borderRadius: BorderRadius.circular(50),
              onTap: () {},
              child: Image.asset('assets/user_image.jpg'),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: fetchedReport == null
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: fetchedReport!.data.length,
                itemBuilder: (BuildContext context, int index) {
                  Datum report = fetchedReport!.data[index];
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: Card(
                      elevation: 20,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${S.of(context).reportNumber} ${report.id}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${S.of(context).medicineId} ${report.medicin!.sientificName}',
                                style: const TextStyle(color: Colors.black),
                              ),
                              Text(
                                '${S.of(context).userId} ${report.user!.name}',
                                style: const TextStyle(color: Colors.black),
                              ),
                              Text(
                                '${S.of(context).sectionId} ${report.section!.name}',
                                style: const TextStyle(color: Colors.black),
                              ),
                              Text(
                                '${S.of(context).medicineMany} ${report.medicinMany}',
                                style: const TextStyle(color: Colors.black),
                              ),
                              Text(
                                '${S.of(context).billsDidntK} ${report.billsDidntK}',
                                style: const TextStyle(color: Colors.black),
                              ),
                              Text(
                                '${S.of(context).time} ${report.time}',
                                style: const TextStyle(color: Colors.black),
                              ),
                              Text(
                                '${S.of(context).createdAt} ${report.createdAt!.year}- ${report.createdAt!.month}- ${report.createdAt!.day}',
                                style: const TextStyle(color: Colors.black),
                              ),
                              Text(
                                '${S.of(context).updatedAt} ${report.updatedAt!.year}-${report.updatedAt!.month}-${report.updatedAt!.day}',
                                style: const TextStyle(color: Colors.black),
                              )
                            ]),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
