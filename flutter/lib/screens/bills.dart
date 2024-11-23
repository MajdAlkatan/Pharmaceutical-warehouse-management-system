import 'dart:convert';
import 'package:app5/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class BillsData {
  final Map<String, Bill> data;

  BillsData({required this.data});

  factory BillsData.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> data = json['data'];
    final parsedData =
        data.map((key, value) => MapEntry(key, Bill.fromJson(value)));
    return BillsData(data: parsedData);
  }
}

class Bill {
  final String name;
  final String state;
  final String pay;
  final DateTime date;
  final int total;
  final List<MedicineWithQuantity> medicineWithQuantity;

  Bill({
    required this.name,
    required this.state,
    required this.pay,
    required this.date,
    required this.total,
    required this.medicineWithQuantity,
  });

  factory Bill.fromJson(Map<String, dynamic> json) {
    return Bill(
      name: json['name'],
      state: json['state'],
      pay: json['pay'],
      date: DateTime.parse(json['date']),
      total: json['total'],
      medicineWithQuantity: (json['medicin_with_quantity'] as List<dynamic>)
          .map((medicine) =>
              MedicineWithQuantity.fromJson(medicine as Map<String, dynamic>))
          .toList(),
    );
  }
}

class MedicineWithQuantity {
  final String medicineName;
  final int quantity;

  MedicineWithQuantity({required this.medicineName, required this.quantity});

  factory MedicineWithQuantity.fromJson(Map<String, dynamic> json) {
    return MedicineWithQuantity(
      medicineName: json['medicine_name'],
      quantity: json['quantity'],
    );
  }
}

String? accessToken;

class BillsPage extends StatefulWidget {
  @override
  _BillsPageState createState() => _BillsPageState();
}

class _BillsPageState extends State<BillsPage> {
  List<Bill> _bills = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getBillsData();
  }

  Future<void> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      accessToken = prefs.getString('access_token');
    });
  }

  Future<void> getBillsData() async {
    await getAccessToken();

    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/api/ShowMyBills'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken'
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        final billsData = BillsData.fromJson(jsonData);
        setState(() {
          _bills = billsData.data.values.toList();
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to fetch bills: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff1B185B),
        centerTitle: true,
        title: Text(
          S.of(context).billsPage,
          style: TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontFamily: 'Merienda',
          ),
        ),
      ),
      backgroundColor: Color(0xff1B185B),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _bills.isEmpty
              ? Center(child: Text(S.of(context).noBillsAvailable))
              : ListView.builder(
                  itemCount: _bills.length,
                  itemBuilder: (context, index) {
                    final bill = _bills[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xff2A284A),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.white),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  '${S.of(context).date} ${bill.date.day}-${bill.date.month}-${bill.date.year}',
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    FontAwesomeIcons.circleExclamation,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            DataTable(
                              border: TableBorder.all(color: Colors.white),
                              columns: [
                                DataColumn(
                                  label: Text(
                                    S.of(context).medicineName,
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    S.of(context).quantity,
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  ),
                                ),
                              ],
                              rows: bill.medicineWithQuantity.map((medicine) {
                                return DataRow(
                                  cells: [
                                    DataCell(
                                      Text(
                                        medicine.medicineName,
                                        style: const TextStyle(
                                            fontSize: 12, color: Colors.white),
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        medicine.quantity.toString(),
                                        style: const TextStyle(
                                            fontSize: 12, color: Colors.white),
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  '${S.of(context).total} ${bill.total}',
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                                Text(
                                  bill.state == '0'
                                      ? S.of(context).inPreparation
                                      : bill.state == '1'
                                          ? S.of(context).hasBeenSent
                                          : bill.state == '2'
                                              ? S.of(context).itWasReceived
                                              : '',
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
