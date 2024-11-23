// import 'package:flutter/material.dart';
// import 'package:our_web_app/components/costum_drawer.dart';

// class UserDetails extends StatefulWidget {
//   const UserDetails({super.key});
//   static String id = "userdetails";
//   @override
//   State<UserDetails> createState() => _UserDetailsState();
// }

// class _UserDetailsState extends State<UserDetails> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: Padding(
//         padding: const EdgeInsets.only(right: 75, bottom: 75),
//         child: FloatingActionButton(
//             clipBehavior: Clip.none,
//             backgroundColor: const Color(0xff423636),
//             onPressed: () {},
//             child: const Text(
//               '+',
//               style: TextStyle(fontSize: 24, color: Colors.white),
//             )),
//       ),
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
//       body: Padding(
//         padding: const EdgeInsets.only(top: 80),
//         child: ListView(
//           children: [
//             ClipRRect(
//               child: Image.asset(
//                 "user.jpg",
//                 height: 200,
//               ),
//             ),
//             SizedBox(
//               height: 32,
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 310),
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       userbardetails(),
//                       userbardetails(),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 40,
//                   ),
//                   Row(
//                     children: [
//                       userbardetails(),
//                       userbardetails(),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 40,
//                   ),
//                   Row(
//                     children: [
//                       userbardetails(),
//                       userbardetails(),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class userbardetails extends StatelessWidget {
//   const userbardetails({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(
//         children: [
//           Text(
//             "User name",
//             style: TextStyle(fontSize: 24),
//           ),
//           Container(
//             width: 300,
//             height: 1,
//             color: Colors.black,
//           )
//         ],
//       ),
//     );
//   }
// }
