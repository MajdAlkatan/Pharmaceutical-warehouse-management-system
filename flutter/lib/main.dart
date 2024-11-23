import 'package:app5/generated/l10n.dart';
import 'package:app5/screens/cartpage.dart';
import 'package:app5/screens/fav_page.dart';
import 'package:app5/screens/home_page.dart';
import 'package:app5/screens/login.dart';
import 'package:app5/screens/rigestre.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(const MyApp());
  // await initialServices();
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
        ChangeNotifierProvider<Cart>(create: (_) => Cart()),
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
              Home_page.id: (context) => Home_page(),
              LoginPage.id: (context) => LoginPage(),
              register.id: (context) => register(),
              favorite.id: (context) => const favorite(),
            },
            debugShowCheckedModeBanner: false,
            initialRoute: LoginPage.id,
          );
        },
      ),
    );
  }
}
