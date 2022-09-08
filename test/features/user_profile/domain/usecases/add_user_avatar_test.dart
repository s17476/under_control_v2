import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/user_profile/domain/repositories/user_files_repository.dart';
import 'package:under_control_v2/features/user_profile/domain/usecases/add_user_avatar.dart';

class MockUserFilesRepository extends Mock implements UserFilesRepository {}

void main() {
  late AddUserAvatar usecase;
  late MockUserFilesRepository repository;

  setUp(
    () {
      repository = MockUserFilesRepository();
      usecase = AddUserAvatar(repository: repository);
    },
  );

  setUpAll(() {
    registerFallbackValue(AvatarParams(id: 'userId', avatar: File('')));
  });

  File file = File('assets/undercontrol-adaptine.png');

  test(
    'UserPorfile should return [String] from repository when AddUserAvatar is called',
    () async {
      // arrange
      when(() => repository.addUserAvatar(any()))
          .thenAnswer((_) async => const Right(''));
      // act
      final result = await usecase(AvatarParams(id: 'userId', avatar: file));
      // assert
      expect(result, const Right<Failure, String>(''));
    },
  );
}
