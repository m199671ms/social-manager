import 'package:flutter/material.dart';
import 'package:social_manager/generated/l10n.dart';
import 'package:social_manager/models/service.dart';
import 'package:social_manager/models/service_tab.dart';
import 'package:social_manager/view/home/screens/tab_screen.dart';
import 'package:uuid/uuid.dart';

class MediaScreen extends StatefulWidget {
  final MediaService media;
  const MediaScreen({Key? key, required this.media}) : super(key: key);

  @override
  State<MediaScreen> createState() => MediaScreenState();
  static void add(BuildContext context, String url) =>
      context.findAncestorStateOfType<MediaScreenState>()!.add(url);
  static void remove(BuildContext context, ServiceTab tab) =>
      context.findAncestorStateOfType<MediaScreenState>()!.remove(tab);
}

class MediaScreenState extends State<MediaScreen>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late TabController tabController;
  List<ServiceTab> tabs = <ServiceTab>[];
  final Uuid uuid = const Uuid();
  @override
  void initState() {
    tabController = TabController(length: 1, vsync: this);
    tabs.add(ServiceTab(
        id: uuid.v4(), service: widget.media, url: widget.media.homeUrl));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        TabBar(
          controller: tabController,
          isScrollable: true,
          indicatorSize: TabBarIndicatorSize.label,
          labelColor: Theme.of(context).primaryColor,
          tabs: [
            for (var i = 0; i < tabs.length; i++)
              Tab(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      S.of(context).tab_no + (i + 1).toString(),
                      style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Theme.of(context).colorScheme.onBackground
                            : null,
                      ),
                    ),
                    InkResponse(
                      onTap: () {
                        remove(tabs[i]);
                      },
                      child: Icon(
                        Icons.close,
                        color: Theme.of(context).errorColor,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
        Expanded(
          child: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: tabController,
            children: [
              for (var i = 0; i < tabs.length; i++)
                TabScreen(
                  tab: tabs[i],
                ),
            ],
          ),
        ),
      ],
    );
  }

  void remove(ServiceTab tab) {
    setState(() {
      tabs.remove(tab);
      _updateController();
    });
  }

  void _updateController() {
    final oldController = tabController;
    tabController = TabController(length: tabs.length, vsync: this);
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      oldController.dispose();
    });
  }

  void add(String url) {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      setState(() {
        tabs.add(ServiceTab(
          id: uuid.v4(),
          service: widget.media,
          url: Uri.parse(url),
        ));
        final oldController = tabController;
        tabController = TabController(
            length: tabs.length, vsync: this, initialIndex: tabs.length - 1);
        WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
          oldController.dispose();
        });
      });
    });
  }

  @override
  bool get wantKeepAlive => true;
}
