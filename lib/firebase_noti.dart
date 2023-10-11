import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseNotification {
  //create an instance of Firebase Messaging
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> handleBackgroundMessage(RemoteMessage message) async {
    print('Title: ${message.notification?.title}');
    print('Body: ${message.notification?.body}');
    print('Payload: ${message.data}');
  }

  //function to initialize notifications
  Future<void> initNotifications() async {
    //request permission form user (will prompt user)
    await _firebaseMessaging.requestPermission();
    //fetch the FCM token for this device
    final fcmToken = await _firebaseMessaging.getToken();
    //print the token (normally will send this to server)
    print("FcmToken: $fcmToken");
    // FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }
}
