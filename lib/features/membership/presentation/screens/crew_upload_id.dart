import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:htp_customer/features/membership/data/model/membership_response.dart';
import 'package:htp_customer/networking/http_client.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../common/widgets_common/outlined_black_button.dart';
import '../../../../common/widgets_common/rounded_golden_button.dart';
import '../../../../common/widgets_common/text_field_electra.dart';
import '../../../../htp_theme.dart';
import '../../../idverification/presentation/pages/docs/img_capture.dart';
import '../../controller/id_verification_screen_control.dart';
import '../../controller/membership_application_controller.dart';
import '../widgets/plan_selection_dialog.dart';
import 'confirmation_display_page.dart';

class CrewUploadId extends StatefulWidget {
  final MembershipData data;
  const CrewUploadId({super.key, required this.data});

  @override
  State<CrewUploadId> createState() => _CrewUploadIdState();
}

class _CrewUploadIdState extends State<CrewUploadId> {
  XFile? _capturedImage;

  String? _frontIdUrl;
  String? _backIdUrl;

  bool uploadingImage = false;

  /// If front id uploaded means the url is received
  bool get frontIdUploaded => _frontIdUrl != null;

  bool get captureState => _capturedImage == null;

  //both id and url is null --- initial state

  Future<void> uploadImage() async {
    setState(() {
      uploadingImage = true;
    });

    try {
      if (!frontIdUploaded) {
        // await Future.delayed(const Duration(seconds: 1));
        _frontIdUrl = await NetworkClient().uploadFile(_capturedImage!.path);
        setState(() {
          _capturedImage = null;
          uploadingImage = false;
        });
      } else {
        _backIdUrl = await NetworkClient().uploadFile(_capturedImage!.path);
        setState(() {
          _capturedImage = null;
          uploadingImage = false;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      setState(() {
        uploadingImage = false;
      });
    }
  }

  captureId() async {
    _capturedImage = await takePicture();
    setState(() {});
  }

  Future<XFile?> takePicture() async {
    try {
      XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
      debugPrint("FILE: $file");
      return file;
    } catch (_) {
      rethrow;
    }
  }

  final frontIdPlaceholder =
      'assets/svg/icons/membership/uploadfront_image.svg';
  final backIdPlaceholder = 'assets/svg/icons/membership/upload_back.svg';

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final requestController = ref.watch(membershipApplicationProvider);

      ref.listen(membershipApplicationProvider, (previous, next) {
        if (next is MAErrorState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(next.msg)));
        }

        if (next is MASubmitState) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => const ConfirmationDisplayPage()),
              (route) => route.isFirst);
        }
      });

      return Column(
        children: [
          const SizedBox(
            height: 18,
          ),

          SizedBox(
            width: double.infinity,
            height: 240,
            // color: HtpTheme.lightBlueColor,
            child: _capturedImage != null
                ? Image.file(
                    File(_capturedImage!.path),
                    fit: BoxFit.cover,
                  )
                : Center(
                    child: SvgPicture.asset(
                    frontIdUploaded ? backIdPlaceholder : frontIdPlaceholder,
                    height: 80,
                  )),
          ),

          const SizedBox(
            height: 28,
          ),

          Text(
            frontIdUploaded ? 'Back Side' : 'Front Side',
            style: tenor22White,
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(54, 18, 54, 0),
            child: Text(
              'Upload the ${frontIdUploaded ? 'back' : 'front'} side of your valid ID from your device library',
              style: man14LightGrey,
              textAlign: TextAlign.center,
            ),
          ),

          const Spacer(),

          !uploadingImage && requestController is! MALoadingState
              ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                    children: [
                      // Padding(
                      //   padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16),
                      //   child: OutlinedBlackButton(
                      //       // text: captureState ? 'Choose from library' : 'Re-upload',
                      //       text: 'Choose from library',
                      //       onTap: () {
                      //         captureId();
                      //       }),
                      // ),
                      !captureState
                          ? Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: OutlinedBlackButton(onTap: (){
                              setState(() {
                                _capturedImage = null;
                              });
                            }, text: 'Re-capture',),
                          )
                          : Column(
                            children: [
                              OutlinedBlackButton(
                                onTap: captureId,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset('assets/svg/icons/membership/upload.svg'),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    const Text(
                                      'Upload photo',
                                      style: man16White,
                                    )
                                  ],
                                ),),

                              const DividerElectra(),

                              OutlinedBlackButton(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ImageCapture())).then((image) {
                                    if(image != null){
                                      _capturedImage = image;
                                      setState(() {});
                                    }
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                        'assets/svg/icons/membership/capturephoto.svg'),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    const Text(
                                      'Capture photo',
                                      style: man16White,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),

                      if (captureState &&
                          _capturedImage == null &&
                          frontIdUploaded)
                        Column(
                          children: [
                            // const DividerElectra(),
                            TextButton(
                                onPressed: () {
                                  if (_frontIdUrl != null) {
                                    if(widget.data.planList.length > 1){

                                      showModalBottomSheet(
                                          context: context,
                                          showDragHandle: true,
                                          builder: (context){
                                            return PlanSelectionDialog(
                                              plans: widget.data.planList,
                                              onPlanConfirmation: (selectedPlan){
                                                ref
                                                    .read(idVerificationScreen.notifier)
                                                    .state = VerificationScreen.selfie;
                                                ref
                                                    .read(membershipApplicationProvider
                                                    .notifier)
                                                    .submitMembershipRequest(widget.data,
                                                    frontIdPath: _frontIdUrl,
                                                  selectedPlan: selectedPlan
                                                );
                                              },);
                                          });

                                    }else{
                                      ref
                                          .read(idVerificationScreen.notifier)
                                          .state = VerificationScreen.selfie;
                                      ref
                                          .read(membershipApplicationProvider
                                          .notifier)
                                          .submitMembershipRequest(widget.data,
                                          frontIdPath: _frontIdUrl);
                                    }

                                  }
                                },
                                child: const Text(
                                  'Skip if not applicable',
                                  style: TextStyle(
                                      fontFamily: manrope,
                                      fontSize: 14,
                                      decoration: TextDecoration.underline,
                                      color: HtpTheme.goldenColor,
                                      decorationThickness: 2),
                                ))
                          ],
                        ),
                      if (_capturedImage != null)
                        RoundedGoldenButton(
                          onTap: () {

                            if(widget.data.planList.length > 1 && _frontIdUrl != null){
                              showModalBottomSheet(
                                  context: context,
                                  showDragHandle: true,
                                  builder: (context){
                                    return PlanSelectionDialog(
                                      plans: widget.data.planList,
                                      onPlanConfirmation: (selectedPlan){
                                        uploadImage().then((_) {
                                          if (_frontIdUrl != null && _backIdUrl != null) {
                                            ref.read(idVerificationScreen.notifier).state =
                                                VerificationScreen.selfie;
                                            ref
                                                .read(
                                                membershipApplicationProvider.notifier)
                                                .submitMembershipRequest(widget.data,
                                                frontIdPath: _frontIdUrl,
                                                backIdPath: _backIdUrl,
                                              selectedPlan: selectedPlan
                                            );
                                            // ref.read(membershipFormDataProvider.notifier).addGovtId(_frontIdUrl!, _backIdUrl);
                                          }
                                        });
                                      },);
                                  });
                            }else{
                              uploadImage().then((_) {
                                if (_frontIdUrl != null && _backIdUrl != null) {
                                  ref.read(idVerificationScreen.notifier).state =
                                      VerificationScreen.selfie;
                                  ref
                                      .read(
                                      membershipApplicationProvider.notifier)
                                      .submitMembershipRequest(widget.data,
                                      frontIdPath: _frontIdUrl,
                                      backIdPath: _backIdUrl);
                                  // ref.read(membershipFormDataProvider.notifier).addGovtId(_frontIdUrl!, _backIdUrl);
                                }
                              });
                            }

                          },
                          text: _frontIdUrl == null
                              ? 'Continue'
                              : "Send Membership Request",
                          textStyle: man16BlackW5,
                        ),
                    ],
                  ),
              )
              : const CircularProgressIndicator(color: HtpTheme.goldenColor),

          const SizedBox(
            height: 22,
          )
          // DividerElectra(),
        ],
      );
    });
  }
}
