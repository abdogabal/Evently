import 'package:easy_localization/easy_localization.dart';
import 'package:evently/Core/PrefsManager.dart';
import 'package:evently/Core/resources/AppStyle.dart';
import 'package:evently/Providers/MapsProvider.dart';
import 'package:evently/Providers/ThemeProvider.dart';
import 'package:evently/Providers/UserProvider.dart';
import 'package:evently/UI/ForgetPass/Screens/ForgetPass_Screen.dart';
import 'package:evently/UI/Home/Screens/HomeScreen.dart';
import 'package:evently/UI/Register/Screens/Register_Screen.dart';
import 'package:evently/UI/splash/screen/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'UI/CreateEvent/Screen/CreateEventScreen.dart';
import 'UI/Login/Screens/Login_Screen.dart';
import 'UI/Onboarding/Screens/Onboarding_Screens.dart';
import 'UI/Start/Screen/Start_Screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await PrefsManager.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      saveLocale: true,
      startLocale: Locale('en'),
      fallbackLocale: Locale('en'),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ThemeProviders()..init(),),
          ChangeNotifierProvider(create: (context) => UserProvider(),),
          ChangeNotifierProvider(create: (context) => MapsProvider(),

          )
        ],
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ThemeProviders provider = Provider.of<ThemeProviders>(context);
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: AppStyle.lightTheme,
      themeMode: provider.themeMode,
      darkTheme: AppStyle.darkTheme,
      debugShowCheckedModeBanner: false,
      routes: {
        SplashScreen.routeName: (_) => SplashScreen(),
        StartScreen.routeName: (_) => StartScreen(),
        RegisterScreen.routeName: (_) => RegisterScreen(),
        LoginScreen.routeName: (_) => LoginScreen(),
        ForgetPassScreen.routeName: (_) => ForgetPassScreen(),
        OnboardingScreen.routeName: (_) => OnboardingScreen(),
        HomeScreen.routeName: (_) => HomeScreen(),
        CreateEventScreen.routeName: (_) => CreateEventScreen(),
      },
      initialRoute:SplashScreen.routeName
    );
  }
}
