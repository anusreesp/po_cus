import 'package:flutter/material.dart';
import 'package:htp_customer/router.dart';
import 'package:htp_customer/splashscreen/splash_screen_new.dart';
import 'package:htp_customer/startup_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'htp_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Party One",
      theme: HtpTheme.dark(),
      navigatorKey: mainNavigatorKey,
      onGenerateRoute: RouteGenerator.generateRoute,
      // initialRoute: StartupPage.route,
      initialRoute: SplashScreenNew.route,
      routes: routesList,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      //Overriding font size
      builder: (context, child){
        return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: child!);
      },
    );
  }
}