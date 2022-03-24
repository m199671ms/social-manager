import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_manager/generated/l10n.dart';
import 'package:social_manager/models/history.dart';
// import 'package:social_manager/models/service_tab.dart';
import 'package:social_manager/utils/store.dart';
import 'package:social_manager/view/home/home.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AspectRatio(
              aspectRatio: 1.0,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(155),
                ),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Color(0xffE3E3BB),
                  ),
                  child: Center(
                    child: Image(
                      image: AssetImage('assets/images/logo.png'),
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                S.of(context).theme,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            ValueListenableBuilder(
              valueListenable: Store.listenToSettings(),
              builder: (_, __, ____) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ChoiceChip(
                    selected: Store.theme == ThemeMode.light,
                    label: Text(S.of(context).light),
                    avatar: const Icon(Icons.light_mode),
                    onSelected: (value) {
                      if (value) {
                        Store.theme = ThemeMode.light;
                      }
                    },
                  ),
                  ChoiceChip(
                    selected: Store.theme == ThemeMode.system,
                    label: Text(S.of(context).system),
                    avatar: const Icon(Icons.settings),
                    onSelected: (value) {
                      if (value) {
                        Store.theme = ThemeMode.system;
                      }
                    },
                  ),
                  ChoiceChip(
                    selected: Store.theme == ThemeMode.dark,
                    label: Text(S.of(context).dark),
                    avatar: const Icon(Icons.dark_mode),
                    onSelected: (value) {
                      if (value) {
                        Store.theme = ThemeMode.dark;
                      }
                    },
                  ),
                ],
              ),
            ),
            const Divider(),
            ListTile(
              title: Text(S.of(context).saved_links),
              leading: const FaIcon(Icons.saved_search),
              onTap: () async {
                final results =
                    await Navigator.pushNamed(context, 'saved_links');
                if (results is History) {
                  HomeScreen.addTab(context, results);
                }
                Navigator.pop(context);
              },
            ),
            const Divider(),
            ListTile(
              title: Text(S.of(context).my_media),
              leading: const FaIcon(FontAwesomeIcons.slideshare),
              onTap: () async {
                HomeScreenState state =
                    context.findAncestorStateOfType<HomeScreenState>()!;
                Navigator.pop(context);
                await Navigator.of(context).pushNamed('my_media');
                // ignore: invalid_use_of_protected_member
                state.setState(() {});
              },
            ),
            const Divider(),
            ListTile(
              title: Text(S.of(context).my_statistics),
              leading: const FaIcon(Icons.bar_chart),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, 'my_statistics');
              },
            ),
            const Divider(),
            ListTile(
              title: Text(S.of(context).my_history),
              leading: const FaIcon(Icons.history),
              onTap: () async {
                final results =
                    await Navigator.pushNamed(context, 'my_history');
                if (results is History) {
                  HomeScreen.addTab(context, results);
                }
                Navigator.pop(context);
              },
            ),
            const Divider(),
            ListTile(
              title: Text(
                S.of(context).log_out,
                style: TextStyle(color: Theme.of(context).errorColor),
              ),
              onTap: () {
                Store.user = null;
                Navigator.pushReplacementNamed(context, 'auth');
              },
              leading: FaIcon(
                FontAwesomeIcons.powerOff,
                color: Theme.of(context).errorColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
