import 'package:flutter/material.dart';
import 'package:htp_customer/common/widgets_common/custom_radio.dart';
import 'package:htp_customer/common/widgets_common/text_field_electra.dart';
import 'package:htp_customer/features/booking/presentation/widgets/new/guest_details_box.dart';

import '../../../../../htp_theme.dart';
import '../../../data/models/guest_model.dart';

///This widget creates a dynamic form to add guest
class AddingPeopleForm extends StatelessWidget {
  final List<GuestEditModel> editGuestList;
  final VoidCallback onAddGuestClick;
  final Function(String) onDeleteItem;
  final GlobalKey<FormState> formKey;
  const AddingPeopleForm(
      {super.key,
      required this.editGuestList,
      required this.onAddGuestClick,
      required this.onDeleteItem,
      required this.formKey});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Column(
          children: [
            for (int i = 0; i < editGuestList.length; i++)
              _PeopleForm(
                key: Key('${i + 1}'),
                count: i + 1,
                id: editGuestList[i].id,
                ageController: editGuestList[i].ageController,
                nameController: editGuestList[i].nameController,
                onGenderSelection: (gender) {
                  editGuestList[i].gender = gender;
                },
                onDeleteClick: onDeleteItem,
                gender: editGuestList[i].gender,
              ),
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: AddMoreGuestsWidget(
                //Add more guest button --------
                onTap: () {
                  // _addMoreGuest();
                  onAddGuestClick();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _PeopleForm extends StatefulWidget {
  final int count;
  final TextEditingController nameController;
  final TextEditingController ageController;
  final String id;
  final Function(String) onGenderSelection;
  // bool showError;
  final Function(String) onDeleteClick;
  final String? gender;
  _PeopleForm(
      {Key? key,
      required this.count,
      required this.id,
      required this.ageController,
      required this.nameController,
      required this.onGenderSelection,
      required this.onDeleteClick,
      required this.gender
      // this.showError = false
      })
      : super(key: key);

  @override
  State<_PeopleForm> createState() => _PeopleFormState();
}

class _PeopleFormState extends State<_PeopleForm> {
  final _genderList = ['Male', 'Female', 'Rather not say'];
  String? _selectedGender;

  FocusNode? focusName;
  FocusNode? focusAge;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _selectedGender = widget.gender;
      setState(() {});
    });
  }

  @override
  void didUpdateWidget(covariant _PeopleForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    _selectedGender = widget.gender;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print(
        'Gender from constructor: ${widget.gender} -- NAME: ${widget.nameController.text}');
    print(_selectedGender);
    return Container(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: const BoxDecoration(
          color: HtpTheme.darkBlue2Color,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Guest ${widget.count}",
                  // "Add Guest",
                  style: man14White,
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      widget.onDeleteClick(widget.id);
                    },
                    icon: const Icon(Icons.remove_circle,
                        color: HtpTheme.lightBlueColor))
              ],
            ),
            const SizedBox(
              height: 6,
            ),
            TextFieldElectra(
              controller: widget.nameController,
              focus: focusName,
              maxLength: 36,
              textInputAction: TextInputAction.next,
              padding: const EdgeInsets.all(0),
              // validator: (value) {
              //   if (value == null || value.isEmpty) {
              //     return 'Name required';
              //   }
              //   return null;
              // },
              hintText: "Guest name ( Optional )",
            ),

            // TextFormField(
            //   keyboardType: TextInputType.number,
            //   textInputAction: TextInputAction.done,
            //   onFieldSubmitted: (value) {
            //     //
            //   },
            //   controller: widget.ageController,
            //   validator: (value) {
            //     if (value == null || value.isEmpty) {
            //       return 'Age required';
            //     } else {
            //       final age = int.tryParse(value);
            //       if (age == null) {
            //         return 'Enter a valid age';
            //       } else {
            //         if (age >= 21 && age < 100) {
            //           return null;
            //         } else {
            //           return 'Age should be above 21 and below 100.';
            //         }
            //       }
            //     }
            //     return null;
            //   },
            //   decoration: const InputDecoration(
            //     hintText: "Age",
            //     hintStyle: man14LightGrey,
            //     enabledBorder: UnderlineInputBorder(
            //         borderSide: BorderSide(color: HtpTheme.darkBlue2Color)),
            //     focusedBorder: UnderlineInputBorder(
            //         borderSide: BorderSide(color: HtpTheme.darkBlue2Color)),
            //   ),
            // ),
            // NeedleDoubleSided(),

            TextFieldElectra(
              controller: widget.ageController,
              focus: focusAge,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              padding: const EdgeInsets.all(0),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '*This field is mandatory';
                } else {
                  final age = int.tryParse(value);
                  if (age == null) {
                    return 'Enter a valid age';
                  } else {
                    if (age >= 21 && age < 100) {
                      return null;
                    } else {
                      return 'Age should be 21 and above.';
                    }
                  }
                }
                return null;
              },
              hintText: "Age",
            ),

            const Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 12),
              child: Text(
                'Gender',
                style: man14LightGrey,
              ),
            ),
            Wrap(
              spacing: 16,
              runSpacing: 12,
              children: [
                ..._genderList.map(
                  (e) => RadioWithTitle(
                      // selected: e == (widget.gender ?? _selectedGender),
                      selected: e == _selectedGender,
                      onTap: (val) {
                        setState(() {
                          _selectedGender = e;
                          widget.onGenderSelection(e);
                          // widget.showError = false;
                        });
                      },
                      title: e),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ));
  }
}
