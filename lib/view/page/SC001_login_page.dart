import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/base_state.dart';
import '../../router/router.dart';
import '../widgets/button_orange.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _showPassword = false;
  final AuthBloc _authBloc = AuthBloc();
  // final TextEditingController _usernameController = TextEditingController(text: 'email123@gmail.com');
  // final TextEditingController _passwordController = TextEditingController(text: '123456');
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _usernameController.text = 'test123@gmail.com';
    _passwordController.text = 'test123';
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: BlocConsumer(
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
              context.go(
                AppPath.home,
              );
            }
          },
          builder: (
            context,
            state,
          ) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => FocusScope.of(context).requestFocus(
                FocusNode(),
              ),
              child: Container(
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(30, 30, 46, 1),
                ),
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.all(50.0),
                      child: Column(
                        children: [
                          Text(
                            'Login',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              // color: Theme.of(context).colorScheme.primary,
                              color: Colors.white,
                              fontSize: 30,
                            ),
                          ),
                          Center(
                            child: Text(
                              'Please sign in to \nyour existing account',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                // color: Theme.of(context).colorScheme.primary,
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    /*username input*/
                    Container(
                      width: 1000,
                      height: 500,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24),
                          )),
                      child: Column(
                        children: [
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
                                labelText: 'EMAIL',
                                hintText: 'Enter your Email',
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                // border: InputBorder.none,
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.orange, width: 0.5),
                                ),
                                enabledBorder: InputBorder.none,
                                fillColor: Colors.orange,
                                labelStyle: TextStyle(
                                  fontSize: 20,
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
                                    border: InputBorder.none,
                                    labelText: 'PASSWORD',
                                    hintText: 'Enter your password',
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    labelStyle: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: onToggleShowPassword,
                                  child: Icon(
                                    !_showPassword
                                        ? Icons.remove_red_eye
                                        : Icons.remove_red_eye_outlined,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          /*sign in button*/
                          /*other method login*/
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () => context.go(
                                  AppPath.signUp,
                                ),
                                child: const Text('Remeber me'),
                              ),
                              GestureDetector(
                                onTap: () => context.go(
                                  AppPath.signUp,
                                ),
                                child: const Text(
                                  'Forgot password?',
                                  style: TextStyle(color: Colors.orange),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 350,
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                              child: ButtonOrange(
                                title: 'Sign in',
                                onPressed: onSignInClick,
                                icon: null,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: () => context.go(
                              AppPath.signUpPhone,
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Don\'t have Account?',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 16),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'Sign up',
                                  style: TextStyle(
                                      color: Colors.orange, fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text('Or'),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                  onTap: () {},
                                  child:
                                      Image.asset('assets/images/google.png')),
                              const SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                  onTap: () {},
                                  child: Image.asset('assets/images/fb.png')),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
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
