import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'device_token_state.dart';

@singleton
class DeviceTokenCubit extends Cubit<DeviceTokenState> {
  DeviceTokenCubit() : super(DeviceTokenEmpty());
}
