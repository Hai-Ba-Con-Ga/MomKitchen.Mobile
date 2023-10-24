import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../router/router.dart';

Future<String?> authorizationNavigator() async {
  var prefs = await SharedPreferences.getInstance();
  if (prefs.getString('accessToken') != null) {
    if (prefs.getString('roleName') == 'Customer') {
      return AppPath.home;
    } else {
      return AppPath.kitchenhome;
    }
  } else {
    return AppPath.login;
  }
}

Future<void> logout() async {
  var prefs = await SharedPreferences.getInstance();
  await prefs.remove('accessToken');
  Logger().i(prefs.getString('accessToken'));
  //logout firebase
  await FirebaseAuth.instance.signOut();
  await GoogleSignIn().signOut();
}

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}

Future<File?> pickImage(BuildContext context) async {
  File? image;
  try {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      image = File(pickedImage.path);
    }
  } catch (e) {
    showSnackBar(context, e.toString());
  }

  return image;
}
