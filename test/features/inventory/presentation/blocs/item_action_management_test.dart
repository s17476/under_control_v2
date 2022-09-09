import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/company_profile/presentation/blocs/company_profile/company_profile_bloc.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/inventory/domain/entities/item.dart';
import 'package:under_control_v2/features/inventory/domain/entities/item_action/item_action.dart';
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/add_item_action.dart';
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/delete_item_action.dart';
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/update_item_action.dart';
import 'package:under_control_v2/features/inventory/presentation/blocs/item_action_management/item_action_management_bloc.dart';

class MockCompanyProfileBloc extends Mock
    implements Stream<CompanyProfileState>, CompanyProfileBloc {}

class MockAddItemAction extends Mock implements AddItemAction {}

class MockUpdateItemAction extends Mock implements UpdateItemAction {}

class MockDeleteItemAction extends Mock implements DeleteItemAction {}

void main() {
  late MockCompanyProfileBloc mockCompanyProfileBloc;

  late MockAddItemAction mockAddItemAction;
  late MockUpdateItemAction mockUpdateItemAction;
  late MockDeleteItemAction mockDeleteItemAction;

  late ItemActionManagementBloc itemActionManagementBloc;

  const companyId = 'companyId';

  const item = Item(
    category: 'category',
    id: 'id',
    name: 'name',
    description: 'description',
    itemPhoto: 'itemPhoto',
    itemCode: 'itemCode',
    sparePartFor: [],
    itemUnit: ItemUnit.pcs,
    locations: [],
    amountInLocations: [],
  );

  final itemAction = ItemAction(
    id: 'id',
    title: 'title',
    description: 'description',
    ammount: 0,
    itemUnit: ItemUnit.pcs,
    locationId: 'locationId',
    date: DateTime.now(),
    itemId: 'itemId',
  );

  final tItemActionParams = ItemActionParams(
    updatedItem: item,
    itemAction: itemAction,
    companyId: companyId,
  );

  setUp(() {
    mockCompanyProfileBloc = MockCompanyProfileBloc();

    mockAddItemAction = MockAddItemAction();
    mockUpdateItemAction = MockUpdateItemAction();
    mockDeleteItemAction = MockDeleteItemAction();

    when(() => mockCompanyProfileBloc.stream).thenAnswer(
      (_) => Stream.fromFuture(
        Future.value(CompanyProfileEmpty()),
      ),
    );

    itemActionManagementBloc = ItemActionManagementBloc(
      companyProfileBloc: mockCompanyProfileBloc,
      addItemAction: mockAddItemAction,
      updateItemAction: mockUpdateItemAction,
      deleteItemAction: mockDeleteItemAction,
    );
  });

  setUpAll(
    () {
      registerFallbackValue(tItemActionParams);
    },
  );

  group('ItemAction Management BLoC', () {
    test(
      'should emit [ItemActionManagementEmptyState] as an initial state',
      () async {
        // assert
        expect(
          itemActionManagementBloc.state,
          ItemActionManagementEmptyState(),
        );
      },
    );
  });
}
