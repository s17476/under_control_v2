import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:under_control_v2/features/company_profile/data/models/company_users_list_model.dart';
import 'package:under_control_v2/features/company_profile/domain/entities/company.dart';
import 'package:under_control_v2/features/company_profile/domain/entities/company_users_list.dart';
import 'package:under_control_v2/features/company_profile/domain/usecases/fetch_all_company_users.dart';
import 'package:under_control_v2/features/company_profile/domain/usecases/get_company_by_id.dart';
import 'package:under_control_v2/features/company_profile/domain/usecases/update_company.dart';
import 'package:under_control_v2/features/core/utils/input_validator.dart';
import 'package:under_control_v2/features/user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';

part 'company_profile_event.dart';
part 'company_profile_state.dart';

@injectable
class CompanyProfileBloc
    extends Bloc<CompanyProfileEvent, CompanyProfileState> {
  late StreamSubscription authenticationStreamSubscription;
  late StreamSubscription companyUsersStreamSubscription;
  late StreamSubscription streamSubscription;
  final UserProfileBloc userProfileBloc;
  final UpdateCompany updateCompany;
  final FetchAllCompanyUsers fetchAllCompanyUsers;
  final GetCompanyById getCompanyById;
  final InputValidator inputValidator;

  CompanyProfileBloc({
    required this.userProfileBloc,
    required this.updateCompany,
    required this.fetchAllCompanyUsers,
    required this.getCompanyById,
    required this.inputValidator,
  }) : super(CompanyProfileEmpty()) {
    authenticationStreamSubscription = userProfileBloc.stream.listen(
      (state) {
        if (state is Approved) {
          add(GetCompanyByIdEvent(id: state.userProfile.companyId));
        }
      },
    );
    on<GetCompanyByIdEvent>((event, emit) async {
      emit(CompanyProfileLoading());
      final failureOrCompany = await getCompanyById(event.id);
      await failureOrCompany.fold(
        (failure) async => emit(
          CompanyProfileError(msg: failure.message, err: true),
        ),
        (company) async {
          final failureOrCompanyUsers = await fetchAllCompanyUsers(company.id);
          await failureOrCompanyUsers.fold(
            (failure) async => emit(
              CompanyProfileError(msg: failure.message, err: true),
            ),
            (companyUsers) async {
              print('xxxxxxxxxxxxxxxxxxxxx company ok');
              companyUsersStreamSubscription =
                  companyUsers.allUsers.listen((snapshot) {
                final usersList = CompanyUsersListModel.fromSnapshot(snapshot);
                print('xxxxxxxxxxxxxxxxxxxxx company users ok');
                emit(CompanyProfileLoaded(
                    companyUsers: usersList, company: company));
              });
            },
          );
        },
      );
    });
  }

  @override
  Future<void> close() {
    authenticationStreamSubscription.cancel();
    companyUsersStreamSubscription.cancel();
    return super.close();
  }
}
