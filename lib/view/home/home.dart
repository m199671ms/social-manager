import 'package:flutter/material.dart';
import 'package:social_manager/generated/l10n.dart';
import 'package:social_manager/models/history.dart';
import 'package:social_manager/utils/helper.dart';
import 'package:social_manager/utils/store.dart';
import 'package:social_manager/view/home/screens/media_screen.dart';
import 'package:social_manager/view/home/widgets/drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => HomeScreenState();
  static void addTab(BuildContext context, History history) =>
      context.findAncestorStateOfType<HomeScreenState>()!._addTab(history);
}

class HomeScreenState extends State<HomeScreen> {
  static void reload(BuildContext context) =>
      context.findAncestorStateOfType<HomeScreenState>()!.setState(() {});
  int index = 1;
  final PageController pageController = PageController();
  final List<GlobalKey<MediaScreenState>> _mediaKeys = [];
  void _addTab(History history) {
    // adding
    final mediaKey = _mediaKeys.singleWhere(
        (element) => element.currentState!.widget.media.id == history.mediaId);
    mediaKey.currentState!.add(history.link);
    // navigating to media
    int mediaIndex = _mediaKeys.indexOf(mediaKey);
    pageController.animateToPage(
      mediaIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
    setState(() {
      index = mediaIndex + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (Store.user!.services.length != _mediaKeys.length) {
      _mediaKeys.clear();
      for (var _ in Store.user!.services) {
        _mediaKeys.add(GlobalKey<MediaScreenState>());
      }
    }
    return Scaffold(
      drawer: const AppDrawer(),
      body: Store.user!.services.isEmpty
          ? const _EmptyServices()
          : Row(
              children: [
                Builder(
                  builder: (context) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: NavigationRail(
                            trailing: const IntrinsicWidth(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Divider(),
                              ),
                            ),
                            labelType: NavigationRailLabelType.selected,
                            selectedLabelTextStyle:
                                Theme.of(context).textTheme.bodyText2,
                            onDestinationSelected: (index) {
                              if (index == 0) {
                                Scaffold.of(context).openDrawer();
                                return;
                              }
                              setState(() {
                                this.index = index;
                              });
                              pageController.animateToPage(
                                index - 1,
                                duration: const Duration(milliseconds: 700),
                                curve: Curves.ease,
                              );
                            },
                            destinations: <NavigationRailDestination>[
                              NavigationRailDestination(
                                icon: Icon(
                                  Icons.menu,
                                  color: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      ?.color,
                                ),
                                label: const Text(''),
                              ),
                              for (var i = 0;
                                  i < Store.user!.services.length;
                                  i++)
                                NavigationRailDestination(
                                  icon: Helper.mediaIcon(
                                    Store.user!.services[i],
                                    theme: IconTheme.of(context).copyWith(
                                      color: Theme.of(context)
                                          .unselectedWidgetColor,
                                    ),
                                  ),
                                  selectedIcon: Helper.mediaIcon(
                                    Store.user!.services[i],
                                  ),
                                  label: Padding(
                                    padding: const EdgeInsets.only(top: 12.0),
                                    child: RotatedBox(
                                      quarterTurns: 1,
                                      child: Text(Store.user!.services[i].name),
                                    ),
                                  ),
                                ),
                            ],
                            selectedIndex: index,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, 'post_scheduling');
                          },
                          icon: const Icon(Icons.share_arrival_time),
                        ),
                      ],
                    );
                  },
                ),
                const VerticalDivider(width: 1.0),
                Expanded(
                  child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    controller: pageController,
                    children: [
                      for (var i = 0; i < Store.user!.services.length; i++)
                        MediaScreen(
                          key: _mediaKeys[i],
                          media: Store.user!.services[i],
                        ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

class _EmptyServices extends StatelessWidget {
  const _EmptyServices({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Image(
          image: AssetImage(
            'assets/images/welcome.gif',
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * .7,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                S.of(context).welcome_user(Store.user!.name),
                style: Theme.of(context).textTheme.headline6?.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  S
                      .of(context)
                      .to_start_your_social_media_journey_you_have_to_enable_some_platforms,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
        ElevatedButton.icon(
          onPressed: () async {
            await Navigator.of(context).pushNamed('my_media');
            HomeScreenState.reload(context);
          },
          icon: const Icon(Icons.settings),
          label: Text(S.of(context).open_settings),
        ),
      ],
    );
  }
}
