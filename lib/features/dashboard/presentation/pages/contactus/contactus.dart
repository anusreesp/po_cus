import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_customer/authentication/theme.dart';
import 'package:htp_customer/authentication/validation.dart';
import 'package:htp_customer/common/form_validator.dart';
import 'package:htp_customer/common/widgets_common/rounded_golden_button.dart';
import 'package:htp_customer/features/dashboard/controllers/contact_us_controller.dart';
import 'package:htp_customer/htp_theme.dart';
import 'package:htp_customer/common/widgets_common/map_display.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../authentication/presentation/widgets/background.dart';
import '../../../../profile/controller/profile_controller.dart';
import '../../widgets/custom_app_bar.dart';

class ContactUs extends StatelessWidget {
  static const route = '/contactus';
  const ContactUs({super.key});

  @override
  Widget build(BuildContext context) {
    return const ContactUsForm();
  }
}

class ContactUsForm extends StatefulWidget {
  // static const route = '/ContactUsForm';
  const ContactUsForm({super.key});

  @override
  State<ContactUsForm> createState() => _ContactUsFormState();
}

class _ContactUsFormState extends State<ContactUsForm> {
  final _formKeyContact = GlobalKey<FormState>();
  final _focusName = FocusNode();
  final _focusEmail = FocusNode();
  final _focusPhone = FocusNode();
  final _focusMessage = FocusNode();
  final _nameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _phoneTextController = TextEditingController();
  final _messageTextController = TextEditingController();

  var colorTheme = AuthTheme.colorTheme();
  final requiredTextMessage = '*This field is required';

  InputDecoration inputDecorations(String? hintText) {
    return InputDecoration(
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          width: 0.6,
          //  color: Colors.yellow
          color: colorTheme.primaryColor,
        ),
      ),
      focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
        color: Color.fromARGB(255, 180, 180, 180),
      )),
      focusedErrorBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
      ),
      hintText: hintText,

      hintStyle: const TextStyle(
        fontSize: 12,
        fontFamily: "Open Sans",
        color: Color.fromARGB(255, 161, 161, 161),
      ),
      // hoverColor: const Color.fromARGB(255, 71, 71, 71),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        child: Text(
          "Contact us",
          style: HtpTheme.newTitleTextStyle,
          //  TextStyle(
          //     fontWeight: FontWeight.bold,
          //     fontFamily: "Allrox",
          //     fontSize: 18,
          //     color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          const DefaultBackground(),
          Padding(
            padding: const EdgeInsets.only(/* top: 138.0, */ left: 12, right: 12),
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 36),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.only(bottom: 8.0),
                    //   child: Text(
                    //     "Contact us",
                    //     style: HtpTheme.newTitleTextStyle,
                    //     //  TextStyle(
                    //     //     fontWeight: FontWeight.bold,
                    //     //     fontFamily: "Allrox",
                    //     //     fontSize: 18,
                    //     //     color: Colors.white),
                    //   ),
                    // ),
                    // const SizedBox(
                    //   height: 18,
                    // ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: SizedBox(
                        // height: 440,
                        // width: 400,
                        child: Consumer(
                          builder: (context, ref, _){
                            final profileController = ref.watch(profileControllerProvider);
                            if(profileController is ProfileLoaded){
                              _nameTextController.text = profileController.profileData.name;
                              _phoneTextController.text = profileController.profileData.contacts.first.phone;
                              _emailTextController.text = profileController.profileData.email;
                            }
                            return Form(
                              key: _formKeyContact,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      requiredText('Name'),
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 32.0),
                                        child: TextFormField(
                                            style: TextStyle(
                                                color: colorTheme.primaryColor),
                                            controller: _nameTextController,
                                            focusNode: _focusName,
                                            validator: RequiredValidator(errorText: requiredTextMessage),
                                            decoration:
                                            inputDecorations("Full Name")),
                                      ),
                                    ],
                                  ),
                                  //-----------------------------------------
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      requiredText('Mobile'),
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 32),
                                        child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            style: TextStyle(
                                                color: colorTheme.primaryColor),
                                            controller: _phoneTextController,
                                            focusNode: _focusPhone,
                                            validator: MultiValidator([RequiredValidator(errorText: requiredTextMessage)]),
                                            decoration:
                                            inputDecorations("Phone")),
                                      ),
                                    ],
                                  ),
                                  //-------------------------------------------
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      requiredText('Email'),
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(bottom: 32.0),
                                        child: TextFormField(
                                            style: TextStyle(
                                                color: colorTheme.primaryColor),
                                            controller: _emailTextController,
                                            focusNode: _focusEmail,
                                            validator: MultiValidator([RequiredValidator(errorText: requiredTextMessage), EmailValidator(errorText: 'Enter valid email')]),
                                            decoration:
                                            inputDecorations("Email")),
                                      ),
                                    ],
                                  ),
                                  //----------------------------------
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      requiredText('Your Message'),
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(bottom: 12.0),
                                        child: TextFormField(
                                            maxLines: 4,
                                            style: TextStyle(
                                                color: colorTheme.primaryColor),
                                            controller: _messageTextController,
                                            focusNode: _focusMessage,
                                            validator: RequiredValidator(errorText: requiredTextMessage),
                                            // validator: (value) => Validator.validateEmail(
                                            //       email: value,
                                            //     ),
                                            decoration:
                                            inputDecorations("Message")),
                                      ),
                                    ],
                                  ),

                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    Consumer(builder: (context, ref, _){
                      final controller = ref.watch(contactUsProvider);
                      ref.listen(contactUsProvider, (previous, next) {
                        if(next is ContactUsError){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(next.msg)));
                        }

                        if(next is ContactUsSuccess){
                          _nameTextController.clear();
                          _emailTextController.clear();
                          _messageTextController.clear();
                          _phoneTextController.clear();
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Request submitted successfully')));
                        }
                      });

                      if(controller is ContactUsLoading){
                        return const Center(child: const CircularProgressIndicator(color: HtpTheme.goldenColor),);
                      }

                      return RoundedGoldenButton(onTap: (){
                        if(_formKeyContact.currentState!.validate()){
                          FocusManager.instance.primaryFocus?.unfocus();
                          ref.read(contactUsProvider.notifier).contactUsRequest(
                              name: _nameTextController.text,
                              mobile: _phoneTextController.text,
                              email: _emailTextController.text,
                              message: _messageTextController.text);
                        }
                      },
                          text: 'Submit');
                    }),



                    Container(
                        padding: const EdgeInsets.only(left: 26, top: 18),
                        height: 170,
                        width: 330,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // ContactDetails(
                            //   icon: 'location-on.png',
                            //   title:
                            //       'CLOUDNET SOLUTIONS DMCC',
                            //   subtitle: Text(
                            //     "Suite 3710 Platinum Tower",
                            //     style: TextStyle(
                            //         color: Colors.white,
                            //         fontSize: 13,
                            //         fontWeight: FontWeight.w400),
                            //   ),
                            //   extra: Text(
                            //     "Cluster I, JLT, Dubai, UAE",
                            //     style: TextStyle(
                            //         fontSize: 13,
                            //         color: Colors.white,
                            //         fontWeight: FontWeight.w400),
                            //   ),
                            // ),
                            const SizedBox(
                              height: 8,
                            ),

                            GestureDetector(
                              onTap: (){
                                launchUrl(Uri(scheme: 'mailto', path: 'support@party.one'));
                              },
                              child: Row(
                                children: const [
                                  SizedBox(
                                    width: 25,
                                    child: Image(
                                      image: AssetImage("assets/images/others/email.png"),
                                      height: 18,
                                    ),
                                  ),
                                  SizedBox(width: 12,),
                                  Text(
                                    'support@party.one',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  )
                                ],
                              ),
                            ),

                            // ContactDetails(
                            //   icon: 'email.png',
                            //   title: 'support@htp.world',
                            // ),
                            // SizedBox(
                            //   height: 8,
                            // ),
                            // ContactDetails(
                            //   icon: 'phone-alt.png',
                            //   title: '+971-5287-23645',
                            // ),
                          ],
                        )),
                    // const Padding(
                    //   padding: EdgeInsets.only(bottom: 8),
                    //   child: SizedBox(
                    //     height: 320,
                    //     child: MapDisplay(
                    //         lat: 1.3521, lng: 103.8198, title: 'HTP'),
                    //   ),
                    //   // child: Image(
                    //   //     image: AssetImage('assets/images/temp/map.png')),
                    // ),
                  ]),
            ),
          )
        ],
      ),
    );
  }

  Widget requiredText(String text){
    return Row(
      children: [
        Text(
          text,
          style: TextStyle(
              fontSize: 12,
              fontFamily: "Open Sans",
              color: colorTheme.primaryColor,
              height: 0.4),
        ),
        const Padding(
          padding: EdgeInsets.only(bottom: 12.0),
          child: Icon(
            Icons.star,
            color: Colors.red,
            size: 10,
          ),
        )
      ],
    );
  }

}

class ContactDetails extends StatelessWidget {
  final String icon;
  final String title;
  final Widget? subtitle;
  final Widget? extra;
  final Widget? more;
  const ContactDetails(
      {Key? key,
      required this.icon,
      required this.title,
      this.subtitle,
      this.extra,
      this.more})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
        // Padding(
        //   padding: const EdgeInsets.symmetric(vertical: 8.0),
        //   child:
        Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 4.0, right: 16),
          child: SizedBox(
            width: 25,
            child: Image(
              image: AssetImage("assets/images/others/$icon"),
              height: 18,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 2.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 2),
                width: 250,
                child: Text(
                  title,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
              if (subtitle != null) subtitle!,
              if (extra != null) extra!,
              if (more != null) more!
            ],
          ),
        )
      ],
      // ),
    );
  }
}
