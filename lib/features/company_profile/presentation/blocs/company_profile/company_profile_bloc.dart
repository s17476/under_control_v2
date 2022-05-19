import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:under_control_v2/features/authentication/presentation/blocs/authentication/authentication_bloc.dart';
import 'package:under_control_v2/features/company_profile/data/models/company_model.dart';
import 'package:under_control_v2/features/company_profile/domain/entities/company.dart';
import 'package:under_control_v2/features/company_profile/domain/usecases/add_company.dart';
import 'package:under_control_v2/features/company_profile/domain/usecases/fetch_all_companies.dart';
import 'package:under_control_v2/features/company_profile/domain/usecases/get_company_by_id.dart';
import 'package:under_control_v2/features/company_profile/domain/usecases/update_company.dart';

import '../../../domain/entities/company_users.dart';

part 'company_profile_event.dart';
part 'company_profile_state.dart';

class CompanyProfileBloc
    extends Bloc<CompanyProfileEvent, CompanyProfileState> {
  late StreamSubscription streamSubscription;
  final AuthenticationBloc authenticationBloc;
  final AddCompany addCompany;
  final UpdateCompany updateCompany;
  final FetchAllCompanies fetchAllCompanies;
  final GetCompanyById getCompanyById;

  CompanyProfileBloc({
    required this.authenticationBloc,
    required this.addCompany,
    required this.updateCompany,
    required this.fetchAllCompanies,
    required this.getCompanyById,
  }) : super(Empty()) {
    streamSubscription = authenticationBloc.stream.listen(
      (state) {},
    );

    on<CompanyProfileEvent>((event, emit) {
      // TODO: implement event handler
    });
  }

  @override
  Future<void> close() {
    streamSubscription.cancel();
    return super.close();
  }
}
