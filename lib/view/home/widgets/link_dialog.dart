import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:social_manager/generated/l10n.dart';
import 'package:social_manager/models/service.dart';
import 'package:social_manager/utils/api_handler.dart';
import 'package:social_manager/view/tools/link_preview.dart';

class LinkDialog extends StatelessWidget {
  final Uri uri;
  final MediaService media;
  const LinkDialog({
    Key? key,
    required this.uri,
    required this.media,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: DirectLinkPreview(
        uri: uri,
        history: null,
      ),
      children: [
        ListTile(
          title: Text(S.of(context).save_link),
          subtitle: Text(S.of(context).the_link_will_appear_in_saved_links),
          onTap: () {
            Navigator.pop(
                context, ApiHandler.saveLink(link: uri, service: media));
          },
        ),
        ListTile(
          title: Text(S.of(context).open_in_new_tab),
          onTap: () {
            Navigator.pop(context, true);
          },
        ),
        ListTile(
          title: Text(S.of(context).share),
          onTap: () async {
            await Share.share(uri.toString());
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
