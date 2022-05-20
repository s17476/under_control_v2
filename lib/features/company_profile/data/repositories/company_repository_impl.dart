import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../models/company_users_model.dart';
import '../../domain/entities/companies.dart';
import '../../domain/entities/company_user.dart';
import '../../domain/entities/company_users.dart';
import '../models/company_model.dart';
import '../../domain/entities/company.dart';
import '../../domain/repositories/company_repository.dart';
import '../../../core/error/failures.dart';
import '../../../core/network/network_info.dart';
import '../../../core/usecases/usecase.dart';
import '../models/company_user_model.dart';

@LazySingleton(as: CompanyRepositoryImpl)
class CompanyRepositoryImpl extends CompanyRepository {
  final FirebaseFirestore firebaseFirestore;
  final NetworkInfo networkInfo;

  CompanyRepositoryImpl({
    required this.firebaseFirestore,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, String>> addCompany(Company company) async {
    if (await networkInfo.isConnected) {
      try {
        final companiesReference = firebaseFirestore.collection('companies');
        final companyMap = (company as CompanyModel).toMap();
        final documentReferance = await companiesReference.add(companyMap);
        final String generatedCompanyId = documentReferance.id;
        return Right(generatedCompanyId);
      } on FirebaseException catch (e) {
        return Left(DatabaseFailure(message: e.message ?? 'DataBase Failure'));
      } catch (e) {
        return const Left(
          UnsuspectedFailure(message: 'Unsuspected error'),
        );
      }
    } else {
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Companies>> fetchAllCompanies() async {
    if (await networkInfo.isConnected) {
      try {
        final List<Company> result = [];
        final QuerySnapshot querySnapshot;
        querySnapshot = await firebaseFirestore
            .collection('companies')
            .orderBy('name')
            .get();
        for (var doc in querySnapshot.docs) {
          result.add(
              CompanyModel.fromMap(doc.data() as Map<String, dynamic>, doc.id));
        }
        return Right(Companies(data: result));
      } on FirebaseException catch (e) {
        return Left(DatabaseFailure(message: e.message ?? 'DataBase Failure'));
      } catch (e) {
        return const Left(
          UnsuspectedFailure(message: 'Unsuspected error'),
        );
      }
    } else {
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Company>> getCompanyById(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final Company result;
        final DocumentSnapshot documentSnapshot;
        documentSnapshot =
            await firebaseFirestore.collection('companies').doc(id).get();
        result = CompanyModel.fromMap(
            documentSnapshot.data() as Map<String, dynamic>,
            documentSnapshot.id);
        return Right(result);
      } on FirebaseException catch (e) {
        return Left(DatabaseFailure(message: e.message ?? 'DataBase Failure'));
      } catch (e) {
        return const Left(
          UnsuspectedFailure(message: 'Unsuspected error'),
        );
      }
    } else {
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, VoidResult>> updateCompany(Company company) async {
    if (await networkInfo.isConnected) {
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
    } else {
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, CompanyUsers>> fetchAllCompanyUsers(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final List<CompanyUser> result = [];
        final QuerySnapshot querySnapshot;
        querySnapshot = await firebaseFirestore
            .collection('users')
            .where('companyId', isEqualTo: id)
            .get();
        for (var doc in querySnapshot.docs) {
          result.add(
              CompanyUserModel.fromMap(doc.data() as Map<String, dynamic>));
        }
        return Right(CompanyUsersModel(allUsers: result));
      } on FirebaseException catch (e) {
        return Left(DatabaseFailure(message: e.message ?? 'DataBase Failure'));
      } catch (e) {
        return const Left(
          UnsuspectedFailure(message: 'Unsuspected error'),
        );
      }
    } else {
      return const Left(NetworkFailure());
    }
  }
}
