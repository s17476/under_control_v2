import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';

import '../error/failures.dart';

@lazySingleton
class InputValidator {
  Either<Failure, AuthParams> signinAndSignupValidator(
    String email,
    String password,
  ) {
    final emailValidationResult = emailValidator(email);
    if (emailValidationResult != null) {
      return Left(ValidationFailure(message: emailValidationResult));
    }
    print('emial OK');
    final passwordValidationResult = passwordValidator(password);
    if (passwordValidationResult != null) {
      return Left(ValidationFailure(message: passwordValidationResult));
    }
    return Right(AuthParams(email: email, password: password));
  }

  String? emailValidator(String email) {
    final result = RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
    if (result) {
      return null;
    } else {
      return 'Email format incorrect';
    }
  }

  String? passwordValidator(String password) {
    final result = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$',
    ).hasMatch(password);
    if (result) {
      return null;
    } else {
      return 'Password must be at least 8 characters long and contain at least one uppercase letter, one lowercase letter and one number';
    }
  }
}
