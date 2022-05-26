import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/companies.dart';
import '../../domain/entities/company.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../domain/repositories/company_management_repository.dart';
import '../models/company_model.dart';

@LazySingleton(as: CompanyManagementRepository)
class CompanyManagementRepositoryImpl extends CompanyManagementRepository {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;

  CompanyManagementRepositoryImpl({
    required this.firebaseFirestore,
    required this.firebaseStorage,
  });
  @override
  Future<Either<Failure, String>> addCompany(Company company) async {
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
  }

  @override
  Future<Either<Failure, String>> addCompanyLogo(AvatarParams params) async {
    try {
      final logoReferance = firebaseStorage
          .ref()
          .child('companies')
          .child('logo')
          .child('${params.userId}.jpg');
      await logoReferance.putFile(params.avatar);

      final logoUrl = await logoReferance.getDownloadURL();
      return Right(logoUrl);
    } on FirebaseException catch (e) {
      return Left(DatabaseFailure(message: e.message ?? 'DataBase Failure'));
    } catch (e) {
      return Left(
        UnsuspectedFailure(message: e.toString()),
      );
    }
  }

  @override
  Future<Either<Failure, Companies>> fetchAllCompanies() async {
    try {
      final List<Company> result = [];
      final QuerySnapshot querySnapshot;
      querySnapshot =
          await firebaseFirestore.collection('companies').orderBy('name').get();
      for (var doc in querySnapshot.docs) {
        result.add(
            CompanyModel.fromMap(doc.data() as Map<String, dynamic>, doc.id));
      }
      return Right(Companies(allCompanies: result));
    } on FirebaseException catch (e) {
      return Left(DatabaseFailure(message: e.message ?? 'DataBase Failure'));
    } catch (e) {
      return const Left(
        UnsuspectedFailure(message: 'Unsuspected error'),
      );
    }
  }
}
