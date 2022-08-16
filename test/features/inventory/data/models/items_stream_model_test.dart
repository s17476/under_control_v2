import 'package:flutter_test/flutter_test.dart';
import 'package:under_control_v2/features/inventory/data/models/items_stream_model.dart';
import 'package:under_control_v2/features/inventory/domain/entities/items_stream.dart';

void main() {
  final tItemsStreamModel = ItemsStreamModel(
    allItems: Stream.fromIterable([]),
  );

  group('Inventory', () {
    test(
      'should be a subclass of [ItemsStream] entity',
      () async {
        // assert
        expect(tItemsStreamModel, isA<ItemsStream>());
      },
    );
  });
}
