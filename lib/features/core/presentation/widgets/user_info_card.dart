import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../user_profile/domain/entities/user_profile.dart';
import '../../utils/responsive_size.dart';
import '../../utils/size_config.dart';
import 'url_launcher_helpers.dart';

class UserInfoCard extends StatefulWidget {
  const UserInfoCard({
    Key? key,
    required this.user,
    required this.onDismiss,
  }) : super(key: key);

  final UserProfile user;
  final VoidCallback onDismiss;

  @override
  State<UserInfoCard> createState() => _UserInfoCardState();
}

class _UserInfoCardState extends State<UserInfoCard> with ResponsiveSize {
  bool _hasCallSupport = false;

  @override
  void initState() {
    super.initState();
    // Check for phone call support.
    canLaunchUrl(Uri(scheme: 'tel', path: '123')).then((bool result) {
      setState(() {
        _hasCallSupport = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
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
          child: Container(
            width: responsiveSizePct(small: 70),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 24,
                  ),
                  // avatar
                  ClipOval(
                    child: CachedNetworkImage(
                      height: responsiveSizePct(small: 40),
                      width: responsiveSizePct(small: 40),
                      fit: BoxFit.fitWidth,
                      imageUrl: widget.user.avatarUrl,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.image_not_supported_rounded),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  // first name
                  Text(
                    widget.user.firstName,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  // last name
                  Text(
                    widget.user.lastName,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(height: 16),
                  const Divider(thickness: 1.5),
                  const SizedBox(height: 8),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // call
                      if (_hasCallSupport)
                        InkWell(
                          onTap: () => makePhoneCall(widget.user.phoneNumber),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.call,
                                  size: 30,
                                  color: Theme.of(context).primaryColor,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  AppLocalizations.of(context)!.call,
                                  style: Theme.of(context).textTheme.headline6,
                                )
                              ],
                            ),
                          ),
                        ),
                      // send sms
                      if (_hasCallSupport)
                        InkWell(
                          onTap: () => sendSms(widget.user.phoneNumber),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.message,
                                  size: 30,
                                  color: Theme.of(context).primaryColor,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  AppLocalizations.of(context)!.send_sms,
                                  style: Theme.of(context).textTheme.headline6,
                                )
                              ],
                            ),
                          ),
                        ),
                      // send email
                      InkWell(
                        onTap: () => mailTo(widget.user.email),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.email,
                                size: 30,
                                color: Theme.of(context).primaryColor,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                AppLocalizations.of(context)!.send_email,
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}
