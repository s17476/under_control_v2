import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../models/company_users_model.dart';
import '../../domain/entities/company_users.dart';
import '../models/company_model.dart';
import '../../domain/entities/company.dart';
import '../../domain/repositories/company_repository.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';

@LazySingleton(as: CompanyRepository)
class CompanyRepositoryImpl extends CompanyRepository {
  final FirebaseFirestore firebaseFirestore;

  CompanyRepositoryImpl({
    required this.firebaseFirestore,
  });

  @override
  Future<Either<Failure, Company>> getCompanyById(String companyId) async {
    try {
      final Company result;
      final DocumentSnapshot documentSnapshot;
      documentSnapshot =
          await firebaseFirestore.collection('companies').doc(companyId).get();
      result = CompanyModel.fromMap(
          documentSnapshot.data() as Map<String, dynamic>, documentSnapshot.id);
      return Right(result);
    } on FirebaseException catch (e) {
      return Left(DatabaseFailure(message: e.message ?? 'DataBase Failure'));
    } catch (e) {
      return const Left(
        UnsuspectedFailure(message: 'Unsuspected error'),
      );
    }
  }

  @override
  Future<Either<Failure, VoidResult>> updateCompany(Company company) async {
    try {
      final companyReference =
          firebaseFirestore.collection('companies').doc(company.id);
      final companyMap = (company as CompanyModel).toMap();
      await companyReference.update(companyMap);
      return Right(VoidResult());
    } on FirebaseException catch (e) {
      return Left(DatabaseFailure(message: e.message ?? 'DataBase Failure'));
    } catch (e) {
      return const Left(
        UnsuspectedFailure(message: 'Unsuspected error'),
      );
    }
  }

  @override
  Future<Either<Failure, CompanyUsers>> fetchAllCompanyUsers(
      String companyId) async {
    try {
      final Stream<QuerySnapshot> querySnapshot;
      querySnapshot = firebaseFirestore
          .collection('users')
          .where('companyId', isEqualTo: companyId)
          .where('approved', isEqualTo: true)
          .where('suspended', isEqualTo: false)
          .snapshots();

      return Right(CompanyUsersModel(allUsers: querySnapshot));
    } on FirebaseException catch (e) {
      return Left(DatabaseFailure(message: e.message ?? 'DataBase Failure'));
    } catch (e) {
      return const Left(
        UnsuspectedFailure(message: 'Unsuspected error'),
      );
    }
  }

  @override
  Future<Either<Failure, CompanyUsers>> fetchNewUsers(String companyId) async {
    try {
      final Stream<QuerySnapshot> querySnapshot;
      querySnapshot = firebaseFirestore
          .collection('users')
          .where('companyId', isEqualTo: companyId)
          .where('approved', isEqualTo: false)
          .where('rejected', isEqualTo: false)
          .snapshots();

      return Right(CompanyUsersModel(allUsers: querySnapshot));
    } on FirebaseException catch (e) {
      return Left(DatabaseFailure(message: e.message ?? 'DataBase Failure'));
    } catch (e) {
      return const Left(
        UnsuspectedFailure(message: 'Unsuspected error'),
      );
    }
  }

  @override
  Future<Either<Failure, CompanyUsers>> fetchSuspendedUsers(
      String companyId) async {
    try {
      final Stream<QuerySnapshot> querySnapshot;
      querySnapshot = firebaseFirestore
          .collection('users')
          .where('companyId', isEqualTo: companyId)
          .where('approved', isEqualTo: true)
          .where('suspended', isEqualTo: true)
          .snapshots();

      return Right(CompanyUsersModel(allUsers: querySnapshot));
    } on FirebaseException catch (e) {
      return Left(DatabaseFailure(message: e.message ?? 'DataBase Failure'));
    } catch (e) {
      return const Left(
        UnsuspectedFailure(message: 'Unsuspected error'),
      );
    }
  }
}
