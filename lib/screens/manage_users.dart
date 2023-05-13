// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class ManageUsersScreen extends StatefulWidget {
//   @override
//   _ManageUsersScreenState createState() => _ManageUsersScreenState();
// }

// class _ManageUsersScreenState extends State<ManageUsersScreen> {
//   final FirebaseFirestore firestore = FirebaseFirestore.instance;
//   CollectionReference usersRef = FirebaseFirestore.instance.collection('users');

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Manage Users'),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: usersRef.snapshots(),
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           }

//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }

//           return ListView.builder(
//             itemCount: snapshot.data.docs.length,
//             itemBuilder: (BuildContext context, int index) {
//               DocumentSnapshot document = snapshot.data.docs[index];
//               return ListTile(
//                 title: Text(document['name']),
//                 subtitle: Text(document['email']),
//                 trailing: IconButton(
//                   icon: Icon(Icons.delete),
//                   onPressed: () async {
//                     await usersRef.doc(document.id).delete();
//                   },
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
