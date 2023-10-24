import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/auth_api.dart';
import '../../data/user_api.dart';
import '../../router/router.dart';
import '../widgets/button_back.dart';
import '../widgets/button_orange.dart';

class UserEditScreen extends StatefulWidget {
  const UserEditScreen({super.key});

  @override
  State<UserEditScreen> createState() => _UserEditScreenState();
}

class _UserEditScreenState extends State<UserEditScreen> {
  final _userApi = UserApi();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

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
    final userData = await _userApi.getUserInfo();
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
    _usernameController.text = fullName;
    _emailController.text = email;
    _phoneController.text = phone;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: ButtonBack(onPressed: () => context.pop),
        leadingWidth: 70,
        toolbarHeight: 100,
        title: const Text('EditProfile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'HỌ VÀ TÊN',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      hintText: 'Nhập chữ vào đây',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'EMAIL',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      fillColor: Color(0xFFF0F5FA),
                      hintText: 'Nhập chữ vào đây',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'SỐ ĐIỆN THOẠI',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  TextField(
                    controller: _phoneController,
                    decoration: const InputDecoration(
                      fillColor: Color(0xFFF0F5FA),
                      hintText: 'Nhập chữ vào đây',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 350,
                child: ButtonOrange(
                  title: 'CHỈNH SỬA',
                  onPressed: onEditClick,
                  icon: null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onEditClick() async {
    await _userApi.editUserInfo(_usernameController.text, _emailController.text,
        _phoneController.text, avatarUrl, birthday);
    context.pop();
  }
}
