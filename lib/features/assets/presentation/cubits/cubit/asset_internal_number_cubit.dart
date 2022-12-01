import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../domain/usecases/check_code_availability.dart';

part 'asset_internal_number_state.dart';

@injectable
class AssetInternalNumberCubit extends Cubit<AssetInternalNumberState> {
  final CheckCodeAvailability checkCodeAvailability;
  AssetInternalNumberCubit(this.checkCodeAvailability)
      : super(AssetInternalNumberEmptyState());

  void checkAssetCodeAvailability({
    required String code,
    required String companyId,
  }) async {
    emit(AssetInternalNumberLoadingState());
    final codeParams = CodeParams(
      internalCode: code,
      companyId: companyId,
    );
    final failureOrBool = await checkCodeAvailability(codeParams);
    failureOrBool.fold(
      (failure) async => emit(AssetInternalNumberErrorState()),
      (result) async => emit(
        AssetInternalNumberLoadedState(
          isCodeAvailable: result,
        ),
      ),
    );
  }
}
