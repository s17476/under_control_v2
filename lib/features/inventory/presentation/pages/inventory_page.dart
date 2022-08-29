import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../blocs/items/items_bloc.dart';

class InventoryPage extends StatelessWidget {
  const InventoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            BlocBuilder<ItemsBloc, ItemsState>(
              builder: (context, state) {
                print('state');
                print(state);
                if (state is ItemsLoadedState) {
                  final filteredItems = state.allItems.allItems;
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Text(filteredItems[index].name),
                      );
                    },
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
