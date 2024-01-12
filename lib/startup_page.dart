import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/authentication/controllers/auth_controller.dart';
import 'package:htp_customer/authentication/presentation/screens/loading_splash.dart';
import 'package:htp_customer/authentication/presentation/screens/new/signup.dart';

import 'package:htp_customer/authentication/presentation/screens/numberverification.dart';
import 'package:htp_customer/common/controllers/connectivity_controller.dart';
import 'package:htp_customer/features/dashboard/presentation/pages/no_internet_page.dart';
import 'package:htp_customer/features/profile/presentation/changepassword.dart';
import 'package:htp_customer/splashscreen/introscreens/intro_screen.dart';

import 'package:htp_customer/splashscreen/splash_screen_new.dart';

import 'authentication/presentation/screens/login.dart';
import 'features/dashboard/presentation/pages/dashboard.dart';
import 'htp_theme.dart';

class StartupPage extends ConsumerWidget {
  static const route = '/';
  const StartupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectivity = ref.watch(connectivityProvider);
    final authController = ref.watch(authProvider);
    // ref.listen(connectivityProvider, (previous, next) {
    //   if(next is ConnectivityNone){
    //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No internet connection')));
    //   }
    // });

    ref.listen(authProvider, (previous, next) {
      if (next is AuthErrorState) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(next.msg)));
      }
    });

    if (connectivity is ConnectivityNone) {
      return const NoInternetPage();
    }

    if (authController is AuthLoggedInState) {
      return Dashboard();
    }

    if (authController is AuthLoadingState ||
        connectivity is ConnectivityLoading) {
      return const LoadingSplash();
    }

    if (authController is LoggedInWithoutData) {
      return NumberVerification(
        isSocialReg: true,
        name: authController.name,
        email: authController.email,
      );
    }

    // if(authController is LoggedInWithoutData){
    //   return SignupPage(mobile: 'Mobile need here', isLoggedIn: true,);
    // }

    // if(authController is AuthLoadingState){
    //   return _loader();
    // }
    if (authController is AuthOnboard) {
      // return const SplashScreenNew();
      return const IntroScreen();
    }

    return LoginPage();
    // return NumberVerifyTest();

    // return NumberVerification(
    //   isSocialReg: true,
    //   name: 'anusree',
    //   email: 'anusree@gmail.com',
    // );
    // return SignUpPage(
    //   isSocialReg: false,
    //   mobile: '+919496795400',
    // );

    // return OtpVerification();
    // final authStateChanges = ref.watch(authStateChangeProvider);
    // return authStateChanges.when(data: (user) {
    //   if (user != null) {
    //
    //     print(user.email);
    //     return Dashboard();
    //     // return LoginPage();
    //   } else {
    //     // return SplashScreenPage();
    //     return LoginPage();
    //   }
    // }, error: (error, _) {
    //   return Scaffold(
    //     body: Center(
    //       child: Text(error.toString()),
    //     ),
    //   );
    // }, loading: () {
    //   return _loader();
    // });
  }

  Widget _loader() {
    return const Scaffold(
      body: Center(
        child: const CircularProgressIndicator(color: HtpTheme.goldenColor),
      ),
    );
  }
}
