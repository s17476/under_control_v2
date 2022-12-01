import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/input_validator.dart';
import '../../../../user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import '../../../data/models/company_model.dart';
import '../../../domain/entities/companies.dart';
import '../../../domain/entities/company.dart';
import '../../../domain/usecases/add_company.dart';
import '../../../domain/usecases/add_company_logo.dart';
import '../../../domain/usecases/fetch_all_companies.dart';
import '../../../domain/usecases/update_company.dart';

part 'company_management_event.dart';
part 'company_management_state.dart';

const String companyUpdated = 'companyUpdated';
const String companyLogoUpdated = 'companyLogoUpdated';

@injectable
class CompanyManagementBloc
    extends Bloc<CompanyManagementEvent, CompanyManagementState> {
  late StreamSubscription _userProfileStreamSubscription;
  final UserProfileBloc userProfileBloc;
  final InputValidator inputValidator;
  final AddCompany addCompany;
  final FetchAllCompanies fetchAllCompanies;
  final AddCompanyLogo addCompanyLogo;
  final UpdateCompany updateCompany;

  CompanyManagementBloc({
    required this.userProfileBloc,
    required this.inputValidator,
    required this.addCompany,
    required this.fetchAllCompanies,
    required this.addCompanyLogo,
    required this.updateCompany,
  }) : super(CompanyManagementEmpty()) {
    _userProfileStreamSubscription = userProfileBloc.stream.listen((state) {
      if (state is NoCompanyState) {
        add(FetchAllCompaniesEvent());
      }
    });

    on<FetchAllCompaniesEvent>((event, emit) async {
      emit(CompanyManagementLoading());
      final failureOrCompanies = await fetchAllCompanies(NoParams());
      failureOrCompanies.fold(
        (failure) =>
            emit(CompanyManagementError(message: failure.message, error: true)),
        (companies) =>
            emit(CompanyManagementCompaniesLoaded(companies: companies)),
      );
    });

    on<AddCompanyEvent>(
      (event, emit) async {
        emit(CompanyManagementLoading());
        final failureOrCompanyId = await addCompany(event.company);
        failureOrCompanyId.fold(
          (failure) {
            emit(
              CompanyManagementCompaniesLoaded(
                companies: event.companies,
                message: failure.message,
                error: true,
              ),
            );
          },
          (companyId) {
            final updatedCompany =
                (event.company as CompanyModel).copyWith(id: companyId);
            final updatedCompanies = event.companies.allCompanies;
            updatedCompanies.add(updatedCompany);
            emit(
              CompanyManagementCompaniesLoaded(
                companies: Companies(allCompanies: updatedCompanies),
                selectedCompany: updatedCompany,
              ),
            );
          },
        );
      },
    );

    on<AddCompanyLogoEvent>(
      (event, emit) async {
        emit(CompanyManagementLoading());
        // adds company logo
        final failureOrLogoUrl = await addCompanyLogo(
          AvatarParams(
            id: event.company.id,
            avatar: event.logo!,
          ),
        );
        await failureOrLogoUrl.fold(
          (failure) async => emit(
            CompanyManagementError(
              message: failure.message,
              error: true,
            ),
          ),
          (logoUrl) async {
            // updates company
            CompanyModel updatedCompany =
                (event.company as CompanyModel).copyWith(logo: logoUrl);
            final failureOrVoidResult = await updateCompany(updatedCompany);
            await failureOrVoidResult.fold(
              (failure) async => CompanyManagementError(
                message: failure.message,
                error: true,
              ),
              (_) async {
                emit(
                  const CompanyManagementLoaded(
                    message: companyLogoUpdated,
                  ),
                );
              },
            );
          },
        );
      },
    );
    on<UpdateCompanyDataEvent>(
      (event, emit) async {
        emit(CompanyManagementLoading());
        final failureOrVoidResult = await updateCompany(event.company);
        failureOrVoidResult.fold(
          (failure) async => emit(
            CompanyManagementError(message: failure.message),
          ),
          (_) async => emit(const CompanyManagementLoaded(
            message: companyUpdated,
          )),
        );
      },
    );
  }

  @override
  Future<void> close() {
    _userProfileStreamSubscription.cancel();
    return super.close();
  }
}
