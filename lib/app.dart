import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/localization/locale_provider.dart';
import 'features/splash/splash_screen.dart';
import 'features/language/language_selection_screen.dart';
import 'features/onboarding/onboarding_screen.dart';
import 'features/auth/presentation/auth_screen.dart';
import 'features/shell/main_shell.dart';

/// MauriIn App — Root widget managing the entire app flow.
///
/// Flow: Splash → Language Selection → Onboarding → Auth → Main Shell
class MauriInApp extends ConsumerStatefulWidget {
  const MauriInApp({super.key});

  @override
  ConsumerState<MauriInApp> createState() => _MauriInAppState();
}

class _MauriInAppState extends ConsumerState<MauriInApp> {
  _AppScreen _screen = _AppScreen.splash;

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);

    return MaterialApp(
      title: 'MauriIn',
      debugShowCheckedModeBanner: false,

      // ── Theme ──
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,

      // ── Locale ──
      locale: locale,
      supportedLocales: supportedLocales,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      // ── Home (flow controller) ──
      home: _buildCurrentScreen(locale),
    );
  }

  Widget _buildCurrentScreen(Locale? locale) {
    switch (_screen) {
      case _AppScreen.splash:
        return SplashScreen(
          onComplete: () {
            setState(() {
              // If user already has a language set, skip to onboarding/main
              final hasLocale =
                  ref.read(localeProvider.notifier).hasSelectedLanguage;
              _screen = hasLocale
                  ? _AppScreen.onboarding
                  : _AppScreen.languageSelection;
            });
          },
        );

      case _AppScreen.languageSelection:
        return LanguageSelectionScreen(
          onLanguageSelected: () {
            setState(() => _screen = _AppScreen.onboarding);
          },
        );

      case _AppScreen.onboarding:
        return OnboardingScreen(
          onComplete: () {
            setState(() => _screen = _AppScreen.auth);
          },
        );

      case _AppScreen.auth:
        return AuthScreen(
          onGuestBrowse: () {
            setState(() => _screen = _AppScreen.main);
          },
        );

      case _AppScreen.main:
        return const MainShell();
    }
  }
}

enum _AppScreen {
  splash,
  languageSelection,
  onboarding,
  auth,
  main,
}
