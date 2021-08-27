// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'todo_addpage.dart';

// //This function will contains all the task and slidable function.
// class buildtask extends StatefulWidget {
//   buildtask({Key? key}) : super(key: key);

//   @override
//   _buildtaskState createState() => _buildtaskState();
// }

// class _buildtaskState extends State<buildtask> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//       child: Slidable(
//         actionPane: SlidableDrawerActionPane(),
//         actionExtentRatio: 0.25,
//         child: Container(
//           decoration: BoxDecoration(
//             color: Colors.red[100],
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: ListTile(
//             title: Text('title'),
//             subtitle: Text('Description'),
//             onTap: () => Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (_) => Addpage(),
//               ),
//             ),
//           ),
//         ),
//         secondaryActions: [
//           Padding(
//             padding: const EdgeInsets.all(12.0),
//             child: IconSlideAction(
            //   caption: 'Delete',
            //   color: Colors.red,
            //   icon: Icons.delete,
            //   onTap: () {
            //     setState(() {});
            //   },
            //   foregroundColor: Colors.white,
            // ),
//           ),
//         ],
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.all(12.0),
        //     child: IconSlideAction(
        //       caption: 'Update',
        //       color: Colors.green,
        //       icon: Icons.edit,
        //       foregroundColor: Colors.white,
        //       onTap: () {},
        //     ),
        //   ),
        // ],
//       ),
//     );
//   }
// }
