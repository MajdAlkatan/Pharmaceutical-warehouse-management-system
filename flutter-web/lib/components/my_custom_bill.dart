// // ignore_for_file: library_private_types_in_public_api

// import 'package:flutter/material.dart';

// class MyCustomBill extends StatefulWidget {
//   const MyCustomBill({Key? key}) : super(key: key);

//   @override
//   _MyCustomBillState createState() => _MyCustomBillState();
// }

// class _MyCustomBillState extends State<MyCustomBill> {
//   List<bool> isIconClickedList = List.generate(9, (index) => false);

//   void _handleIconClick(int index) {
//     setState(() {
//       isIconClickedList[index] = !isIconClickedList[index];
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(30),
//           border: Border.all(color: Colors.black),
//         ),
//         padding: const EdgeInsets.symmetric(vertical: 10),
//         child: Column(
//           children: [
//             const SizedBox(
//               height: 5,
//             ),
//             DataTable(
//               border: const TableBorder(
//                 verticalInside: BorderSide(color: Colors.black),
//                 right: BorderSide(color: Colors.black),
//                 left: BorderSide(color: Colors.black),
//                 top: BorderSide(color: Colors.black),
//                 bottom: BorderSide(color: Colors.black),
//               ),
//               columns: const [
//                 DataColumn(
//                   label: Text(
//                     'Date',
//                     style: TextStyle(fontSize: 18, color: Colors.black),
//                   ),
//                 ),
//                 DataColumn(
//                   label: Text(
//                     'Description',
//                     style: TextStyle(fontSize: 18, color: Colors.black),
//                   ),
//                 ),
//                 DataColumn(
//                   label: Text(
//                     'Bills State',
//                     style: TextStyle(fontSize: 18, color: Colors.black),
//                   ),
//                 ),
//                 DataColumn(
//                   label: Text(
//                     'Paid',
//                     style: TextStyle(fontSize: 18, color: Colors.black),
//                   ),
//                 ),
//                 DataColumn(
//                   label: Text(
//                     'Amount',
//                     style: TextStyle(fontSize: 18, color: Colors.black),
//                   ),
//                 ),
//               ],
//               rows: List<DataRow>.generate(
//                 8,
//                 (index) => DataRow(
//                   cells: [
//                     const DataCell(
//                       Text(
//                         'majd',
//                         style: TextStyle(fontSize: 12, color: Colors.black),
//                       ),
//                     ),
//                     const DataCell(
//                       Text(
//                         'alaa',
//                         style: TextStyle(fontSize: 12, color: Colors.black),
//                       ),
//                     ),
//                     const DataCell(
//                       Text(
//                         'king',
//                         style: TextStyle(fontSize: 12, color: Colors.black),
//                       ),
//                     ),
//                     DataCell(
//                       InkWell(
//                           onTap: () => _handleIconClick(index),
//                           child: isIconClickedList[index]
//                               ? const Icon(Icons.check, size: 30)
//                               : const Icon(
//                                   Icons.check_box_outline_blank,
//                                   size: 30,
//                                   color: Colors.black,
//                                 )),
//                     ),
//                     const DataCell(
//                       Text(
//                         '',
//                         style: TextStyle(fontSize: 12, color: Colors.black),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const Padding(
//               padding: EdgeInsets.all(10),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Text(
//                     'Totaly:',
//                     style: TextStyle(
//                         fontSize: 18,
//                         color: Colors.black,
//                         fontWeight: FontWeight.bold),
//                   ),
//                   Text(
//                     'State:',
//                     style: TextStyle(fontSize: 18, color: Colors.black),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
