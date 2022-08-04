import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../groups/domain/entities/group.dart';
import '../../../groups/presentation/blocs/group/group_bloc.dart';
import '../../../groups/presentation/widgets/group_management/group_tile.dart';
import '../../../user_profile/domain/entities/user_profile.dart';

class ManageGroupsCard extends StatefulWidget {
  const ManageGroupsCard({
    Key? key,
    required this.user,
    required this.onDismiss,
  }) : super(key: key);

  final UserProfile user;
  final VoidCallback onDismiss;

  @override
  State<ManageGroupsCard> createState() => _ManageGroupsCardState();
}

class _ManageGroupsCardState extends State<ManageGroupsCard> {
  List<Group> allGroups = [];

  @override
  void didChangeDependencies() {
    final groupState = context.watch<GroupBloc>().state;
    if (groupState is GroupLoadedState) {
      allGroups = groupState.allGroups.allGroups;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      InkWell(
        onTap: () => widget.onDismiss(),
        child: TweenAnimationBuilder(
          duration: const Duration(milliseconds: 300),
          tween: Tween<double>(begin: 0.0, end: 0.5),
          builder: (context, double value, child) {
            return BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 5.0,
                sigmaY: 5.0,
              ),
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                color: Colors.black.withOpacity(value),
              ),
            );
          },
        ),
      ),
      TweenAnimationBuilder(
        duration: const Duration(milliseconds: 300),
        tween: Tween<double>(begin: 0.0, end: 1.0),
        builder: (context, double value, child) {
          return Opacity(
            opacity: value,
            child: child,
          );
        },
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Container(
              margin: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      // title
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          AppLocalizations.of(context)!
                              .group_manage_user_groups,
                          style: Theme.of(context).textTheme.headline6,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Divider(thickness: 1.5),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: allGroups.length,
                        itemBuilder: (context, index) {
                          return GroupTile(
                            group: allGroups[index],
                            isSelectionTile: true,
                            user: widget.user,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}
