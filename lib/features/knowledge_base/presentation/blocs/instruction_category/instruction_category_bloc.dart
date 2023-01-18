import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import '../../../data/models/inventory_category/instructions_categories_list_model.dart';
import '../../../domain/entities/instruction_category/instruction_category.dart';
import '../../../domain/usecases/item_category/get_instructions_categories_stream.dart';

part 'instruction_category_event.dart';
part 'instruction_category_state.dart';

@singleton
class InstructionCategoryBloc
    extends Bloc<InstructionCategoryEvent, InstructionCategoryState> {
  final UserProfileBloc userProfileBloc;
  final GetInstructionsCategoriesStream getInstructionsCategoriesStream;

  late StreamSubscription _userProfileStreamSubscription;
  StreamSubscription? _instructionsCategoriesStreamSubscription;

  String _companyId = '';

  InstructionCategoryBloc({
    required this.userProfileBloc,
    required this.getInstructionsCategoriesStream,
  }) : super(InstructionCategoryEmptyState()) {
    _userProfileStreamSubscription = userProfileBloc.stream.listen((state) {
      if (_companyId.isEmpty && state is Approved) {
        _companyId = state.userProfile.companyId;
        add(GetAllInstructionsCategoriesEvent());
      }
    });

    on<GetAllInstructionsCategoriesEvent>((event, emit) async {
      emit(InstructionCategoryLoadingState());

      final failureOrInstructionCategoriesStream =
          await getInstructionsCategoriesStream(_companyId);
      await failureOrInstructionCategoriesStream.fold(
        (failure) async => emit(
          InstructionCategoryErrorState(message: failure.message),
        ),
        (categoriesStream) async {
          _instructionsCategoriesStreamSubscription =
              categoriesStream.allInstructionsCategories.listen((snapshot) {
            add(UpdateInstructionsCategoriesListEvent(snapshot: snapshot));
          });
        },
      );
    });

    on<UpdateInstructionsCategoriesListEvent>(
      (event, emit) async {
        emit(InstructionCategoryLoadingState());
        final instructionCategoryList =
            InstructionsCategoriesListModel.fromSnapshot(
          event.snapshot as QuerySnapshot<Map<String, dynamic>>,
        );
        print('InstructionCategoryBloc - Loaded');
        emit(
          InstructionCategoryLoadedState(
            allInstructionsCategories: instructionCategoryList,
          ),
        );
      },
    );
  }

  @override
  Future<void> close() {
    _userProfileStreamSubscription.cancel();
    _instructionsCategoriesStreamSubscription?.cancel();
    return super.close();
  }
}
