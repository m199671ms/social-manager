import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:social_manager/generated/l10n.dart';
import 'package:url_launcher/url_launcher.dart';

class PostScheduling extends StatefulWidget {
  const PostScheduling({Key? key}) : super(key: key);

  @override
  State<PostScheduling> createState() => _PostSchedulingState();
}

class _PostSchedulingState extends State<PostScheduling> {
  late final InAppWebViewController controller;
  late final PullToRefreshController refreshController;
  final StreamController<double> _progress = StreamController<double>();
  @override
  void initState() {
    refreshController = PullToRefreshController(onRefresh: () {
      controller.reload();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).social_manager),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: Uri.parse('https://app.sendible.com/#services'),
        ),
        initialOptions: InAppWebViewGroupOptions(
          android: AndroidInAppWebViewOptions(
            builtInZoomControls: false,
            clearSessionCache: false,
            useHybridComposition: true,
          ),
          crossPlatform: InAppWebViewOptions(
            supportZoom: false,
            transparentBackground: true,
          ),
        ),
        pullToRefreshController: refreshController,
        onWebViewCreated: (controller) {
          this.controller = controller;
        },
        androidOnPermissionRequest: (controller, origin, resources) async {
          return PermissionRequestResponse(
            resources: resources,
            action: PermissionRequestResponseAction.GRANT,
          );
        },
        shouldOverrideUrlLoading: (controller, navigationAction) async {
          var uri = navigationAction.request.url!;
          String url = uri.toString();
          if (![
            "http",
            "https",
            "file",
            "chrome",
            "data",
            "javascript",
            "about"
          ].contains(uri.scheme)) {
            if (await canLaunch(url)) {
              await launch(
                url,
              );
              return NavigationActionPolicy.CANCEL;
            }
          }

          return NavigationActionPolicy.ALLOW;
        },
        onLoadStop: (controller, url) async {
          refreshController.endRefreshing();
        },
        onLoadError: (controller, url, code, message) {
          refreshController.endRefreshing();
        },
        onProgressChanged: (controller, progress) {
          if (progress == 100) {
            refreshController.endRefreshing();
            _progress.add(0.0);
          } else {
            _progress.add(progress.toDouble() / 100.0);
          }
        },
        onConsoleMessage: (controller, consoleMessage) {},
      ),
    );
  }
}
