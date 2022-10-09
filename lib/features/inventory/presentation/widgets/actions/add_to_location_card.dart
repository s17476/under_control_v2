import 'package:flutter/material.dart';

import '../../../domain/entities/item.dart';
import 'selectable_locations_list.dart';

class AddToLocationCard extends StatelessWidget {
  const AddToLocationCard({
    Key? key,
    required this.item,
    required this.title,
    this.selectedFromLocation = '',
    required this.selectedLocation,
    this.isSubtract = false,
    this.isFirstPage = true,
    required this.setLocation,
  }) : super(key: key);

  final Item item;
  final String title;
  final String selectedFromLocation;
  final String selectedLocation;
  final bool isSubtract;
  final bool isFirstPage;
  final Function(String) setLocation;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 12,
                      left: 8,
                      right: 8,
                    ),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.headline5!.fontSize,
                      ),
                    ),
                  ),
                  const Divider(
                    thickness: 1.5,
                  ),
                  SelectableLocationsList(
                    selectedLocation: selectedLocation,
                    selectedFromLocation: selectedFromLocation,
                    setLocation: setLocation,
                    item: item,
                    isSubtract: isSubtract,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
