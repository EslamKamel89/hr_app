// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';

// class MyTabbedScreen extends StatelessWidget {
//   // Define the tab titles
//   final List<String> tabs = [
//     "Basic",
//     "Contact",
//     "Address",
//     "Departments",
//     "Bank Details",
//     "Legal Details",
//     "Attachments",
//     "Additional Info",
//   ];

//   const MyTabbedScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: tabs.length, // Set the number of tabs
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text("User Dashboard"),
//           bottom: TabBar(
//             isScrollable: true, // Makes the tab bar scrollable
//             indicatorColor: Colors.white,
//             labelStyle: TextStyle(fontWeight: FontWeight.bold),
//             tabs: tabs.map((tab) => Tab(text: tab)).toList(),
//           ),
//         ),
//         body: TabBarView(
//           children:
//               tabs.map((tab) {
//                 // Each tab content is centered with a text
//                 return Center(
//                   child: Text(
//                         "Content for $tab",
//                         style: TextStyle(fontSize: 20),
//                       )
//                       // Animate the content with a fade in and slight slide
//                       .animate()
//                       .fadeIn(duration: Duration(milliseconds: 500))
//                       .slide(
//                         begin: Offset(0, 0.1),
//                         duration: Duration(milliseconds: 500),
//                       ),
//                 );
//               }).toList(),
//         ),
//       ),
//     );
//   }
// }
