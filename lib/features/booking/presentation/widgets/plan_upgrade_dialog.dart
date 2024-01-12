import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/features/dashboard/controllers/dashboard_controllers.dart';

import '../../../../common/widgets_common/rounded_golden_button.dart';

class PlanUpgradeDialog extends ConsumerWidget {
  const PlanUpgradeDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 16,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          // color: colorTheme.backgroundColor,
          // border: Border.all(color: Colors.yellow, width: 0.6)
        ),
        // height: 220.0,
        // width: 480.0,
        // child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              textAlign: TextAlign.center,
              'Upgrade your plan to proceed !',
              // style: Theme.of(context).textTheme.headline4,
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  SizedBox(
                    width: 125,
                    child: RoundedGoldenButton(
                        height: 44,
                        onTap: (){
                          // ref.read(dashboardProvider.notifier).selectTab(TabItem.membership);
                          Navigator.popUntil(context, (route) => route.isFirst);
                          // if(context.mounted){
                          //   Navigator.pop(context);
                          // }
                        }, text: 'UPGRADE'),
                  ),


                ],
              ),
            )
          ],
        ),
        // ),
      ),
    );
  }
}
