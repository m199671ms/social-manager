import 'package:flutter/cupertino.dart';
import 'package:social_manager/generated/l10n.dart';
import 'package:social_manager/utils/api_handler.dart';
import 'package:social_manager/view/auth/auth.dart';
import 'package:social_manager/view/home/home.dart';
import 'package:social_manager/view/home/screens/links_preview_screen.dart';
import 'package:social_manager/view/settings/my_media.dart';
import 'package:social_manager/view/settings/my_statistics.dart';
import 'package:social_manager/view/settings/post_scheduling.dart';
import 'package:social_manager/view/splash/splash.dart';

class Routes {
  const Routes._();
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      default:
        return _buildRoute(settings);
    }
  }

  static Route<dynamic> _buildRoute(RouteSettings settings,
          [WidgetBuilder? builder]) =>
      CupertinoPageRoute(
        settings: settings,
        builder: builder ?? _routes[settings.name]!,
      );

  static Map<String, Widget Function(BuildContext)> get _routes =>
      <String, Widget Function(BuildContext)>{
        'splash': (_) => const SplashScreen(),
        'home': (_) => const HomeScreen(),
        'saved_links': (context) => LinksPreviewScreen(
              title: S.of(context).saved_links,
              emptyStateString: S.of(context).there_is_no_saved_media_link_yet,
              fetchData: ApiHandler.getSavedLinks,
              deleteData: ApiHandler.deleteLink,
              dateDescriber: S.current.saved_at,
            ),
        'my_history': (context) => LinksPreviewScreen(
              dateDescriber: S.current.visited_at,
              title: S.of(context).my_history,
              fetchData: ApiHandler.history,
              emptyStateString: S.of(context).there_is_no_media_history_yet,
              deleteData: ApiHandler.deleteHistory,
            ),
        'my_media': (_) => const MyMediaScreen(),
        'my_statistics': (_) => const MyStatistics(),
        'auth': (_) => const AuthScreen(),
        'post_scheduling': (_) => const PostScheduling(),
      };
}
