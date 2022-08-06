import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../groups/domain/entities/group.dart';
import '../../../groups/presentation/blocs/group/group_bloc.dart';

class HomePageFilterGroupTile extends StatefulWidget {
  const HomePageFilterGroupTile({
    Key? key,
    required this.group,
    required this.color,
  }) : super(key: key);

  final Group group;
  final Color color;
  @override
  State<HomePageFilterGroupTile> createState() =>
      _HomePageFilterGroupTileState();
}

class _HomePageFilterGroupTileState extends State<HomePageFilterGroupTile> {
  bool isSelected = false;

  @override
  void didChangeDependencies() {
    final state = context.watch<GroupBloc>().state as GroupLoadedState;

    if (state.selectedGroups.contains(widget.group)) {
      isSelected = true;
    } else {
      isSelected = false;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: widget.color,
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 16,
            ),
            Expanded(
              // group name
              child: Text(
                widget.group.name,
                style: TextStyle(
                  color: Colors.grey.shade200,
                  fontSize: 14,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Checkbox(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              activeColor: Theme.of(context).primaryColor,
              value: isSelected,
              onChanged: (bool? value) {
                isSelected
                    ? context
                        .read<GroupBloc>()
                        .add(UnselectGroupEvent(group: widget.group))
                    : context
                        .read<GroupBloc>()
                        .add(SelectGroupEvent(group: widget.group));
                setState(() {
                  isSelected = value!;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
