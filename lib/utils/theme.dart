import 'package:flutter/material.dart';

class ThemeBuilder {
  const ThemeBuilder._();

  static const seed = Color(0xFF0D0F45);

  static const _lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF5156A9),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFE0E0FF),
    onPrimaryContainer: Color(0xFF070764),
    secondary: Color(0xFF5D5D72),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFE1E0F9),
    onSecondaryContainer: Color(0xFF191A2C),
    tertiary: Color(0xFF78536A),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFFFD7EE),
    onTertiaryContainer: Color(0xFF2E1125),
    error: Color(0xFFBA1B1B),
    errorContainer: Color(0xFFFFDAD4),
    onError: Color(0xFFFFFFFF),
    onErrorContainer: Color(0xFF410001),
    background: Color(0xFFFFFBFF),
    onBackground: Color(0xFF1B1B1F),
    surface: Color(0xFFFFFBFF),
    onSurface: Color(0xFF1B1B1F),
    surfaceVariant: Color(0xFFE4E1EC),
    onSurfaceVariant: Color(0xFF46464F),
    outline: Color(0xFF777680),
    onInverseSurface: Color(0xFFF3EFF4),
    inverseSurface: Color(0xFF313034),
    inversePrimary: Color(0xFFBEC2FF),
    shadow: Color(0xFF000000),
  );

  static const _darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFFBEC2FF),
    onPrimary: Color(0xFF212478),
    primaryContainer: Color(0xFF393D8F),
    onPrimaryContainer: Color(0xFFE0E0FF),
    secondary: Color(0xFFC5C4DD),
    onSecondary: Color(0xFF2E2F42),
    secondaryContainer: Color(0xFF444559),
    onSecondaryContainer: Color(0xFFE1E0F9),
    tertiary: Color(0xFFE8B9D4),
    onTertiary: Color(0xFF46263B),
    tertiaryContainer: Color(0xFF5F3C52),
    onTertiaryContainer: Color(0xFFFFD7EE),
    error: Color(0xFFFFB4A9),
    errorContainer: Color(0xFF930006),
    onError: Color(0xFF680003),
    onErrorContainer: Color(0xFFFFDAD4),
    background: Color(0xFF1B1B1F),
    onBackground: Color(0xFFE4E1E6),
    surface: Color(0xFF1B1B1F),
    onSurface: Color(0xFFE4E1E6),
    surfaceVariant: Color(0xFF46464F),
    onSurfaceVariant: Color(0xFFC7C5D0),
    outline: Color(0xFF918F99),
    onInverseSurface: Color(0xFF1B1B1F),
    inverseSurface: Color(0xFFE4E1E6),
    inversePrimary: Color(0xFF5156A9),
    shadow: Color(0xFF000000),
  );

  static ThemeData get lightTheme =>
      ThemeData.from(colorScheme: _lightColorScheme).adapt;
  static ThemeData get darkTheme =>
      ThemeData.from(colorScheme: _darkColorScheme).adapt;
}

extension Adapter on ThemeData {
  ThemeData get adapt => copyWith(
        pageTransitionsTheme: PageTransitionsTheme(
          builders: Map<TargetPlatform, PageTransitionsBuilder>.fromEntries(
            TargetPlatform.values
                .map(
                    (e) => MapEntry(e, const CupertinoPageTransitionsBuilder()))
                .toList(),
          ),
        ),
        appBarTheme: AppBarTheme(
          elevation: 10,
          backgroundColor:
              brightness == Brightness.dark ? null : const Color(0xffE3E3BB),
          centerTitle: true,
          iconTheme: IconThemeData(
            color: brightness == Brightness.dark
                ? colorScheme.onBackground
                : const Color(0xFF070764),
          ),
          titleTextStyle: TextStyle(
            color: brightness == Brightness.dark
                ? colorScheme.onBackground
                : const Color(0xFF070764),
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.15,
          ),
        ),
        tabBarTheme: TabBarTheme(
          labelColor: brightness == Brightness.dark
              ? colorScheme.onBackground
              : const Color(0xFF070764),
          indicator: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: brightness == Brightness.dark
                    ? colorScheme.onBackground
                    : const Color(0xFF070764),
                width: 1.2,
              ),
            ),
          ),
        ),
      );
}
