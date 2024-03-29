import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/app_config.dart';
import 'package:htp_customer/common/controllers/branch_controller.dart';
import 'package:htp_customer/shared_prefs_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options_dev.dart';
import 'my_app.dart';


//Flavor ref: https://sebastien-arbogast.com/2022/05/02/multi-environment-flutter-projects-with-flavors/

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'new',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // FlutterBranchSdk.validateSDKIntegration();

  //Crashlytics
  FlutterError.onError = (errorDetails){
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  PlatformDispatcher.instance.onError = (error, stack){
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  final sPrefs = await SharedPreferences.getInstance();
  const configuration = AppConfig(
      environment: AppEnvironment.dev,
      baseUrl: 'https://staging-api.party.one');

  final container = ProviderContainer(
      overrides: [
        sharedPrefsProvider.overrideWithValue(sPrefs),
        appConfigProvider.overrideWithValue(configuration)
      ]
  );
  container.read(branchProvider);


  runApp(UncontrolledProviderScope(
      container: container,
      child: const MyApp()));
}


