import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/utils/input_validator.dart';
import '../../../../user_profile/domain/entities/user_profile.dart';
import '../../../../user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import '../../../data/models/company_users_list_model.dart';
import '../../../domain/entities/company.dart';
import '../../../domain/entities/company_users_list.dart';
import '../../../domain/usecases/fetch_all_company_users.dart';
import '../../../domain/usecases/get_company_by_id.dart';

part 'company_profile_event.dart';
part 'company_profile_state.dart';

@singleton
class CompanyProfileBloc
    extends Bloc<CompanyProfileEvent, CompanyProfileState> {
  late StreamSubscription _userProfileStreamSubscription;
  StreamSubscription? _companyUsersStreamSubscription;
  final UserProfileBloc userProfileBloc;
  final FetchAllCompanyUsers fetchAllCompanyUsers;
  final GetCompanyById getCompanyById;
  final InputValidator inputValidator;

  CompanyProfileBloc({
    required this.userProfileBloc,
    required this.fetchAllCompanyUsers,
    required this.getCompanyById,
    required this.inputValidator,
  }) : super(CompanyProfileEmpty()) {
    _userProfileStreamSubscription = userProfileBloc.stream.listen(
      (state) {
        if (state is Approved) {
          add(GetCompanyByIdEvent(id: state.userProfile.companyId));
        } else if (state is NotApproved) {
          add(GetCompanyByIdEvent(id: state.userProfile.companyId));
        }
      },
    );

    on<GetCompanyByIdEvent>((event, emit) async {
      emit(CompanyProfileLoading());
      final failureOrCompany = await getCompanyById(event.id);
      await failureOrCompany.fold(
        (failure) async => emit(
          CompanyProfileError(message: failure.message, error: true),
        ),
        (company) async {
          final failureOrCompanyUsers = await fetchAllCompanyUsers(company.id);
          await failureOrCompanyUsers.fold(
            (failure) async => emit(
              CompanyProfileError(message: failure.message, error: true),
            ),
            (companyUsers) async {
              _companyUsersStreamSubscription = companyUsers.allUsers.listen(
                (snapshot) {
                  add(
                    UpdateCompanyUsersEvent(
                      company: company,
                      snapshot: snapshot,
                    ),
                  );
                },
              );
              // emit(
              //   CompanyProfileLoaded(
              //     companyUsers: const CompanyUsersList(allUsers: []),
              //     company: company,
              //   ),
              // );
            },
          );
        },
      );
    });

    on<UpdateCompanyUsersEvent>((UpdateCompanyUsersEvent event, emit) async {
      CompanyUsersList usersList = CompanyUsersListModel.fromSnapshot(
          event.snapshot as QuerySnapshot<Map<String, dynamic>>);
      print('CompanyProfileBloc - Loaded');
      emit(
        CompanyProfileLoaded(
          companyUsers: usersList,
          company: event.company,
        ),
      );
    });
  }

  @override
  Future<void> close() {
    _userProfileStreamSubscription.cancel();
    _companyUsersStreamSubscription?.cancel();
    return super.close();
  }
}
