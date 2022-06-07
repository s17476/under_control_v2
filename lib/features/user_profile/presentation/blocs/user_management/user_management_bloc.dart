import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_management_event.dart';
part 'user_management_state.dart';

class UserManagementBloc extends Bloc<UserManagementEvent, UserManagementState> {
  UserManagementBloc() : super(UserManagementInitial()) {
    on<UserManagementEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
