import 'package:firebase_auth/firebase_auth.dart';

import '../bloc.dart';

class AuthBloc extends BaseCubit {
  AuthBloc() : super(InitialState());

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
}
