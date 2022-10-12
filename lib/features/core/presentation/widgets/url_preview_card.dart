import 'package:flutter/material.dart';
import 'package:flutter_link_previewer/flutter_link_previewer.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' show PreviewData;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'url_preview.dart';

class UrlPreviewCard extends StatelessWidget {
  const UrlPreviewCard({
    Key? key,
    required this.url,
  }) : super(key: key);

  final String? url;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: FutureBuilder(
              future: getPreviewData(url ?? ''),
              builder: (context, snapshot) {
                return Stack(
                  children: [
                    // preview loaded
                    if (snapshot.connectionState == ConnectionState.done &&
                        url != null &&
                        (snapshot.data as PreviewData).title != null)
                      UrlPreview(url: url!),
                    // preview loading
                    if (snapshot.connectionState != ConnectionState.done)
                      SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.width,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    // page not found
                    if (snapshot.connectionState == ConnectionState.done &&
                        url != null &&
                        (snapshot.data as PreviewData).title == null)
                      SizedBox(
                        height: MediaQuery.of(context).size.width,
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            AppLocalizations.of(context)!.content_url_404,
                          ),
                        ),
                      ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
