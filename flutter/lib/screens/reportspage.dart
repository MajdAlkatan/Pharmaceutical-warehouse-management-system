import 'dart:convert';
import 'package:app5/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Report {
  Report({
    required this.data,
  });

  final List<Datum> data;

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      data: json["data"] == null
          ? []
          : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }
}

class Datum {
  Datum({
    required this.medicinMany,
    required this.billsDidntK,
    required this.id,
    required this.date,
  });

  final int? medicinMany;
  final int? billsDidntK;
  final int? id;
  final DateTime? date;

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      medicinMany: json["medicin_many"],
      billsDidntK: json["bills_didnt_k"],
      id: json["id"],
      date: DateTime.tryParse(json["date"] ?? ""),
    );
  }
}

class Reports extends StatefulWidget {
  const Reports({Key? key}) : super(key: key);

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  late List<Datum> _reports = []; // List to hold the fetched reports
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchReports();
  }

  String? accessToken;

  Future<void> fetchReports() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      accessToken = prefs.getString('access_token');
    });

    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/api/ShowMyReports'),
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        print(jsonData);
        setState(() {
          _reports = Report.fromJson(jsonData).data;
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1B185B),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          S.of(context).myReports,
          style: TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontFamily: 'Merienda',
          ),
        ),
        backgroundColor: Color(0xff1B185B),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Card(
                elevation: 20.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'image/300w.gif', // Replace 'your_gif_file.gif' with your GIF file path
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                  ),
                ),
              ),
              Expanded(
                child: _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : _reports.isEmpty
                        ? Center(child: Text(S.of(context).noDataAvailable))
                        : ListView.builder(
                            itemCount: _reports.length,
                            itemBuilder: (context, index) {
                              Datum report = _reports[index];
                              return Card(
                                color: Colors.black.withOpacity(0.1),
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${S.of(context).medicinMany} ${report.medicinMany}',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        '${S.of(context).billsDidntK} ${report.billsDidntK}',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        '${S.of(context).createdAt} ${report.date!.year}-${report.date!.month}-${report.date!.day}',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
