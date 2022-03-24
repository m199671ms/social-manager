import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:social_manager/generated/l10n.dart';
import 'package:social_manager/utils/api_handler.dart';
import 'package:social_manager/utils/helper.dart';
import 'package:social_manager/utils/routes.dart';
import 'package:social_manager/utils/store.dart';
import 'package:social_manager/utils/theme.dart';
import 'live.dart' as live;

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);

  var swAvailable = await AndroidWebViewFeature.isFeatureSupported(
    AndroidWebViewFeature.SERVICE_WORKER_BASIC_USAGE,
  );
  var swInterceptAvailable = await AndroidWebViewFeature.isFeatureSupported(
      AndroidWebViewFeature.SERVICE_WORKER_SHOULD_INTERCEPT_REQUEST);

  if (swAvailable && swInterceptAvailable) {
    AndroidServiceWorkerController serviceWorkerController =
        AndroidServiceWorkerController.instance();

    serviceWorkerController.serviceWorkerClient = AndroidServiceWorkerClient(
      shouldInterceptRequest: (request) async {
        return null;
      },
    );
  }
  await Store.init();
  ApiHandler.init();
  await Helper.init();
  // return live.main();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Store.listenToSettings(),
      builder: (_, __, ___) => MaterialApp(
        navigatorKey: navigatorKey,
        title: 'Social Manager',
        debugShowCheckedModeBanner: false,
        theme: ThemeBuilder.lightTheme,
        darkTheme: ThemeBuilder.darkTheme,
        builder: (_, child) => ScrollConfiguration(
          behavior: const CupertinoScrollBehavior(),
          child: SizedBox(
            child: child,
          ),
        ),
        // themeMode: ThemeMode.light,
        locale: Store.locale,
        themeMode: Store.theme,
        onGenerateRoute: Routes.onGenerateRoute,
        initialRoute: 'splash',
        supportedLocales: S.delegate.supportedLocales,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
      ),
    );
  }
}
