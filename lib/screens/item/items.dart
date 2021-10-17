// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:trapp_flutter/models/item.dart';
// import 'package:trapp_flutter/services/item_s.dart';
//
// import 'items.dart';
//
// class AllItems extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return StreamProvider<List<Item>>.value(
//       value: ItemService().items,
//       initialData: [],
//       child: Scaffold(
//         backgroundColor: Colors.lightBlueAccent[50],
//         appBar: AppBar(
//           title: Text('Items'),
//           backgroundColor: Colors.lightBlueAccent[300],
//           elevation: 0.0,
//         ),
//         body: Container(child: ItemsList()),
//       ),
//     );
//   }
// }
//
// class ItemsList extends StatefulWidget {
//   @override
//   _ItemsListState createState() => _ItemsListState();
// }
//
// class _ItemsListState extends State<ItemsList> {
//   @override
//   Widget build(BuildContext context) {
//     final items = Provider.of<List<Item>>(context);
//     bool isSwitched = false;
//
//     return ListView.builder(
//       itemCount: items.length,
//       itemBuilder: (context, index) {
//         return Card(
//           margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
//           child: ListTile(
//             leading: CircleAvatar(
//               radius: 25.0,
//             ),
//             title: Text(items[index].name),
//             trailing: new Switch(
//               value: isSwitched,
//               activeColor: Colors.pink,
//               activeTrackColor: Colors.pinkAccent,
//               onChanged: (value){
//                 setState(() {
//                   isSwitched = value;
//                 });
//               },
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
