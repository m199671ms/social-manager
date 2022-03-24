import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:social_manager/generated/l10n.dart';
import 'package:social_manager/models/service_tab.dart';
import 'package:social_manager/utils/api_handler.dart';
import 'package:social_manager/utils/helper.dart';
import 'package:social_manager/view/home/screens/media_screen.dart';
import 'package:social_manager/view/home/widgets/link_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

class TabScreen extends StatefulWidget {
  final ServiceTab tab;
  const TabScreen({Key? key, required this.tab}) : super(key: key);

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen>
    with AutomaticKeepAliveClientMixin {
  late final InAppWebViewController controller;
  final Key webViewKey = UniqueKey();
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
    super.build(context);
    return Column(
      children: [
        StreamBuilder<double>(
            stream: _progress.stream,
            builder: (context, snapshot) {
              if (snapshot.data == 0.0 || snapshot.data == 1.0) {
                return const SizedBox.shrink();
              }
              return LinearProgressIndicator(
                value: snapshot.data,
              );
            }),
        Expanded(
          child: InAppWebView(
            key: webViewKey,
            onLongPressHitTestResult: (controller, hitTestResult) async {
              if (InAppWebViewHitTestResultType.SRC_ANCHOR_TYPE ==
                  hitTestResult.type) {
                dynamic results = await showDialog(
                  context: context,
                  builder: (_) => LinkDialog(
                    media: widget.tab.service,
                    uri: Uri.parse(hitTestResult.extra!),
                  ),
                );
                switch (results.runtimeType) {
                  case bool:
                    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
                      MediaScreen.add(context, hitTestResult.extra!);
                    });
                    break;
                  case Null:
                    break;
                  case Future:
                  case Uri:
                    if (results is Future) results = await results;
                    await Future.delayed(const Duration(milliseconds: 50));
                    Helper.showMessage(
                        context: context,
                        subtitle: S.of(context).the_link_is_saved_successfully);
                }
              }
              // hitTestResult.type
            },
            initialUrlRequest: URLRequest(
              url: widget.tab.url,
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
                  // Launch the App
                  await launch(
                    url,
                  );
                  // and cancel the request
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
            onUpdateVisitedHistory: (controller, url, androidIsReload) {
              if (url != null) {
                ApiHandler.addHistoryLink(
                  link: url,
                  service: widget.tab.service,
                );
              }
            },
            onConsoleMessage: (controller, consoleMessage) {},
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
