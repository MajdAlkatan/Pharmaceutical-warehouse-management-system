// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:our_web_app/generated/l10n.dart';
import 'package:our_web_app/pages/bills_page.dart';
import 'package:our_web_app/pages/home_page.dart';
import 'package:our_web_app/pages/login.dart';
import 'package:our_web_app/pages/putmidicen.dart';
import 'package:our_web_app/pages/reports_page.dart';
import 'package:our_web_app/pages/settings_page.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

bool isArabic() {
  return Intl.getCurrentLocale() == 'ar';
}

class LanguageProvider with ChangeNotifier {
  Locale _currentLocale = const Locale('en'); // Default locale is English

  Locale get currentLocale => _currentLocale;

  void changeLanguage(Locale newLocale) {
    _currentLocale = newLocale;
    notifyListeners();
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<LanguageProvider>(
            create: (_) => LanguageProvider(),
          ),
        ],
        child: Consumer<LanguageProvider>(
          builder: (context, languageProvider, _) {
            return MaterialApp(
              locale: languageProvider.currentLocale,
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              routes: {
                'HomePage': (context) => const HomePage(),
                // 'UsersPage': (context) => const UsersPage(),
                'SettingsPage': (context) => const SettingsPage(),
                'BillsPage': (context) => const BillsPage(),
                'ReportsPage': (context) => const ReportsPage(),
                'loginpage': (context) => const LogInPage(),
                // 'userdetails': (context) => UserDetails(),
                'putmidicen': (context) => const Putmidicen()
              },
              debugShowCheckedModeBanner: false,
              initialRoute: 'loginpage', //////
            );
          },
        ));
  }
}
