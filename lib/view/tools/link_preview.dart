// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_link_previewer/flutter_link_previewer.dart';
import 'package:social_manager/models/history.dart';
import 'package:social_manager/utils/store.dart';

class DirectLinkPreview extends StatelessWidget {
  final Uri uri;
  final History? history;
  const DirectLinkPreview({
    Key? key,
    required this.uri,
    required this.history,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<PreviewData?> notifier =
        ValueNotifier<PreviewData?>(null);
    Store.listenToLink(uri.toString()).addListener(() {
      notifier.value = Store.previewOf(history!);
    });
    return ValueListenableBuilder<PreviewData?>(
      valueListenable: notifier,
      builder: (_, data, ___) => LinkPreview(
        previewData: data,
        text: uri.toString(),
        width: double.infinity,
        onPreviewDataFetched: (data) {
          if (history != null) {
            Store.addLinkPreviewData(history!, data);
          } else {
            notifier.value = data;
          }
        },
      ),
    );
  }
}
