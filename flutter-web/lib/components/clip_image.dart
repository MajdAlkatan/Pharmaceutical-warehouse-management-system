// import 'dart:convert';

// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';


// class ClipImage extends StatefulWidget {
//   ClipImage({
//     required this.name,
//     required this.image,
//     Key? key,
//   }) : super(key: key);

//   final String image;
//   final String name;

//   @override
//   State<ClipImage> createState() => _ClipImageState();
// }

// class _ClipImageState extends State<ClipImage> {
 

//   void showMedicine(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Medicine'),
//           content: ListView.builder(
//             shrinkWrap: true,
//             itemCount: data.length,
//             itemBuilder: (BuildContext context, int index) {
//               final medicine = data[index];
//               return ListTile(
//                 title: Text(medicine.name),
//                 subtitle: Text(medicine.tradeName),
//                 leading: Image.network(medicine.img),
//               );
//             },
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('Close'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return 
//   }
// }
