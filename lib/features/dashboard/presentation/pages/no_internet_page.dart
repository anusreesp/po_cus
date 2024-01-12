import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:htp_customer/common/controllers/connectivity_controller.dart';
import 'package:htp_customer/features/clubs/presentation/widgets/new/floatingButtons.dart';
import 'package:htp_customer/htp_theme.dart';

class NoInternetPage extends ConsumerWidget {
  const NoInternetPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectivity = ref.watch(connectivityProvider);

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.18,
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: SvgPicture.asset(
                'assets/svg/images/exception/no_connection.svg',
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  'Oops, No Internet Connection',
                  style: tenor26White.merge(
                      const TextStyle(letterSpacing: -1.7, wordSpacing: -2.6)),
                  textAlign: TextAlign.center,
                )),
            const SizedBox(
              height: 24,
            ),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 52),
                child: const Text(
                  'No internet connection was found. Check your connection or try again.',
                  textAlign: TextAlign.center,
                  style: man14LightBlue,
                )),
            const SizedBox(
              height: 32,
            ),
            if (connectivity is ConnectivityLoading)
              const CircularProgressIndicator(color: HtpTheme.goldenColor),
            if (connectivity is ConnectivityNone)
              FloatingBlackButton(
                  onTap: () {
                    ref.read(connectivityProvider.notifier).init();
                  },
                  text: 'Try again')
          ],
        ),
      ),
    );
  }
}
