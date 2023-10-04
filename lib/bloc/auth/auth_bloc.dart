import 'package:firebase_auth/firebase_auth.dart';

import '../bloc.dart';

class AuthBloc extends BaseCubit {
  AuthBloc() : super(InitialState());

  void init() {}

  String getValidateSignUpInfoMessage({
    required String email,
    required String password,
    required String confirmPassword,
  }) {
    var errorMessage = '';

    if (password != confirmPassword) {
      errorMessage = 'Password and Confirm Password are not matched';
    }

    if (!RegExp(
            'r /^(([^<>()[]\\.,;:s@"]+(.[^<>()[]\\.,;:s@"]+)*)|.(".+"))@(([[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}])|(([a-zA-Z-0-9]+.)+[a-zA-Z]{2,}))')
        .hasMatch(email)) {
      errorMessage = 'Invalid Email';
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
      final isCredentialValid = getValidateSignUpInfoMessage(
        email: email,
        password: password,
        confirmPassword: confirmPassword,
      ).isEmpty;
      if (isCredentialValid) {
        final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
      }
      emit(
        CommonState(
          null,
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
}
