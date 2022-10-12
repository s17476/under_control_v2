import 'package:url_launcher/url_launcher.dart';

Future<void> makePhoneCall(String phoneNumber) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );
  await launchUrl(launchUri);
}

Future<void> sendSms(String phoneNumber) async {
  final Uri launchUri = Uri(
    scheme: 'sms',
    path: phoneNumber,
  );
  await launchUrl(launchUri);
}

Future<void> mailTo(String emailAddress) async {
  final Uri launchUri = Uri(
    scheme: 'mailto',
    path: emailAddress,
  );
  await launchUrl(launchUri);
}

Future<void> openInBrowser(String url) async {
  final Uri launchUri = Uri(
    scheme: 'https',
    path: url,
  );
  await launchUrl(launchUri, mode: LaunchMode.externalApplication);
}

Future<void> launchYoutubeVideo(String youtubeUrl) async {
  if (youtubeUrl.isNotEmpty) {
    final uri = Uri.parse(youtubeUrl);
    if (await canLaunchUrl(uri)) {
      final bool _nativeAppLaunchSucceeded = await launchUrl(
        uri,
        mode: LaunchMode.externalNonBrowserApplication,
      );
      if (!_nativeAppLaunchSucceeded) {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
      }
    }
  }
}
