import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../../data/user_api.dart';
import '../../router/router.dart';
import '../../utils/utils.dart';
import '../widgets/button_back.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  String id = '';
  String email = '';
  String fullName = '';
  String avatarUrl = '';
  String phone = '';
  dynamic birthday = '';
  String roleName = '';

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // var userData = prefs.getString('userInfo');
    // final u = jsonDecode(userData!);
    // setState(() {
    //   email = u['email'] ?? '';
    //   fullName = u['fullName'] ?? '';
    //   phone = u['phone'] ?? '';
    // });

    final userData = await UserApi().getUserInfo();
    setState(() {
      fullName = userData!.fullName;
      email = userData.email;
      phone = userData.phone;
      avatarUrl = userData.avatarUrl;
      birthday = userData.birthday;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: ButtonBack(onPressed: () => context.pop),
        leadingWidth: 70,
        toolbarHeight: 100,
        title: const Text('Hồ sơ của bạn'),
        actions: [
          GestureDetector(
            onTap: () => {context.push(AppPath.userEdit)},
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.create_sharp),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                    getStorageUrl(avatarUrl == ''
                        ? 'https://picsum.photos/250?image=9'
                        : avatarUrl),
                    height: 150,
                    // width: 500,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F5FA),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      userItem(
                          const Icon(
                            Icons.account_circle,
                            size: 30,
                          ),
                          'HỌ VÀ TÊN',
                          fullName),
                      userItem(
                          const Icon(
                            Icons.markunread_outlined,
                            size: 30,
                          ),
                          'EMAIL',
                          email),
                      userItem(
                          const Icon(
                            Icons.local_phone,
                            size: 30,
                          ),
                          'SỐ ĐIỆN THOẠI',
                          phone),

                      // Text('Họ Tên: $fullName'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: TextButton(
              onPressed: () async => {
                await logOut(),
                context.go(
                  AppPath.signUpPhone,
                )
              },
              child: const Text('Log Out'),
            ),
          ),
        ],
      ),
    );
  }

  Padding userItem(Icon icon, String title, String content) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: 20, right: 10),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              // color: Colors.black,
            ),
            child: icon,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    content,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> logOut() async {
    await AuthBloc().signOutWithGoogle();
    await utilLogout();
  }
}
