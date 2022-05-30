import 'dart:async';
import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:under_control_v2/features/company_profile/data/models/company_model.dart';
import 'package:under_control_v2/features/company_profile/domain/entities/company.dart';
import 'package:under_control_v2/features/company_profile/domain/usecases/add_company.dart';
import 'package:under_control_v2/features/company_profile/domain/usecases/add_company_logo.dart';
import 'package:under_control_v2/features/company_profile/domain/usecases/fetch_all_companies.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/core/utils/input_validator.dart';
import 'package:under_control_v2/features/user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';

import '../../../domain/entities/companies.dart';

part 'company_management_event.dart';
part 'company_management_state.dart';

@injectable
class CompanyManagementBloc
    extends Bloc<CompanyManagementEvent, CompanyManagementState> {
  late StreamSubscription userProfileStreamSubscription;
  final UserProfileBloc userProfileBloc;
  final InputValidator inputValidator;
  final AddCompany addCompany;
  final FetchAllCompanies fetchAllCompanies;
  final AddCompanyLogo addCompanyLogo;

  CompanyManagementBloc({
    required this.userProfileBloc,
    required this.inputValidator,
    required this.addCompany,
    required this.fetchAllCompanies,
    required this.addCompanyLogo,
  }) : super(CompanyManagementEmpty()) {
    userProfileStreamSubscription = userProfileBloc.stream.listen((state) {
      if (state is NoCompany) {
        add(FetchAllCompaniesEvent());
      }
    });
    on<FetchAllCompaniesEvent>((event, emit) async {
      emit(CompanyManagementLoading());
      final failureOrCompanies = await fetchAllCompanies(NoParams());
      failureOrCompanies.fold(
        (failure) =>
            emit(CompanyManagementError(msg: failure.message, err: true)),
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
                msg: failure.message,
                err: true,
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
        print('AddLogo');
        emit(CompanyManagementLoading());
        final failureOrLogoUrl = await addCompanyLogo(
          AvatarParams(
            userId: event.company.id,
            avatar: event.logo!,
          ),
        );
        failureOrLogoUrl.fold(
          (failure) async => emit(
            CompanyManagementCompaniesLoaded(
              companies: event.companies,
              selectedCompany: event.company,
              msg: failure.message,
              err: true,
            ),
          ),
          (logoUrl) async {
            final updatedCompany =
                (event.company as CompanyModel).copyWith(name: logoUrl);
            emit(
              CompanyManagementCompaniesLoaded(
                companies: event.companies,
                selectedCompany: updatedCompany,
              ),
            );
          },
        );
      },
    );
  }

  @override
  Future<void> close() {
    userProfileStreamSubscription.cancel();
    return super.close();
  }
}
