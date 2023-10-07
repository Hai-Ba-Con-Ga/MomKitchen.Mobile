import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/bloc.dart';
import '../../router/router.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _showPassword = false;
  bool _showRePassword = false;
  final AuthBloc _signUpBloc = AuthBloc();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: _signUpBloc,
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
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: GestureDetector(
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
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
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
                        children: [
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
                        children: [
                          TextField(
                            obscureText: !_showRePassword,
                            controller: _confirmPasswordController,
                            decoration: const InputDecoration(
                              labelText: 'Confirm Password',
                              labelStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: onToggleShowRePassword,
                            child: Text(
                              !_showRePassword ? 'Show' : 'Hide',
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
                          onPressed: onSignUpClick,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightBlue,
                          ),
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    /*other method login*/
                    GestureDetector(
                      onTap: () => context.go(AppPath.login),
                      child: const Center(
                        child: Text('Already have an account? Login'),
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
          ),
        );
      },
    );
  }

  void onSignUpClick() {
    _signUpBloc.signUp(
      email: _emailController.text,
      password: _passwordController.text,
      confirmPassword: _confirmPasswordController.text,
    );
  }

  void onToggleShowPassword() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  void onToggleShowRePassword() {
    setState(() {
      _showRePassword = !_showRePassword;
    });
  }
}
