import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:htp_customer/htp_theme.dart';
import 'package:change_case/change_case.dart';

import 'needles_widget.dart';

const double electraBottomPadding = 24;
const double electraNeedleTopPadding = 28;

///Size of the text field
const double electraHeight = 54;

class TextFieldElectra extends StatefulWidget {
  final double height;
  final TextEditingController? controller;
  final FocusNode? focus;
  final String? Function(String?)? validator;
  final String? labelText;
  final String? hintText;
  final bool obscureText;
  // final bool dotedHint;
  final TextInputAction? textInputAction;
  final bool calenderIon;
  final bool readOnly;
  final VoidCallback? onTap;
  final EdgeInsets padding;
  final TextInputType? keyboardType;
  final Widget? prefixWidget;
  final EdgeInsets contentPadding;
  final List<TextInputFormatter>? inputFormatters;
  final AutovalidateMode autovalidateMode;
  final int? maxLength;

  const TextFieldElectra(
      {super.key,
      this.controller,
      this.focus,
      this.validator,
      this.labelText,
      this.hintText,
      this.obscureText = false,
      this.onTap,
      this.readOnly = false,
      this.padding = const EdgeInsets.only(bottom: electraBottomPadding),
      this.calenderIon = false,
      this.keyboardType,
      this.prefixWidget,
      this.textInputAction,
      this.height = electraHeight,
      this.contentPadding = const EdgeInsets.fromLTRB(8, 22, 8, 8),
        this.inputFormatters,
        this.autovalidateMode = AutovalidateMode.onUserInteraction,
        this.maxLength,

      // this.dotedHint = false
      });

  @override
  State<TextFieldElectra> createState() => _TextFieldElectraState();
}

class _TextFieldElectraState extends State<TextFieldElectra> {
  bool _isTextFieldActive = false;
  FocusNode _focus = FocusNode();

  bool _obscureText = true;

  activateField() {
    setState(() {
      _isTextFieldActive = true;
    });
  }

  deactivateField() {
    setState(() {
      _isTextFieldActive = false;
    });
  }

  @override
  void initState() {
    super.initState();

    if (widget.focus != null) {
      _focus = widget.focus!;
    }

    _focus.addListener(() {
      if (_focus.hasPrimaryFocus) {
        activateField();
      } else {
        deactivateField();
      }
    });
  }

  void _togglePassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.padding,
      child: Stack(
        // alignment: AlignmentDirectional.bottomCenter,
        alignment: AlignmentDirectional.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: electraNeedleTopPadding),
            child: NeedleDoubleSided(
              fullWidth: _isTextFieldActive,
            ),
          ),
          SizedBox(
            // height: widget.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.labelText != null
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Text(
                          widget.labelText!,
                          style: man12LightGrey,
                        ),
                      )
                    : const SizedBox(
                        height: 10,
                      ),
                SizedBox(
                  height: widget.height - 1,
                  child: TextFormField(
                    maxLength: widget.maxLength,
                    // style: const TextStyle(fontSize: 14),
                    autovalidateMode: widget.autovalidateMode,
                    maxLines: 1,
                    focusNode: _focus,
                    controller: widget.controller,
                    readOnly: widget.readOnly,
                    onTap: widget.onTap,
                    textCapitalization: TextCapitalization.sentences,
                    keyboardType: widget.keyboardType,
                    textInputAction: widget.textInputAction,
                    inputFormatters: widget.inputFormatters,
                    clipBehavior: Clip.none,
                    decoration: InputDecoration(
                      counter: const Offstage(),
                        isDense: true,
                        isCollapsed: true,
                        contentPadding: widget.contentPadding,
                        helperText: '',
                        border: InputBorder.none,
                        hintText: widget.hintText,
                        hintStyle: man14DarkGrey2,
                        // hintStyle: widget.dotedHint == true
                        //     ? const TextStyle(
                        //         fontSize: 30,
                        //         letterSpacing: -8,
                        //       )
                        //     : man14DarkGrey2,
                        prefixIcon: widget.prefixWidget,
                        suffixIcon: widget.obscureText == true
                            ? Padding(
                                padding: const EdgeInsets.only(bottom: 4.0),
                                child: GestureDetector(
                                  onTap: () => _togglePassword(),
                                  // child: Icon(!_obscureText
                                  //     ? Icons.visibility
                                  //     : Icons.visibility_off),
                                  child: !_obscureText
                                      ? SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: Center(
                                            child: SvgPicture.asset(
                                                'assets/images/icons/visibility_on.svg'),
                                          ),
                                        )
                                      : SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: Center(
                                            child: Image.asset(
                                              "assets/images/icons/visibility_off.png",
                                              scale: 3.5,
                                            ),
                                          ),
                                        ),
                                ),
                              )
                            : widget.calenderIon == true
                                ? GestureDetector(
                                    onTap: widget.onTap,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 6.0),
                                      child: Image.asset(
                                        "assets/images/icons/calendar.png",
                                        scale: 5,
                                        // scale: 3.5,
                                        // height: 1,
                                        // width: 1,
                                      ),
                                    ),
                                  )
                                : null),
                    validator: widget.validator,
                    obscureText: widget.obscureText == false
                        ? widget.obscureText
                        : _obscureText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _focus.dispose();
  }
}

class DropdownSearchElectra<T> extends StatelessWidget {
  final String Function(T)? itemAsString;
  final bool Function(T, String)? filterFn;
  final List<T> items;
  final Future<List<T>> Function(String)? asyncItem;
  final String? Function(T?)? validator;
  final void Function(T?)? onChanged;
  final String? hintText;
  final String? labelText;
  final double height;
  final EdgeInsets padding;
  final double betweenSpace;
  final bool activeHint;
  const DropdownSearchElectra(
      {super.key,
      this.itemAsString,
      this.filterFn,
      this.items = const [],
      this.asyncItem,
      this.validator,
      this.onChanged,
      this.hintText,
      this.labelText,
      this.height = electraHeight,
      this.activeHint = false,
      this.betweenSpace = 0,
      this.padding = const EdgeInsets.only(bottom: electraBottomPadding - 12)});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: padding,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: electraNeedleTopPadding + 8 + betweenSpace),
            child: const NeedleDoubleSided(),
          ),
          SizedBox(
            // height: height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (labelText != null)
                  Text(
                    labelText!,
                    style: man12LightGrey,
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: DropdownSearch<T>(
                    itemAsString: itemAsString,
                    filterFn: filterFn,
                    items: items,
                    asyncItems: asyncItem,
                    validator: validator,
                    dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          hintText: hintText?.toTitleCase(),
                          helperText: '',
                          hintStyle: activeHint
                              ? Theme.of(context).textTheme.bodyMedium
                              : null,
                          border: InputBorder.none,
                        ),
                        baseStyle: TextStyle(fontSize: 16)),
                    popupProps: const PopupProps.menu(
                        showSearchBox: true,
                        interceptCallBacks: true,
                        // isFilterOnline: true,
                        searchFieldProps: TextFieldProps(
                            decoration: InputDecoration(
                                hintText: 'Search', isDense: true))),
                    onChanged: onChanged,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DividerElectra extends StatelessWidget {
  const DividerElectra({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Expanded(
              child: NeedleHorizontal(
            flip: true,
          )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Text(
              'or',
              style: man12LightGrey,
            ),
          ),
          const Expanded(child: NeedleHorizontal()),
        ],
      ),
    );
  }
}
