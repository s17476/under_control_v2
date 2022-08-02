import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/company_profile/presentation/widgets/user_management_dialogs.dart';
import 'package:under_control_v2/features/user_profile/presentation/blocs/user_management/user_management_bloc.dart';

import '../../../core/presentation/widgets/cached_user_avatar.dart';
import '../../../core/presentation/widgets/url_launcher_helpers.dart';
import '../../domain/entities/user_profile.dart';

class NewUserListTile extends StatelessWidget {
  const NewUserListTile({
    Key? key,
    required this.user,
  }) : super(key: key);

  final UserProfile user;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(
        top: 8,
      ),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Column(
        children: [
          CachedUserAvatar(
            size: 300,
            imageUrl: user.avatarUrl,
          ),
          const SizedBox(height: 4),
          Text(
            '${user.firstName} ${user.lastName}',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(
            thickness: 1.5,
          ),
          InkWell(
            onTap: () => makePhoneCall(user.phoneNumber),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Icon(
                    Icons.phone,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    child: Text(
                      AppLocalizations.of(context)!
                          .user_profile_add_user_personal_data_phone_number,
                      style: const TextStyle(fontSize: 16),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    user.phoneNumber,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () => mailTo(user.email),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Icon(
                    Icons.mail,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    child: Text(
                      AppLocalizations.of(context)!
                          .add_company_intro_card_email,
                      style: const TextStyle(fontSize: 16),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    user.email,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          const Divider(
            thickness: 1.5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () =>
                    showUserRejectDialog(context: context, user: user),
                child: Text(
                  AppLocalizations.of(context)!.reject,
                  style: TextStyle(
                    fontSize: 22,
                    color: Theme.of(context).errorColor,
                  ),
                ),
              ),
              TextButton(
                onPressed: () =>
                    showUserApproveDialog(context: context, user: user),
                child: Text(
                  AppLocalizations.of(context)!.approve,
                  style: TextStyle(
                    fontSize: 22,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
