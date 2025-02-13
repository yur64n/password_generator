import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:password_generator/generated/l10n.dart';
import 'package:password_generator/homepage.dart';
import 'package:password_generator/saved_passwords.dart';
import 'package:password_generator/hive.adapter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(SavedPasswordAdapter());
  await Hive.openBox<SavedPassword>('passwords');
  var languageBox = await Hive.openBox('settings');
  String savedLocale = languageBox.get('locale', defaultValue: 'en'); 
  runApp(PasswordGeneratorApp(savedLocale: savedLocale));
}

class PasswordGeneratorApp extends StatefulWidget {
  final String savedLocale;
  const PasswordGeneratorApp({super.key, required this.savedLocale});
  @override
  PasswordGeneratorAppState createState() => PasswordGeneratorAppState();
}

class PasswordGeneratorAppState extends State<PasswordGeneratorApp> {
  late Locale _locale;

  @override
  void initState() {
    super.initState();
    _locale = Locale(widget.savedLocale); 
  }

  void _changeLanguage() async {
    final newLocale = (_locale.languageCode == 'en') ? 'uk' : 'en';
    var languageBox = await Hive.openBox('settings');
    await languageBox.put('locale', newLocale); 

    setState(() {
      _locale = Locale(newLocale); 
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      locale: _locale, 
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: const [
        Locale('en', ''), 
        Locale('uk', ''), 
      ],
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      
      initialRoute: '/homepage',
      routes: {
        '/homepage': (context) => PasswordGeneratorPage(onLocaleChange: _changeLanguage),
        '/saved': (context) => const SavedPasswordsPage(),
      },
    );
  }
}
