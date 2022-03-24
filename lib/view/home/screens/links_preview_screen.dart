import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:social_manager/generated/l10n.dart';
import 'package:social_manager/models/history.dart';
import 'package:social_manager/models/service.dart';
import 'package:social_manager/utils/helper.dart';
import 'package:social_manager/utils/store.dart';
import 'package:social_manager/view/tools/link_preview.dart';
import 'package:swipeable_tile/swipeable_tile.dart';

class LinksPreviewScreen extends StatefulWidget {
  final String title;
  final String dateDescriber;
  final String Function(String) emptyStateString;
  final Future<List<History>> Function({required MediaService media}) fetchData;
  final Future<List<History>> Function({
    required MediaService media,
    required History history,
  }) deleteData;
  const LinksPreviewScreen({
    Key? key,
    required this.title,
    required this.dateDescriber,
    required this.emptyStateString,
    required this.fetchData,
    required this.deleteData,
  }) : super(key: key);

  @override
  State<LinksPreviewScreen> createState() => _LinksPreviewScreenState();
}

class _LinksPreviewScreenState extends State<LinksPreviewScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: Store.user!.services.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(widget.title),
            collapsedHeight: kToolbarHeight,
            forceElevated: true,
            stretch: true,
            floating: true,
            pinned: true,
            primary: true,
            toolbarHeight: kToolbarHeight,
            bottom: TabBar(
                controller: _tabController,
                isScrollable: Store.user!.services.length > 3,
                tabs: Store.user!.services
                    .map(
                      (e) => Tab(
                        text: e.name,
                        icon: Helper.mediaIcon(e),
                      ),
                    )
                    .toList()),
          ),
          SliverFillRemaining(
            child: TabBarView(
              children: [
                for (var media in Store.user!.services)
                  _MediaPreview(
                    media: media,
                    emptyStateString: widget.emptyStateString,
                    deleteData: widget.deleteData,
                    fetchData: widget.fetchData,
                    dateDescriber: widget.dateDescriber,
                  ),
              ],
              controller: _tabController,
            ),
          )
        ],
      ),
    );
  }
}

class _MediaPreview extends StatefulWidget {
  final MediaService media;
  final String Function(String) emptyStateString;
  final String dateDescriber;
  final Future<List<History>> Function({required MediaService media}) fetchData;
  final Future<List<History>> Function({
    required MediaService media,
    required History history,
  }) deleteData;
  const _MediaPreview({
    Key? key,
    required this.media,
    required this.dateDescriber,
    required this.emptyStateString,
    required this.fetchData,
    required this.deleteData,
  }) : super(key: key);

  @override
  State<_MediaPreview> createState() => _MediaPreviewState();
}

class _MediaPreviewState extends State<_MediaPreview>
    with AutomaticKeepAliveClientMixin {
  late Future<List<History>> _future;
  @override
  void initState() {
    _future = widget.fetchData(media: widget.media);
    super.initState();
  }

  final List<History> _history = [];
  delete(History history) {
    _history.removeWhere((element) => element == history);
    final future = widget.deleteData(history: history, media: widget.media);
    setState(() {
      if (_history.isEmpty) {
        _future = future;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder<List<History>>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.hasError && snapshot.data == null) {
          return SizedBox.expand(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  S.of(context).connection_error,
                  style: Theme.of(context).textTheme.headline4,
                ),
                const SizedBox(height: 32.0),
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    primary: Theme.of(context).colorScheme.error,
                  ),
                  onPressed: () {
                    setState(() {
                      _future = widget.fetchData(media: widget.media);
                    });
                  },
                  icon: const Icon(Icons.refresh),
                  label: Text(S.of(context).retry),
                ),
              ],
            ),
          );
        }
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case ConnectionState.done:
            if (_history.isEmpty) _history.addAll(snapshot.data!);
            if (snapshot.data!.isEmpty) {
              return _MediaEmptyState(
                emptyStateString: widget.emptyStateString,
                media: widget.media,
              );
            }
            return ListView.separated(
              key: ValueKey<MediaService>(widget.media),
              itemBuilder: (context, index) => _LinkTile(
                link: _history[index],
                media: widget.media,
                dateDescriber: widget.dateDescriber,
              ),
              separatorBuilder: (_, __) => const Divider(),
              itemCount: _history.length,
            );
        }
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _MediaEmptyState extends StatelessWidget {
  final MediaService media;
  final String Function(String) emptyStateString;
  const _MediaEmptyState({
    Key? key,
    required this.media,
    required this.emptyStateString,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ShaderMask(
          blendMode: BlendMode.dstOut,
          shaderCallback: (Rect bounds) {
            return Helper.cracksShader;
          },
          child: Helper.mediaIcon(
            media,
            theme: IconThemeData(
              size: 150,
              color: media.iconColor.withAlpha(150),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            emptyStateString(media.name),
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
      ],
    );
  }
}

class _LinkTile extends StatefulWidget {
  final History link;
  final MediaService media;
  final String dateDescriber;
  const _LinkTile({
    Key? key,
    required this.dateDescriber,
    required this.link,
    required this.media,
  }) : super(key: key);

  @override
  State<_LinkTile> createState() => _LinkTileState();
}

class _LinkTileState extends State<_LinkTile>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<double> animationView;
  @override
  void initState() {
    const duration = Duration(microseconds: 7700);
    animationController = AnimationController(
      vsync: this,
      duration: duration,
      reverseDuration: duration,
    );
    animationView =
        CurvedAnimation(parent: animationController, curve: Curves.ease);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SwipeableTile(
      direction: SwipeDirection.endToStart,
      backgroundBuilder: (BuildContext context, SwipeDirection direction,
              AnimationController progress) =>
          DecoratedBox(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.errorContainer,
        ),
        child: AnimatedBuilder(
            animation: progress,
            builder: (_, __) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    S.of(context).delete_link,
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: Theme.of(context).colorScheme.onErrorContainer,
                        ),
                  ),
                  SizedBox(
                    width: 50 * progress.value,
                  ),
                  Icon(
                    Icons.delete_forever,
                    color: Theme.of(context).colorScheme.onErrorContainer,
                  ),
                  SizedBox(
                    width: 50 * progress.value,
                  ),
                ],
              );
            }),
      ),
      color: Theme.of(context).scaffoldBackgroundColor,
      onSwiped: (SwipeDirection direction) {
        context
            .findAncestorStateOfType<_MediaPreviewState>()!
            .delete(widget.link);
      },
      key: ValueKey<History>(widget.link),
      child: ListTile(
        title: Text(
          widget.link.link,
          maxLines: 3,
          overflow: TextOverflow.fade,
        ),
        subtitle: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: widget.dateDescriber + ' : '),
                      TextSpan(
                          text:
                              DateFormat.yMMMd().format(widget.link.visitedAt)),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: widget.media.name),
                          const TextSpan(text: ' | '),
                          TextSpan(text: S.of(context).show_preview),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        switch (animationView.status) {
                          case AnimationStatus.dismissed:
                          case AnimationStatus.reverse:
                            animationController.forward(
                              from: animationController.value,
                            );
                            break;
                          case AnimationStatus.forward:
                          case AnimationStatus.completed:
                            animationController.reverse(
                              from: animationController.value,
                            );
                            break;
                        }
                      },
                      icon: AnimatedIcon(
                        size: 20,
                        color: Theme.of(context).unselectedWidgetColor,
                        icon: AnimatedIcons.menu_close,
                        progress: animationView,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizeTransition(
              sizeFactor: animationView,
              child: DirectLinkPreview(
                uri: Uri.parse(widget.link.link),
                history: widget.link,
              ),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  widget.link,
                );
              },
              icon: const Icon(Icons.arrow_forward_ios),
            )
          ],
        ),
        leading: Helper.mediaIcon(widget.media),
      ),
    );
  }
}
