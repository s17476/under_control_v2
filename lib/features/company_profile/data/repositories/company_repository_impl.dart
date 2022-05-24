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
  Future<Either<Failure, Company>> getCompanyById(String id) async {
    try {
      final Company result;
      final DocumentSnapshot documentSnapshot;
      documentSnapshot =
          await firebaseFirestore.collection('companies').doc(id).get();
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
      await companyReference.set(companyMap);
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
  Future<Either<Failure, CompanyUsers>> fetchAllCompanyUsers(String id) async {
    try {
      final Stream<QuerySnapshot> querySnapshot;
      querySnapshot = firebaseFirestore
          .collection('users')
          .where('companyId', isEqualTo: id)
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
