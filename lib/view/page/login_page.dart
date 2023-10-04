import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/base_state.dart';
import 'sign_up_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _showPassword = false;
  final AuthBloc _authBloc = AuthBloc();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocConsumer(
        bloc: _authBloc,
        listener: (context, state) {
          if (state is CommonState) {
            if (state.model == null) {
              if (context.canPop()) {
                context.pop();
              }
              if (state.isLoading) {
                showCupertinoDialog(
                  barrierDismissible: true,
                  context: context,
                  builder: (context) => const SizedBox(
                    // width: 400,
                    height: 50,
                    child: Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
                  ),
                );
                return;
              }

              if (state.errorMessage?.isNotEmpty ?? false) {
                showCupertinoDialog(
                  context: context,
                  builder: (context) => Platform.isIOS
                      ? CupertinoAlertDialog(
                          actions: [
                            TextButton(
                              onPressed: () => context.pop(),
                              child: const Text('OK'),
                            ),
                          ],
                          title: const Text('Error'),
                          content: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8.0,
                            ),
                            child: Text(state.errorMessage ?? ''),
                          ),
                        )
                      : AlertDialog(
                          actions: [
                            TextButton(
                              onPressed: () => context.pop(),
                              child: const Text('OK'),
                            ),
                          ],
                          title: const Text('Error'),
                          content: Text(state.errorMessage ?? ''),
                        ),
                );
                return;
              }
            }
          }
        },
        builder: (context, state) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => FocusScope.of(context).requestFocus(
              FocusNode(),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    /*logo*/
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 1.0,
                            color: Colors.lightBlueAccent,
                          ),
                        ),
                        child: const FlutterLogo(),
                      ),
                    ),
                    /*app name*/
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'MomKitchen',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.lightBlueAccent,
                          fontSize: 30,
                        ),
                      ),
                    ),
                    /*username input*/
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        50,
                        10,
                        50,
                        10,
                      ),
                      child: TextField(
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          labelText: 'Tên đăng nhập',
                          labelStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    /*password input*/
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        50,
                        10,
                        50,
                        10,
                      ),
                      child: Stack(
                        alignment: AlignmentDirectional.centerEnd,
                        children: <Widget>[
                          TextField(
                            obscureText: !_showPassword,
                            controller: _passwordController,
                            decoration: const InputDecoration(
                              labelText: 'Password',
                              labelStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: onToggleShowPassword,
                            child: Text(
                              !_showPassword ? 'Show' : 'Hide',
                              style: const TextStyle(
                                color: Colors.lightBlueAccent,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    /*sign in button*/
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        50,
                        10,
                        50,
                        10,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: onSignInClick,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightBlue,
                          ),
                          child: const Text(
                            'Sign In',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    /*other method login*/
                    GestureDetector(
                      onTap: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpPage(),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('New user? Sign Up'),
                          Text('Forgot password?'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text('Or'),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        50,
                        2,
                        50,
                        2,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightBlue,
                          ),
                          child: const Text(
                            'Google',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        50,
                        2,
                        50,
                        2,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightBlue,
                          ),
                          child: const Text(
                            'Facebook',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> onSignInClick() async {
    await _authBloc.login(
      email: _usernameController.text,
      password: _passwordController.text,
    );
  }

  void onToggleShowPassword() {
    setState(
      () {
        _showPassword = !_showPassword;
      },
    );
  }
}
