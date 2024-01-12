import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/common/widgets_common/app_bar_back_button.dart';
import 'package:htp_customer/common/widgets_common/outlined_black_button.dart';
import 'package:htp_customer/common/widgets_common/rounded_golden_button.dart';
import 'package:htp_customer/features/membership/controller/kyc_submitted_data_controller.dart';
import 'package:htp_customer/features/membership/controller/membership_form_index.dart';
import 'package:htp_customer/features/membership/data/model/kyc_requested_data.dart';
import 'package:htp_customer/features/membership/data/services/membership_services.dart';
import 'package:htp_customer/features/membership/presentation/screens/basic_details_form.dart';
import 'package:htp_customer/features/membership/presentation/screens/file_uploads.dart';
import 'package:htp_customer/features/membership/presentation/screens/membership_confirmation_page.dart';

import '../../../../authentication/data/service/firebase_auth_service.dart';
import '../../../../htp_theme.dart';

class MembershipFormMain extends ConsumerWidget {
  static const route = '/membership-form-main';
  const MembershipFormMain({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabController = ref.watch(membershipFormIndexProvider);
    final kyc = ref.watch(kycSubmittedDataProvider);
    return WillPopScope(
      onWillPop: ()async{
        _showCloseConfirmation(context, ref);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('MEMBERSHIP'),
          leading: AppbarBackButton(onTap: (){
            _showCloseConfirmation(context, ref);
          },),
          automaticallyImplyLeading: false,
        ),
        body: kyc.when(
            data: (KycRequestedData? data){
              final bool kycCompleted = data?.status == 'Approved' || data?.status == 'Pending';
              if(kycCompleted){
                return const MembershipConfirmationPage();
              }

              return Column(
                children: [
                  const SizedBox(height: 18,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        _tabButton(true, 'MORE DETAILS'),

                        _tabButton(
                            tabController == MembershipTab.idVerification
                                || tabController == MembershipTab.membership,
                            'ID VERIFICATION'),

                        _tabButton(tabController == MembershipTab.membership, 'GET MEMBERSHIP'),
                      ],
                    ),
                  ),

                  const SizedBox(height: 18,),

                  Expanded(
                      child: IndexedStack(
                        index: tabController.index,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: BasicDetailsForm(oldRequest: data,),
                          ),

                          const FileUploads(),

                          const MembershipConfirmationPage()
                        ],
                      ))

                ],
              );
            },
            error: (error, stack){
              return Center(child: Text(error.toString()),);
            },
            loading: (){
              return const Center(child: const CircularProgressIndicator(color: HtpTheme.goldenColor),);
            }),
      ),
    );
  }

  Widget _tabButton(bool active, String title){
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 1,
            margin: const EdgeInsets.only(right: 6, bottom: 4),
            color: active ? HtpTheme.goldenColor : HtpTheme.lightBlueColor,
            width: double.infinity,
          ),
          Text(title, style: man10Gold2.apply(color: !active ? HtpTheme.lightBlueColor : null),)
        ],
      ),
    );
  }

  _showCloseConfirmation(BuildContext context, WidgetRef ref){
    showModalBottomSheet(context: context, builder: (context){
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Cancel Request?', style: man22White,),

            const Padding(
              padding: EdgeInsets.only(top: 22.0, bottom: 32),
              child: Text('You will lose your data if you go back', style: man14LightGrey,),
            ),

            Row(
              children: [
                Expanded(child: OutlinedBlackButton(onTap: (){
                  Navigator.pop(context);
                }, text: 'Stay',)),
                const SizedBox(width: 16,),
                Expanded(child: RoundedGoldenButton(onTap: (){
                  // Navigator.popUntil(context, (route) => route.isFirst);
                  Navigator.pop(context);
                  Navigator.pop(context);

                  // final uid = ref.read(firebaseAuthServiceProvider).uid;
                  // ref.read(membershipServiceProvider).sendPromotionNotification(uid, 'buy-plan');

                }, text: 'Go back'))
              ],
            ),
            const SizedBox(height: 22,)
          ],
        ),
      );
    });
  }

}