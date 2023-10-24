import 'package:flutter/material.dart';
import 'app.dart';
import 'dependencies.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_noti.dart';
import 'firebase_options.dart';
import 'utils/utils.dart';

void main() async {
  await _initApp();
  var route = await authorizationNavigator();
  runApp(
    MomKitchen(firstRoute: route),
  );
}

Future<void> _initApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await AppDependencies.initialize();
  await FirebaseNotification().initNotifications();
}
