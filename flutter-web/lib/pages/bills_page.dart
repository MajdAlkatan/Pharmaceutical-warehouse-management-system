// ignore_for_file: non_constant_identifier_names, prefer_const_declarations

import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:our_web_app/generated/l10n.dart';
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
  final dynamic BillId;
  final String name;
  final String state;
  String pay;
  final DateTime date;
  final int total;
  final List<MedicineWithQuantity> medicineWithQuantity;

  Bill({
    required this.BillId,
    required this.name,
    required this.state,
    required this.pay,
    required this.date,
    required this.total,
    required this.medicineWithQuantity,
  });

  factory Bill.fromJson(Map<String, dynamic> json) {
    return Bill(
      BillId: json['BillId'],
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

int x = 0;
String? accessToken;
BillsData? id;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bills App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BillsPage(),
    );
  }
}

class BillsPage extends StatefulWidget {
  const BillsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BillsPageState createState() => _BillsPageState();
}

class _BillsPageState extends State<BillsPage> {
  @override
  void initState() {
    super.initState();
    getAccessToken();
  }

  Future<void> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      accessToken = prefs.getString('access_token');
    });
  }

  Future<BillsData> fetchBills() async {
    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/api/ShowBillsByState/$x'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      },
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      // print(accessToken);
      return BillsData.fromJson(jsonData);
    } else {
      throw Exception('Failed to fetch bills: ${response.statusCode}');
    }
  }

  Future<void> updateBillState(int billId, int stateNumber) async {
    // Your endpoint URL
    final String apiUrl = 'http://127.0.0.1:8000/api/change_state_of_bills';

    // Prepare the request body
    final Map<String, dynamic> requestBody = {
      'id': billId,
      'state': stateNumber,
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer $accessToken', // Make sure accessToken is set
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        // Handle success
        // print('Bill state updated successfully');
      } else {
        // Handle errors
        // print('Failed to update bill state: ${response.statusCode}');
      }
    } catch (e) {
      // print('Exception while updating bill state: $e');
      // Handle exceptions
    }
  }

  Future<void> Changepay(int billId) async {
    // Your endpoint URL
    final String apiUrl = 'http://127.0.0.1:8000/api/change_pay';

    // Prepare the request body
    final Map<String, dynamic> requestBody = {
      'id': billId,
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer $accessToken', // Make sure accessToken is set
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        // Handle success
        // print('Bill state updated successfully');
      } else {
        // Handle errors
        // print('Failed to update bill state: ${response.statusCode}');
      }
    } catch (e) {
      // print('Exception while updating bill state: $e');
      // Handle exceptions
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/family doctor.jpg', height: 100, width: 250),
        actions: [
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 50, // Adjust the height as needed
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      x = index;
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: x == index ? Colors.blue : Colors.grey,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      index == 0
                          ? S.of(context).inPreparation
                          : index == 1
                              ? S.of(context).hasBeenSent
                              : index == 2
                                  ? S.of(context).itWasReceived
                                  : '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 300),
              child: FutureBuilder<BillsData>(
                future: fetchBills(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('100w.gif'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                          child: Container(),
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('100w.gif'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                          child: Container(),
                        ),
                      ),
                    );
                  } else {
                    final billList = snapshot.data!.data.values.toList();
                    return ListView.builder(
                      itemCount: billList.length,
                      itemBuilder: (context, index) {
                        final bill = billList[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colors.black),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      '${S.of(context).date} ${bill.date.day}-${bill.date.month}-${bill.date.year}',
                                      style: const TextStyle(
                                          fontSize: 18, color: Colors.black),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title:
                                                Text(S.of(context).changeState),
                                            content: Text(
                                                '${S.of(context).changeState} ${bill.name} ${S.of(context).question}'),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  if (bill.state == '0') {
                                                    setState(() {
                                                      updateBillState(
                                                          bill.BillId, 1);
                                                    });
                                                  } else if (bill.state ==
                                                      '1') {
                                                    setState(() {
                                                      updateBillState(
                                                          bill.BillId, 2);
                                                    });
                                                  } else if (bill.state ==
                                                      '2') {
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) =>
                                                            AlertDialog(
                                                              title: Text(S
                                                                  .of(context)
                                                                  .cantUpdateTheState),
                                                            ));
                                                  }
                                                  // print(index);
                                                  Navigator.of(context).pop();
                                                },
                                                child:
                                                    Text(S.of(context).update),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child:
                                                    Text(S.of(context).cancel),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      icon: const Icon(
                                        FontAwesomeIcons.circleExclamation,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                DataTable(
                                  border: TableBorder.all(color: Colors.black),
                                  columns: [
                                    DataColumn(
                                      label: Text(
                                        S.of(context).medicineName,
                                        style: const TextStyle(
                                            fontSize: 32, color: Colors.black),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        S.of(context).quantity,
                                        style: const TextStyle(
                                            fontSize: 32, color: Colors.black),
                                      ),
                                    ),
                                  ],
                                  rows:
                                      bill.medicineWithQuantity.map((medicine) {
                                    return DataRow(
                                      cells: [
                                        DataCell(
                                          Text(
                                            medicine.medicineName,
                                            style: const TextStyle(
                                                fontSize: 32,
                                                color: Colors.black),
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            medicine.quantity.toString(),
                                            style: const TextStyle(
                                                fontSize: 32,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ],
                                    );
                                  }).toList(),
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      '${S.of(context).total} ${bill.total}',
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.black),
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
                                          fontSize: 14, color: Colors.black),
                                    ),
                                    IconButton(
                                      icon: bill.pay == '1'
                                          ? const Icon(Icons.check_box_outlined,
                                              color: Colors
                                                  .black) // Icon when pay is '1'
                                          : const Icon(
                                              Icons
                                                  .check_box_outline_blank_outlined,
                                              color: Colors
                                                  .black), // Icon for other states
                                      onPressed: () {
                                        setState(() {
                                          Changepay(bill.BillId);
                                        });
                                      },
                                    ),
                                    Text(bill.pay == '1'
                                        ? S.of(context).thePaymentWasMade
                                        : bill.pay == '0'
                                            ? S
                                                .of(context)
                                                .paymentHasNotBeenMade
                                            : '')
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
