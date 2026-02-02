import 'package:evently/app_theme.dart';
import 'package:evently/auth/login_screen.dart';
import 'package:evently/auth/register_screen.dart';
import 'package:evently/eventScreens/create_event_screen.dart';
import 'package:evently/eventScreens/edit_event_screen.dart';
import 'package:evently/eventScreens/event_details.dart';
import 'package:evently/home_screen.dart';
import 'package:evently/intro_screens/intro_screen.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  final hasSeenIntro = preferences.getBool('hasSeenIntro') ?? false;
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (_) => UserProvider(),
      child: EventlyApp(hasSeenIntro: hasSeenIntro),
    ),
  );
}

class EventlyApp extends StatelessWidget {
  final bool hasSeenIntro;
  const EventlyApp({super.key, required this.hasSeenIntro});

  @override
  Widget build(BuildContext context) {
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
          ? LoginScreen.routeName
          : IntroScreen.routeName,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
    );
  }
}
