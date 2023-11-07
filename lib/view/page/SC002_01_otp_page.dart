import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/base_state.dart';
import '../../router/router.dart';
import '../../utils/utils.dart';
import '../widgets/button_orange.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;
  const OtpScreen({super.key, required this.verificationId});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String? otpCode;
  final AuthBloc _authBloc = AuthBloc();

  @override
  Widget build(BuildContext context) {
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
                          children: <Widget>[
                            Text(
                              'Xác Thực OTP',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                // color: Theme.of(context).colorScheme.primary,
                                color: Colors.white,
                                fontSize: 30,
                              ),
                            ),
                            Center(
                              child: Text(
                                'Chúng tôi đã gửi OTP\n đến số điện thoại của bạn',
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
                      Container(
                        width: 1000,
                        height: 1000,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24),
                              topRight: Radius.circular(24),
                            )),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 25, horizontal: 30),
                            child: Column(
                              children: [
                                const Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(
                                        0,
                                        10,
                                        50,
                                        10,
                                      ),
                                      child: Text(
                                        'OTP CODE',
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ],
                                ),
                                Pinput(
                                  length: 6,
                                  showCursor: true,
                                  defaultPinTheme: PinTheme(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Colors.purple.shade200,
                                      ),
                                    ),
                                    textStyle: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  onCompleted: (value) {
                                    setState(() {
                                      otpCode = value;
                                    });
                                  },
                                ),
                                const SizedBox(height: 25),
                                SizedBox(
                                  width: 350,
                                  child: Container(
                                    margin:
                                        const EdgeInsets.fromLTRB(20, 5, 20, 5),
                                    child: ButtonOrange(
                                      title: 'Xác thực',
                                      onPressed: () {
                                        if (otpCode != null) {
                                          verifyOtp(context, otpCode!);
                                        } else {
                                          showSnackBar(
                                              context, 'Enter 6-Digit code');
                                        }
                                      },
                                      icon: null,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  "Không nhận được mã OTP?",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black38,
                                  ),
                                ),
                                const SizedBox(height: 15),
                                const Text(
                                  'Gửi lại mã OTP',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.purple,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

  // verify otp
  Future<void> verifyOtp(BuildContext context, String userOtp) async {
    final prefs = await SharedPreferences.getInstance();
    var role = prefs.getString('role');

    await AuthBloc().verifyOtp(
        context: context,
        verificationId: widget.verificationId,
        userOtp: userOtp,
        onSuccess: (role, isFirstTime) {
          Logger().i('role: $role, isFirstTime: $isFirstTime');
          var wheretogo = role == 'Customer' ? AppPath.home : AppPath.kitchenhome;
          if (wheretogo == 'Customer') {
            context.go(
              wheretogo,
            );
          } else {
            if (isFirstTime == true) {
              context.go(
                AppPath.createKitchen,
              );
            } else {
              context.go(
                wheretogo,
              );
            }
          }
        },
        role: role ?? 'Customer');
  }
}
