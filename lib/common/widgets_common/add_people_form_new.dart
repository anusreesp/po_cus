import 'package:flutter/material.dart';
import 'package:htp_customer/common/widgets_common/custom_radio.dart';
import 'package:htp_customer/common/widgets_common/text_field_electra.dart';

import '../../features/booking/data/models/guest_model.dart';
import '../../features/booking/presentation/widgets/guest_detail_box.dart';
import '../../htp_theme.dart';

///This widget creates a dynamic form to add guest
class AddingPeopleNew extends StatelessWidget {
  final List<GuestEditModel> editGuestList;
  final VoidCallback onAddGuestClick;
  final Function(String) onDeleteItem;
  final GlobalKey<FormState> formKey;
  const AddingPeopleNew(
      {super.key,
      required this.editGuestList,
      required this.onAddGuestClick,
      required this.onDeleteItem,
      required this.formKey});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
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
            child: AddMoreGuests(
              //Add more guest button --------
              onTap: () {
                // _addMoreGuest();
                onAddGuestClick();
              },
            ),
          )
        ],
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _selectedGender = widget.gender;
      setState(() {});
    });
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
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w600),
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

            // TextFormField(
            //   controller: widget.nameController,
            //   textInputAction: TextInputAction.next,
            //   validator: (value) {
            //     if (value == null || value.isEmpty) {
            //       return 'Name required';
            //     }
            //     return null;
            //   },
            //   decoration: const InputDecoration(
            //     hintText: "Enter guest name",
            //     hintStyle: TextStyle(
            //       fontSize: 14,
            //       color: Color.fromARGB(255, 170, 170, 170),
            //     ),
            //     enabledBorder: UnderlineInputBorder(
            //         borderSide:
            //             BorderSide(color: Color.fromARGB(255, 233, 233, 233))),
            //   ),
            // ),

            TextFieldElectra(
              controller: widget.nameController,
              textInputAction: TextInputAction.next,
              maxLength: 36,
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
            //     hintText: "Enter age",
            //     hintStyle: TextStyle(
            //       fontSize: 14,
            //       color: Color.fromARGB(255, 170, 170, 170),
            //     ),
            //     enabledBorder: UnderlineInputBorder(
            //         borderSide:
            //             BorderSide(color: Color.fromARGB(255, 233, 233, 233))),
            //   ),
            // ),

            TextFieldElectra(
              controller: widget.ageController,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
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
              padding: EdgeInsets.only(bottom: 12),
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
                        // print(e == (widget.gender ?? _selectedGender));
                        // print(widget.gender);
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

            // if(widget.showError)
            //    const Padding(
            //       padding: EdgeInsets.symmetric(vertical: 8.0),
            //       child: Text('Select gender!', style: TextStyle(color: Colors.red),),
            //     ),

            // Align(
            //   alignment: Alignment.bottomRight,
            //   child: TextButton(onPressed: (){
            //     final guestData = _savePeople();
            //
            //   }, child: const Text('Done', style: TextStyle(color: Color(0xffE0B825)),)),
            // ),

            const SizedBox(
              height: 20,
            ),
          ],
        ));
  }

  // GuestModel? _savePeople(){
  //    if(_formKey.currentState!.validate()){
  //      if(_selectedGender == null){
  //        setState(() {
  //          _showError = true;
  //        });
  //        return null;
  //      }else{
  //        return GuestModel(widget.nameController.text, widget.ageController.text, widget.id, _selectedGender!);
  //      }
  //    }
  //    return null;
  //  }
}
