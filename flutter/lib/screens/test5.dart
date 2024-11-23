import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Bills {
  Bills({
    required this.data,
  });

  final Map<String, Datum> data;

  factory Bills.fromJson(Map<String, dynamic> json) {
    return Bills(
      data: Map.from(json["data"]).map(
        (k, v) => MapEntry<String, Datum>(k, Datum.fromJson(v)),
      ),
    );
  }
}

class Datum {
  Datum({
    required this.name,
    required this.state,
    required this.pay,
    required this.date,
    required this.total,
    required this.medicinWithQuantity,
  });

  final String name;
  final String state;
  final String pay;
  final DateTime? date;
  final int? total;
  final List<MedicinWithQuantity> medicinWithQuantity;

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      name: json["name"],
      state: json["state"],
      pay: json["pay"],
      date: DateTime.tryParse(json["data"] ?? ""),
      total: json["total"],
      medicinWithQuantity: json["medicin_with_quantity"] == null
          ? []
          : List<MedicinWithQuantity>.from(json["medicin_with_quantity"]
              .map((x) => MedicinWithQuantity.fromJson(x))),
    );
  }
}

class MedicinWithQuantity {
  MedicinWithQuantity({
    required this.medicineName,
    required this.quantity,
  });

  final String? medicineName;
  final int? quantity;

  factory MedicinWithQuantity.fromJson(Map<String, dynamic> json) {
    return MedicinWithQuantity(
      medicineName: json["medicine_name"],
      quantity: json["quantity"],
    );
  }
}

class BillsPage extends StatefulWidget {
  @override
  State<BillsPage> createState() => _BillsPageState();
}

class _BillsPageState extends State<BillsPage> {
  String? accessToken;

  Future<List<Bills>> fetchBills() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      accessToken = prefs.getString('access_token');
    });
    print(accessToken);

    accessToken = prefs.getString('access_token');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };

    final response = await http.get(
      Uri.parse('http://10.0.2.2:8000/api/ShowMyBills'),
      headers: headers,
    );
    if (response.statusCode == 200) {
      print(response.body);

      final Map<String, dynamic> jsonData = jsonDecode(response.body)['data'];
      return jsonData.values
          .map((billData) => Bills.fromJson(billData))
          .toList();
    } else {
      throw Exception('Failed to fetch bills');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bills'),
      ),
      body: FutureBuilder<List<Bills>>(
        future: fetchBills(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No data available'));
          } else {
            final billList = snapshot.data!;
            return ListView.builder(
              itemCount: billList.length,
              itemBuilder: (context, index) {
                final bill = billList[index];
                return MyCustomBill(bill: bill);
              },
            );
          }
        },
      ),
    );
  }
}

class MyCustomBill extends StatelessWidget {
  final Bills bill;

  const MyCustomBill({
    required this.bill,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[800],
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
                  'Date: ${bill.data.values.first.date}',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'DetailsBillPage');
                  },
                  icon: const Icon(
                    Icons.circle,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'Name: ${bill.data.values.first.name}',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            const SizedBox(height: 10),
            Text(
              'State: ${bill.data.values.first.state}',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            const SizedBox(height: 10),
            Text(
              'Pay: ${bill.data.values.first.pay}',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            const SizedBox(height: 10),
            Text(
              'Total: ${bill.data.values.first.total}',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            const SizedBox(height: 10),
            Text(
              'Medicine with Quantity:',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            Column(
              children: bill.data.values.first.medicinWithQuantity
                  .map((medicinWithQuantity) {
                return Text(
                  '${medicinWithQuantity.medicineName}: ${medicinWithQuantity.quantity}',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Bills App',
    initialRoute: '/',
    routes: {
      '/': (context) => BillsPage(),
      'DetailsBillPage': (context) => DetailsBillPage(),
    },
  ));
}

class DetailsBillPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details Bill'),
      ),
      body: Center(
        child: Text('Details Bill Page'),
      ),
    );
  }
}
