// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// // Function to send a push notification to Petbook user devices
// void sendNotification(String title, String message, dynamic data) async {
//   // Initialize Firebase Messaging
//   FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

//   // Retrieve FCM tokens of Petbook user devices from Firestore
//   List<String> userTokens = await retrieveUserTokensFromFirestore();

//   // Prepare the notification payload
//   final notification = {
//     'notification': {
//       'title': title,
//       'body': message,
//     },
//     'data': data, // Include the details of the new entry in the 'data' field
//   };

//   // Send the notification to each user device
//   for (String token in userTokens) {
//     try {
//       await firebaseMessaging.send(
//         // Use the 'send' method to send the message to a specific device
//         RemoteMessage(
//           data: notification['data'],
//           notification: notification['notification'],
//           token: token,
//         ),
//       );
//     } catch (e) {
//       // Handle any errors that occur during sending the notification
//       print('Error sending notification to device with token: $token');
//       print(e);
//     }
//   }
// }

// // Function to retrieve FCM tokens of Petbook user devices from Firestore
// Future<List<String>> retrieveUserTokensFromFirestore() async {
//   QuerySnapshot snapshot = await FirebaseFirestore.instance
//       .collection('users')
//       .get(); // Assuming you have a collection named 'users' in Firestore containing user documents

//   List<String> tokens = [];
//   for (QueryDocumentSnapshot doc in snapshot.docs) {
//     if (doc.data().containsKey('fcmToken')) {
//       // Assuming the FCM token is stored as 'fcmToken' field in each user document
//       tokens.add(doc.data()['fcmToken']);
//     }
//   }

//   return tokens;
// }
