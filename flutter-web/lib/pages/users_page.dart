// import 'package:flutter/material.dart';
// import 'package:our_web_app/components/costum_container.dart';
// import 'package:our_web_app/components/costum_drawer.dart';

// class UsersPage extends StatelessWidget {
//   const UsersPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: const CostumDrawer(),
//       appBar: AppBar(
//         title: Image.asset('assets/family doctor.jpg', height: 100, width: 250),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.settings_suggest_sharp),
//             onPressed: () {},
//           ),
//           IconButton(
//             icon: const Icon(Icons.notifications_active_outlined),
//             onPressed: () {},
//           ),
//           ClipRRect(
//             borderRadius: BorderRadius.circular(50),
//             child: InkWell(
//               borderRadius: BorderRadius.circular(50),
//               onTap: () {},
//               child: Image.asset('assets/user_image.jpg'),
//             ),
//           ),
//         ],
//       ),
//       body: Stack(
//         children: [
//           ListView(
//             children: [
//               const SizedBox(
//                 height: 220,
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 85, right: 85),
//                 child: GridView.builder(
//                   physics: const AlwaysScrollableScrollPhysics(),
//                   scrollDirection: Axis.vertical,
//                   shrinkWrap: true,
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 3, // Number of columns
//                       crossAxisSpacing: 130

//                       // Spacing between rows
//                       ),
//                   itemCount: 15,
//                   itemBuilder: (context, index) {
//                     return Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(100),
//                           child: Image.asset(
//                             'assets/bill 1.jpg',
//                             height: 200,
//                           ),
//                         ),
//                         const Expanded(
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 'UserName',
//                                 style: TextStyle(
//                                     color: Colors.black, fontSize: 16),
//                               ),
//                               Text(
//                                 '+963 947 502 298',
//                               ),
//                             ],
//                           ),
//                         )
//                       ],
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//           const CostumContainer(),
//         ],
//       ),
//     );
//   }
// }
