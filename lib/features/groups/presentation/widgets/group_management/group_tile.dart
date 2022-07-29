import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import '../../../domain/entities/group.dart';
import '../../pages/group_details.dart';

class GroupTile extends StatelessWidget {
  const GroupTile({
    Key? key,
    required this.group,
  }) : super(key: key);

  final Group group;

  @override
  Widget build(BuildContext context) {
    final currentUser =
        (context.read<UserProfileBloc>().state as Approved).userProfile;
    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        GroupDetailsPage.routeName,
        arguments: group,
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 4,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).focusColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // title row
            Row(
              children: [
                Icon(
                  Icons.group,
                  color: Theme.of(context).primaryColor,
                  size: 24,
                ),
                // shows icon if user is group administrator
                //and is not an company administrator
                if (group.groupAdministrators.contains(currentUser.id) &&
                    !currentUser.administrator)
                  Icon(
                    Icons.gpp_good,
                    color: Theme.of(context).primaryColor,
                  ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Text(
                    group.name,
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          color: Colors.grey.shade200,
                          fontSize: 18,
                        ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),

            // description
            if (group.description.isNotEmpty)
              Text(
                group.description,
                style: Theme.of(context).textTheme.labelMedium,
              ),
          ],
        ),
      ),
    );
  }
}
