import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/auth_api.dart';
import '../../repository/auth_repository.dart';
import '../../utils/utils.dart';
import '../../view/page/SC002_01_otp_page.dart';
import '../bloc.dart';

class AuthBloc extends BaseCubit {
  AuthBloc() : super(InitialState());
  FirebaseAuth auth = FirebaseAuth.instance;

  void init() {}

  String getValidateConfirmPassword({
    required String email,
    required String password,
    required String confirmPassword,
  }) {
    var errorMessage = '';

    if (password.isEmpty) {
      errorMessage = 'Must input password';
    }

    if (password != confirmPassword) {
      errorMessage = 'Password and Confirm Password are not matched';
    }

    return errorMessage;
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      emit(
        CommonState(
          null,
          isLoading: true,
        ),
      );
      final validateMessage = getValidateConfirmPassword(
        email: email,
        password: password,
        confirmPassword: confirmPassword,
      );
      if (validateMessage.isEmpty) {
        final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        emit(
          CommonState(
            userCredential,
            isLoading: false,
          ),
        );
      }
      emit(
        CommonState(
          null,
          errorMessage: validateMessage,
        ),
      );
    } catch (e) {
      var exceptionMessage = 'Unknown Error';

      if (e is FirebaseAuthException) {
        exceptionMessage = e.code;
      }

      emit(
        CommonState(
          null,
          errorMessage: exceptionMessage,
        ),
      );
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      emit(
        CommonState(
          null,
          isLoading: true,
        ),
      );
      final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(
        CommonState(
          userCredential,
          isLoading: false,
        ),
      );
    } catch (e) {
      var exceptionMessage = 'Unknown Error';

      if (e is FirebaseAuthException) {
        exceptionMessage = e.code;
      }

      emit(
        CommonState(
          null,
          errorMessage: exceptionMessage,
        ),
      );
    }
  }

  Future<void> loginWithGoogle() async {
    try {
      emit(
        CommonState(
          null,
          isLoading: true,
        ),
      );
      FirebaseAuth auth = FirebaseAuth.instance;
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      final AuthCredential authCredential = GoogleAuthProvider.credential(accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      final credential = await auth.signInWithCredential(authCredential);

      emit(
        CommonState(
          credential,
          isLoading: false,
        ),
      );
    } catch (e) {
      var exceptionMessage = 'Unknown Error';

      if (e is FirebaseAuthException) {
        exceptionMessage = e.code;
      }

      emit(
        CommonState(
          null,
          errorMessage: exceptionMessage,
        ),
      );
    }
  }

  Future<void> loginWithPhone({required BuildContext context, required String phoneNumber}) async {
    try {
      emit(
        CommonState(
          null,
          isLoading: true,
        ),
      );

      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            Logger().w('The provided phone number is not valid.');
          }
        },
        codeSent: (verificationId, forceResendingToken) async {
          Logger().i('Phone number verification code sent.');
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OtpScreen(verificationId: verificationId),
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      var exceptionMessage = 'Unknown Error';

      if (e is FirebaseAuthException) {
        exceptionMessage = e.code;
      }
    }
  }

  Future<void> verifyOtp({
    required BuildContext context,
    required String verificationId,
    required String userOtp,
    required Function onSuccess,
  }) async {
    emit(
      CommonState(
        null,
        isLoading: true,
      ),
    );
    try {
      dynamic responseLogin;
      PhoneAuthCredential creds = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: userOtp);
      var user = (await auth.signInWithCredential(creds)).user;
      if (user != null) {
        String? idToken = await auth.currentUser?.getIdToken();
        final prefs = await SharedPreferences.getInstance();
        String? fcmtoken = prefs.getString('fcmToken');

        final authRepository = AuthRepository(authApi: AuthApi());
        responseLogin = await authRepository.loginUser(idToken!, fcmtoken!, 'Customer');

        await prefs.setString('accessToken', responseLogin.token);
        Logger().i('accessToken of backend into sharedPreference.');
        onSuccess();
      }
      emit(
        CommonState(
          responseLogin,
          isLoading: false,
        ),
      );
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
    }
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print('Lỗi đăng xuất: $e');
    }
  }

  Future<void> signOutWithGoogle() async {
    try {
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn().signOut();
    } catch (e) {
      print('Lỗi đăng xuất Google: $e');
    }
  }
}
