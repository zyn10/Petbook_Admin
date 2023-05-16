// import 'package:firebase_messaging/firebase_messaging.dart';

// final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

// void sendNotificationToAllUsers(String title, String body) {
//   _firebaseMessaging.getToken().then((token) {
//     final message = {
//       'notification': {
//         'title': title,
//         'body': body,
//       },
//       'topic': 'all_users',
//       'data': {
//         'click_action': 'FLUTTER_NOTIFICATION_CLICK',
//         'screen': 'alert_details',
//       },
//     };

//     _firebaseMessaging.send(message).then((value) {
//       print('Notification sent successfully!');
//     }).catchError((error) {
//       print('Failed to send notification: $error');
//     });
//   });
// }
