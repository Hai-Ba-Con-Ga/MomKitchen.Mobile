import 'package:flutter/material.dart';
import 'app.dart';
import 'dependencies.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  await _initApp();
  runApp(
    const MomKitchen(),
  );
}

Future<void> _initApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await AppDependencies.initialize();
}
