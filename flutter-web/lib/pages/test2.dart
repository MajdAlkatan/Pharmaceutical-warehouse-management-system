// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class Medicine {
//   final int id;
//   final String sientificname;
//   final String tradeName;
//   final String img;


//   Medicine({
//     required this.id,
//     required this.sientificname,
//     required this.tradeName,
//     required this.img,
    
//   });

//   factory Medicine.fromJson(Map<String, dynamic> json) {
//     return Medicine(
//       id: json['id'],
//       sientificname: json['sientific_name'],
//       tradeName: json['trade_name'],
//       img: json['img'],
     
//     );
//   }
// }

// Future<List<Medicine>> fetchMedicinesBySection(String sectionName) async {
//   final url = Uri.parse('http://127.0.0.1:8000/api/show_medicins/$sectionName');

//   final response = await http.get(url);

//   if (response.statusCode == 200) {
//     final jsonData = json.decode(response.body) as List<dynamic>;
//     final medicines = jsonData.map((item) => Medicine.fromJson(item)).toList();
//     return medicines;
//   } else {
//     throw Exception('Failed to fetch medicines');
//   }
// }

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   List<Medicine> data = [];
//   String selectedSectionName ='majd';

//   @override
//   void initState() {
//     super.initState();
//     fetchmedicin();
//   }

//   Future<void> fetchmedicin() async {
      
//     try {
//     final medicines = await fetchMedicinesBySection(selectedSectionName);
//       setState(() {
//         data = medicines;
//       });
//     } catch (e) {
//       // Handle error case
//       print(e.toString());
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Medicines by Section'),
//       ),
//       body: ListView.builder(
//         itemCount: data.length,
//         itemBuilder: (BuildContext context, int index) {
//           final medicine = data[index];
//           return ListTile(
//             leading: Image.asset('assets/bill 1.jpg',width: 100,height: 100,),
//             title: Text(medicine.tradeName),
//             subtitle: Text(medicine.sientificname),
//           );
//         },
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Medicines App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: HomePage(),
//     );
//   }
// }