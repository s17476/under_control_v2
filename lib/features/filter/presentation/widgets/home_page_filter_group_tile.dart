import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:under_control_v2/features/core/utils/show_snack_bar.dart';
import 'package:under_control_v2/features/groups/presentation/pages/group_details.dart';

import '../../../groups/domain/entities/group.dart';
import '../../../groups/presentation/blocs/group/group_bloc.dart';

class HomePageFilterGroupTile extends StatefulWidget {
  const HomePageFilterGroupTile({
    Key? key,
    required this.group,
    required this.color,
    required this.isAdmin,
  }) : super(key: key);

  final Group group;
  final Color color;
  final bool isAdmin;
  @override
  State<HomePageFilterGroupTile> createState() =>
      _HomePageFilterGroupTileState();
}

class _HomePageFilterGroupTileState extends State<HomePageFilterGroupTile> {
  bool isSelected = false;

  @override
  void didChangeDependencies() {
    if (widget.isAdmin) {
      final state = context.watch<GroupBloc>().state as GroupLoadedState;

      if (state.selectedGroups.contains(widget.group)) {
        isSelected = true;
      } else {
        isSelected = false;
      }
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: InkWell(
        onTap: () => Navigator.pushNamed(
          context,
          GroupDetailsPage.routeName,
          arguments: widget.group,
        ),
        borderRadius: BorderRadius.circular(10),
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
              // selectable if current user is administrator
              if (widget.isAdmin)
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
                ),
              // check icon if user is not an administrator
              if (!widget.isAdmin)
                const Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Icon(Icons.done),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
