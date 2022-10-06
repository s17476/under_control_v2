import 'package:flutter/material.dart';
import 'package:flutter_link_previewer/flutter_link_previewer.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' show PreviewData;

class UrlPreview extends StatefulWidget {
  const UrlPreview({
    Key? key,
    required this.url,
  }) : super(key: key);

  final String url;

  @override
  State<UrlPreview> createState() => _UrlPreviewState();
}

class _UrlPreviewState extends State<UrlPreview> {
  PreviewData? _data;
  @override
  Widget build(BuildContext context) {
    return LinkPreview(
      enableAnimation: true,
      onPreviewDataFetched: (data) {
        setState(() {
          _data = data;
        });
      },
      previewData: _data,
      text: widget.url,
      width: double.infinity,
      linkStyle: Theme.of(context)
          .textTheme
          .headline6!
          .copyWith(color: Theme.of(context).primaryColor),
      padding: const EdgeInsets.all(8),
      openOnPreviewImageTap: true,
    );
  }
}
