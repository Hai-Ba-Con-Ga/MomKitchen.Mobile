import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/base_state.dart';
import '../../router/router.dart';
import '../widgets/button_orange.dart';

class SignInPhonePage extends StatefulWidget {
  const SignInPhonePage({super.key});

  @override
  State<SignInPhonePage> createState() => _SignInPhonePageState();
}

class _SignInPhonePageState extends State<SignInPhonePage> {
  final TextEditingController phoneController = TextEditingController();

  Country selectedCountry = Country(
    phoneCode: '84',
    countryCode: 'VN',
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: 'Vietnam',
    example: 'Vietnam',
    displayName: 'Vietnam',
    displayNameNoCountryCode: 'VN',
    e164Key: '',
  );

  final AuthBloc _authBloc = AuthBloc();

  @override
  Widget build(BuildContext context) {
    phoneController.text = '0938971690';
    phoneController.selection = TextSelection.fromPosition(
      TextPosition(
        offset: phoneController.text.length,
      ),
    );
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
                        Container(
                          width: 1000,
                          height: 1000,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(24),
                                topRight: Radius.circular(24),
                              )),
                          child: Column(
                            children: [
                              const Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                      50,
                                      30,
                                      50,
                                      0,
                                    ),
                                    child: Text(
                                      'PHONE NUMBER',
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                  50,
                                  10,
                                  50,
                                  0,
                                ),
                                child: TextFormField(
                                  cursorColor: Colors.purple,
                                  controller: phoneController,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      phoneController.text = value;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Enter phone number',
                                    hintStyle: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                      color: Colors.grey.shade600,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Colors.black12),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Colors.black12),
                                    ),
                                    prefixIcon: Container(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () {
                                          showCountryPicker(
                                              context: context,
                                              countryListTheme:
                                                  const CountryListThemeData(
                                                bottomSheetHeight: 550,
                                              ),
                                              onSelect: (value) {
                                                setState(() {
                                                  selectedCountry = value;
                                                });
                                              });
                                        },
                                        child: Text(
                                          '${selectedCountry.flagEmoji} + ${selectedCountry.phoneCode}',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    suffixIcon: phoneController.text.length > 9
                                        ? Container(
                                            height: 30,
                                            width: 30,
                                            margin: const EdgeInsets.all(10.0),
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.green,
                                            ),
                                            child: const Icon(
                                              Icons.done,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                          )
                                        : null,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    GestureDetector(
                                      onTap: () => context.go(
                                        AppPath.signUp,
                                      ),
                                      child:
                                          const Text('Do not have an account?'),
                                    ),
                                    GestureDetector(
                                      onTap: () => context.go(
                                        AppPath.signUp,
                                      ),
                                      child: const Text(
                                        'Sign up',
                                        style: TextStyle(color: Colors.orange),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 350,
                                child: ButtonOrange(
                                  title: 'Sign in',
                                  onPressed: () => sendPhoneNumber(),
                                  icon: null,
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
                                      child: Image.asset(
                                          'assets/images/google.png')),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                      onTap: () {},
                                      child:
                                          Image.asset('assets/images/fb.png')),
                                ],
                              ),
                              const SizedBox(height: 60),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ));
  }

  void sendPhoneNumber() {
    String phoneNumber = phoneController.text.trim();
    AuthBloc().loginWithPhone(
        context: context,
        phoneNumber: "+${selectedCountry.phoneCode}$phoneNumber");
  }
}
