import 'package:evently/app_theme.dart';
import 'package:evently/auth/login_screen.dart';
import 'package:evently/auth/register_screen.dart';
import 'package:evently/eventScreens/create_event_screen.dart';
import 'package:evently/eventScreens/edit_event_screen.dart';
import 'package:evently/eventScreens/event_details.dart';
import 'package:evently/firebase_service.dart';
import 'package:evently/home_screen.dart';
import 'package:evently/intro_screens/intro_screen.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/models/user_model.dart';
import 'package:evently/providers/events_providers.dart';
import 'package:evently/providers/settings_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dotenv.load(fileName: ".env"); 
  SharedPreferences preferences = await SharedPreferences.getInstance();
  final hasSeenIntro = preferences.getBool('hasSeenIntro') ?? false;
  final savedUserId = await FirebaseService.getUserId();

  UserModel? user;

  if (savedUserId.isNotEmpty) {
    user = await FirebaseService.getUserById(savedUserId);
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()..updateCurrentUser(user)),
        ChangeNotifierProvider(create: (_) => EventsProviders()..getEvents()),
        ChangeNotifierProvider(
          create: (_) => SettingsProvider()..loadThemeAndLanguage(),
        ),
      ],
      child: EventlyApp(hasSeenIntro: hasSeenIntro, user: user),
    ),
  );
}

class EventlyApp extends StatelessWidget {
  final bool hasSeenIntro;
  final UserModel? user;
  const EventlyApp({
    super.key,
    required this.hasSeenIntro,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    SettingsProvider settingspProvider = Provider.of<SettingsProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        HomeScreen.routeName: (_) => HomeScreen(),
        IntroScreen.routeName: (_) => IntroScreen(),
        RegisterScreen.routeName: (_) => RegisterScreen(),
        LoginScreen.routeName: (_) => LoginScreen(),
        CreateEventScreen.routeName: (_) => CreateEventScreen(),
        EventDetails.routeName: (_) => EventDetails(),
        EditEventScreen.routeName: (_) => EditEventScreen(),
      },
      initialRoute: hasSeenIntro
          ? (user == null)
                ? LoginScreen.routeName
                : HomeScreen.routeName
          : IntroScreen.routeName,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: settingspProvider.themeMode,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(settingspProvider.languageCode),
    );
  }
}
