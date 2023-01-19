import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../error/error_messages.dart';
import '../usecases/usecase.dart';
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
    final passwordValidationResult = passwordValidator(password);
    if (passwordValidationResult != null) {
      return Left(ValidationFailure(message: passwordValidationResult));
    }
    return Right(AuthParams(email: email, password: password));
  }

  Either<Failure, VoidResult> addUserValidator(
    String firstName,
    String lastName,
    String phoneNumber,
    File? avatar,
  ) {
    final firstNameValidationResult = textFieldValidator(firstName);
    final lastNameValidationResult = textFieldValidator(lastName);
    if (firstNameValidationResult != null) {
      return Left(ValidationFailure(message: firstNameValidationResult));
    }
    if (lastNameValidationResult != null) {
      return Left(ValidationFailure(message: lastNameValidationResult));
    }
    final phoneNumberValidationResult = phoneNumberFieldValidator(phoneNumber);
    if (phoneNumberValidationResult != null) {
      return Left(ValidationFailure(message: phoneNumberValidationResult));
    }
    if (avatar == null) {
      return const Left(ValidationFailure(message: fileIsNull));
    }
    return Right(VoidResult());
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

  String? textFieldValidator(String text) {
    if (text.trim().isEmpty || text.trim().length < 2) {
      return inputToShort;
    } else {
      return null;
    }
  }

  String? phoneNumberFieldValidator(String number) {
    final result = RegExp(r'^[0-9\-\+]{8,15}$').hasMatch(number);
    if (!result) {
      return phoneNumberFormatInvalid;
    } else {
      return null;
    }
  }
}
