// import 'package:flutter/material.dart';
// import 'package:our_web_app/components/clip_image.dart';

// class CostumContainer extends StatefulWidget {
//   const CostumContainer({
//     super.key,
//   });

//   @override
//   State<CostumContainer> createState() => _CostumContainerState();
// }

// class _CostumContainerState extends State<CostumContainer> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 85, right: 85),
//       child: Container(
//         height: 300,
//         padding: const EdgeInsets.all(20),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20),
//           color: const Color.fromARGB(255, 51, 138, 238),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Expanded(
//                   child: Text(
//                     textAlign: TextAlign.center,
//                     'Welcome Back...',
//                     style: TextStyle(color: Colors.white, fontSize: 40),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(right: 25),
//                   child: TextButton(
//                     style: ButtonStyle(
//                       backgroundColor: MaterialStatePropertyAll(
//                         Colors.blue[900],
//                       ),
//                     ),
//                     onPressed: () {},
//                     child: const Text(
//                       'Delete Product',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const Padding(
//               padding:
//                   EdgeInsets.only(left: 150, right: 150, top: 10, bottom: 10),
//               child: TextField(
//                 decoration: InputDecoration(
//                   prefixIcon: Icon(Icons.search),
//                   filled: true,
//                   fillColor: Colors.white,
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(20),
//                     ),
//                   ),
//                 ),
//               ),
//             ),

//             // Nested List View
//             SizedBox(
//               width: 500,
//               height: 113,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: 5,
//                 itemBuilder: (BuildContext context, int index) {
//                   return ClipImage(
//                     name: 'product ${index + 1}',
//                     image: 'assets/bill 3.jpeg',
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
