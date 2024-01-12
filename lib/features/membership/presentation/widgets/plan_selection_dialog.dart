import 'package:flutter/material.dart';

import '../../../../common/widgets_common/rounded_golden_button.dart';
import '../../../../htp_theme.dart';
import '../../data/model/membership_response.dart';

class PlanSelectionDialog extends StatefulWidget {
  final List<Plan> plans;
  final Function(Plan) onPlanConfirmation;
  const PlanSelectionDialog({super.key, required this.plans, required this.onPlanConfirmation});

  @override
  State<PlanSelectionDialog> createState() => _PlanSelectionDialogState();
}

class _PlanSelectionDialogState extends State<PlanSelectionDialog> {
  final ValueNotifier<String?> _selectedPlanId = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(valueListenable: _selectedPlanId, builder: (context, selectedId, _){
      return Container(
        color: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 12),
              child: Text('Choose a plan ', style: tenor22White,),
            ),

            ...widget.plans.map((e) => GestureDetector(
              onTap: (){
                _selectedPlanId.value = e.planUniqueId;
              },
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: selectedId == e.planUniqueId
                        ? HtpTheme.goldenColor
                        : HtpTheme.lightBlueColor),
                    borderRadius: BorderRadius.circular(8)),
                margin: const EdgeInsets.symmetric(vertical: 12),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                width: double.infinity,
                child: Row(children: [
                  Text(e.planDescription),
                  const Spacer(),
                  if(selectedId == e.planUniqueId)
                  const Icon(
                    Icons.check_circle,
                    color: HtpTheme.goldenColor,
                    size: 18,
                  ),
                ],),
              ),
            ),),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: RoundedGoldenButton(
                  isActive: selectedId != null,
                  onTap: (){
                    if(selectedId != null){
                      final plan = widget.plans.firstWhere((element) => element.planUniqueId == selectedId);
                      widget.onPlanConfirmation(plan);
                      Navigator.of(context).pop();
                    }
                  }, text: 'Continue'),
            ),

            const SizedBox(height: 22,)
          ],
        ),
      );
    });
  }
}
