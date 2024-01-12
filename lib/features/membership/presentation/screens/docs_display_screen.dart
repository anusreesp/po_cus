import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/common/widgets_common/app_bar_back_button.dart';
import 'package:htp_customer/common/widgets_common/rounded_golden_button.dart';
import 'package:htp_customer/features/membership/controller/kyc_submitted_data_controller.dart';
import 'package:htp_customer/htp_theme.dart';

class DocsDisplayScreen extends ConsumerWidget {
  const DocsDisplayScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(kycSubmittedDataProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('VIEW ID'),
        automaticallyImplyLeading: false,
        leading: const AppbarBackButton(),
      ),
      body: controller.when(
          data: (data){
            if(data != null){
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  SizedBox(
                    height: 234,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      children: [
                        _decoratedContainer(width: 190,
                            child: ClipOval(child: Image.network(data.userImage, fit: BoxFit.cover,))),

                        _decoratedContainer(width: null,
                            child: Image.network(data.govtIdFront, fit: BoxFit.contain,)),

                        if(data.govtIdBack != null)
                          _decoratedContainer(width: null,
                              child: Image.network(data.govtIdBack!, fit: BoxFit.contain,)),

                      ],
                    ),
                  ),

                  const Spacer(),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                    child: RoundedGoldenButton(onTap: (){
                      Navigator.pop(context);
                    }, text: 'Done'),
                  ),

                ],
              );
            }

            return const SizedBox.shrink();
          },
          error: (error, stack){
            return Center(child: Text(error.toString()),);
          },
          loading: () => const Center(child: const CircularProgressIndicator(color: HtpTheme.goldenColor),)),
    );


  }

  Widget _decoratedContainer({double height = 234, required double? width, Widget? child}){
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
          border: Border.all(color: HtpTheme.lightBlueColor, width: 2)
      ),
      child: child,
    );
  }

}
