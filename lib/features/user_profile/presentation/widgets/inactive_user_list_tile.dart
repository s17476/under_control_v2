import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../company_profile/utils/user_management_dialogs.dart';
import '../../../core/presentation/widgets/cached_user_avatar.dart';
import '../../../core/utils/url_launcher_helpers.dart';
import '../../domain/entities/user_profile.dart';

class InactiveUserListTile extends StatelessWidget {
  const InactiveUserListTile({
    Key? key,
    required this.user,
    required this.isNewUser,
  }) : super(key: key);

  final UserProfile user;
  final bool isNewUser;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              // avatar
              CachedUserAvatar(
                size: 300,
                imageUrl: user.avatarUrl,
              ),
              const SizedBox(height: 4),
              // first and last names
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
              // phone number
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: InkWell(
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
              ),
              // email
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: InkWell(
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
              ),
              const SizedBox(
                height: 4,
              ),
              const Divider(
                thickness: 1.5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // reject button
                  Expanded(
                    child: TextButton(
                      onPressed: () => showUserRejectDialog(
                        context: context,
                        user: user,
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.reject,
                        style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).textTheme.caption!.color,
                        ),
                      ),
                    ),
                  ),
                  // accept passive
                  Expanded(
                    child: TextButton(
                      onPressed: () => showUserApproveDialog(
                        context: context,
                        user: user,
                        isActive: false,
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.approve_passive,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  // unsuspend button
                  // if (!isNewUser)
                  //   Expanded(
                  //     child: Container(
                  //       color: Theme.of(context).primaryColor,
                  //       child: TextButton(
                  //         onPressed: () => showUserUnsuspendDialog(
                  //           context: context,
                  //           user: user,
                  //         ),
                  //         child: Text(
                  //           AppLocalizations.of(context)!.unsuspend,
                  //           style: const TextStyle(
                  //             fontSize: 22,
                  //             color: Colors.white,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // approve button

                  Expanded(
                    child: TextButton(
                      onPressed: () => showUserApproveDialog(
                        context: context,
                        user: user,
                        isActive: true,
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.approve,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.amber,
                        ),
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
