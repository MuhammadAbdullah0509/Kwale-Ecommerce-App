// import 'package:flutter/material.dart';
//
// class ChatScreen extends StatefulWidget {
//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }
//
// class _ChatScreenState extends State<ChatScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Chat'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.more_vert),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: Container(
//               color: Colors.grey.shade200,
//               child: ListView.builder(
//                 reverse: true,
//                 itemCount: 10, // Replace this with the actual number of messages
//                 itemBuilder: (context, index) {
//                   // Replace this with the actual message list UI
//                   return const ListTile(
//                     title: Text('Sender Name'),
//                     subtitle: Text('Message text goes here'),
//                     leading: CircleAvatar(
//                       backgroundColor: Colors.blue,
//                       child: Text('SN'), // Replace with the sender's initials or profile image
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
//             decoration: const BoxDecoration(
//               color: Colors.white,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black12,
//                   offset: Offset(0, -2),
//                   blurRadius: 4,
//                 ),
//               ],
//             ),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     decoration: const InputDecoration.collapsed(
//                       hintText: 'Type a message...',
//                     ),
//                     textInputAction: TextInputAction.send,
//                     onSubmitted: (value) {
//                       // Send the message functionality
//                     },
//                   ),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.send),
//                   onPressed: () {
//                     // Send the message functionality
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
