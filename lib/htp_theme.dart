import 'package:flutter/material.dart';

// const montserratName = 'Montserrat';

const manrope = "Manrope";
const tenorSans = "TenorSans";

//Old one
// const TextStyle mont14 = TextStyle(
//   fontFamily: montserratName,
//   fontSize: 14,
// );

// const TextStyle mont14Golden = TextStyle(
//     fontSize: 14, color: HtpTheme.goldenColor, fontFamily: montserratName);

// const TextStyle mont16GoldenItalic = TextStyle(
//     fontSize: 16,
//     color: Color(0xFFE0AD23),
//     fontStyle: FontStyle.italic,
//     fontFamily: montserratName);

// const TextStyle mont16w600 = TextStyle(
//     fontSize: 16, fontWeight: FontWeight.w600, fontFamily: montserratName);

// const TextStyle mont18 = TextStyle(
//   fontFamily: montserratName,
//   fontSize: 18,
// );

// const TextStyle mont20 = TextStyle(
//   fontFamily: montserratName,
//   fontSize: 20,
// );
//-------------------------------------------------

class HtpTheme {
  // static TextTheme lightTextTheme = const TextTheme(
  // displayLarge: tenor46LightBlue,
  // displayMedium: tenor37LightBlue,
  // displaySmall: tenor28White,
  // headlineLarge: tenor25Gold3,
  // headlineMedium: tenor22LightBlue,
  // headlineSmall: tenor20White,
  // titleLarge: tenor18White,
  // titleMedium: tenor16Gold1,
  // titleSmall: man18White,
  // labelLarge: man18DarkBlue,
  // labelMedium: man15Gold2,
  // labelSmall: man14White,
  // bodyLarge: man14LightBlue,
  // bodyMedium: man14Gold2,
  // bodySmall: tenor12WhiteBold,
  //--------------old one (Bottom)
  //   headline5: TextStyle(
  //       fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
  //   headline4: TextStyle(
  //       fontSize: 18, fontFamily: montserratName, color: Color(0xffe8d48a)),
  //   headline6: TextStyle(
  //       fontSize: 18,
  //       fontFamily: montserratName,
  //       fontWeight: FontWeight.w800,
  //       color: Color(0xffe8d48a)),
  //   headline3: TextStyle(
  //       fontSize: 21, fontFamily: montserratName, color: Color(0xffe8d48a)),
  //   headline2: TextStyle(
  //       fontSize: 23, fontFamily: montserratName, color: Colors.white),
  //   headline1: TextStyle(
  //       fontSize: 28, fontFamily: montserratName, color: Colors.white),
  //   bodyText1: TextStyle(color: Colors.white),
  // );

  // static ThemeData light() {
  //   return ThemeData(
  //     fontFamily: "Manrope",
  //     brightness: Brightness.light,
  //     scaffoldBackgroundColor: darkBlue1Color,
  //     radioTheme: const RadioThemeData(
  //       fillColor: MaterialStatePropertyAll(goldColor),
  //     ),
  //     buttonTheme: ButtonThemeData(
  //       buttonColor: goldColor,
  //     ),
  //     textTheme: lightTextTheme,
  //     inputDecorationTheme: InputDecorationTheme(hintStyle: man14LightGrey),
  //   );
  // }

  static TextTheme darkTextTheme = const TextTheme(
      // displayLarge: tenor46LightBlue,
      // displayMedium: tenor37LightBlue,
      // displaySmall: tenor28White,
      // headlineLarge: tenor25Gold3,
      // headlineMedium: tenor22LightBlue,
      // headlineSmall: tenor20White,
      // titleLarge: tenor18White,
      // titleMedium: tenor16Gold1,
      // titleSmall: man18White,
      // labelLarge: man18DarkBlue,
      // labelMedium: man15Gold2,
      // labelSmall: man14White,
      // bodyLarge: man14LightBlue,
      // bodyMedium: man14Gold2,
      // bodySmall: tenor12WhiteBold,
      //------------(old one bottom) ---------------
      // headline5: TextStyle(
      //     fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      // headline4: TextStyle(
      //     fontSize: 18, fontFamily: montserratName, color: Color(0xffe8d48a)),
      // headline6: TextStyle(
      //     fontSize: 18,
      //     fontFamily: montserratName,
      //     fontWeight: FontWeight.w800,
      //     color: Color(0xffe8d48a)),
      // headline3: TextStyle(
      //     fontSize: 21, fontFamily: montserratName, color: Color(0xffe8d48a)),
      // headline2: TextStyle(
      //     fontSize: 23, fontFamily: montserratName, color: Colors.white),
      // headline1: TextStyle(
      //     fontSize: 28, fontFamily: montserratName, color: Colors.white),
      // bodyText1: TextStyle(color: Colors.white),
      );

  static MaterialColor primary = MaterialColor(0xffe8d48a, <int, Color>{
    500: const Color(0xffe8d48a).withOpacity(0.6),
  });

  static ThemeData dark() {
    return ThemeData(
      primarySwatch: primary,
      progressIndicatorTheme:
          const ProgressIndicatorThemeData(color: Color(0xffe8d48a)),
      fontFamily: "Manrope",
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkBlue1Color,
      dialogBackgroundColor: darkGrey4Color,
      highlightColor: HtpTheme.goldenColor,
      inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(
              fontFamily: manrope,
              fontSize: 14,
              color: Colors.grey.withOpacity(0.5))),
      radioTheme: const RadioThemeData(
        fillColor: MaterialStatePropertyAll(goldColor),
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: goldColor,
      ),
      textTheme: darkTextTheme,
      toggleButtonsTheme: const ToggleButtonsThemeData(
        selectedColor: whiteColor,
        borderColor: goldColor,
      ),
      checkboxTheme: CheckboxThemeData(
        // checkColor: MaterialStatePropertyAll(whiteColor),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
        side: MaterialStateBorderSide.resolveWith(
            (states) => const BorderSide(color: goldenColor)),
      ),
      switchTheme: const SwitchThemeData(
        // thumbColor: whiteColor,
        trackOutlineColor: MaterialStatePropertyAll(Colors.white),

        thumbColor: MaterialStatePropertyAll(HtpTheme.goldenColor),
      ),
      appBarTheme: const AppBarTheme(
          backgroundColor: darkBlue1Color,
          elevation: 0,
          titleTextStyle: man14White),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.black87,
        dragHandleColor: lightBlueColor,
        dragHandleSize: Size(160, 3),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16))),
      ),
    );
  }

  //----------------------------Old One--------------------------------------
  static const goldenColor = Color(0xffe8d48a);
  static const yellow1Color = Color(0xffE9BA41);
  static const darkPurple = Color(0xff4a1b3d);
  static const lightgreen = Color(0xff8CE0B6);
  // static const cardBlackColor = Color(0xff272727);
  static const cardBlackColor = Color(0xff1e1e1e);
  static const greytext1Color = Color(0xff262224);
  static const addButtonColor = Color(0xff837685);
  // static const bookingInactiveTabColor = Color(0xff837685);
  static const greytext2color = Color(0xffDCDBDC);

  static const montserratfont =
      TextStyle(fontFamily: "Montserrat", color: Colors.white, fontSize: 12);

  static TextStyle newTitleTextStyle = TextStyle(
      fontFamily: "Montserrat",
      fontSize: 18,
      color: Colors.white.withOpacity(0.9));

  static const detailTitleText = TextStyle(
      fontFamily: "Montserrat",
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: Colors.white);

  static const capText = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    fontFamily: "Montserrat",
  );
  //---------------------------------------------------------------------------

  static const goldColor = Color(0xffD3BB8A);

  static const whiteColor = Color(0xffFFFFFF);
  static const white1Color = Color(0xffF2F2F2);

  static const blackColor = Color(0xff000000);

  static const lightBlueColor = Color(0xffC0C8D3);
  static const lightGreyColor = Color(0xffB8B9BC);

  static const darkBlue1Color = Color(0xff0B1524);
  static const darkBlue2Color = Color(0xff090F17);
  static const darkBlue3Color = Color(0xff0F1621);
  static const darkGrey4Color = Color(0xff090F17);

  static const darkGreyColor = Color(0xff3D3F3E);
  static const darkGrey2Color = Color(0xff525961);
  static const darkGrey3Color = Color(0xff7B838E);
  static const lightRedColor = Color(0xffFF7B7B);
}

const TextStyle tenor16Gold = TextStyle(
  fontFamily: tenorSans,
  fontSize: 16,
  color: HtpTheme.goldColor,
);

const TextStyle tenor14Gold =
    TextStyle(fontFamily: tenorSans, fontSize: 14, color: HtpTheme.goldColor);

const TextStyle tenor26GoldItalic = TextStyle(
  fontFamily: tenorSans,
  fontStyle: FontStyle.italic,
  fontWeight: FontWeight.bold,
  fontSize: 26,
  color: HtpTheme.goldColor,
);

const TextStyle tenor26White = TextStyle(
  fontFamily: tenorSans,
  fontSize: 26,
  color: HtpTheme.whiteColor,
);

const TextStyle tenor22White = TextStyle(
  fontFamily: tenorSans,
  fontSize: 22,
  color: HtpTheme.whiteColor,
);
const TextStyle tenor22Black = TextStyle(
  fontFamily: tenorSans,
  fontSize: 22,
  color: HtpTheme.blackColor,
);

TextStyle tenor16WhiteOpac = TextStyle(
  fontFamily: tenorSans,
  fontSize: 16,
  color: HtpTheme.whiteColor.withOpacity(0.7),
);

TextStyle tenor16White = const TextStyle(
  fontFamily: tenorSans,
  fontSize: 16,
  color: HtpTheme.whiteColor,
);

const TextStyle tenor12WhiteBold = TextStyle(
  fontFamily: tenorSans,
  fontWeight: FontWeight.bold,
  fontSize: 12,
  color: HtpTheme.whiteColor,
);

TextStyle tenor12White = const TextStyle(
  fontFamily: tenorSans,
  fontSize: 12,
  color: HtpTheme.whiteColor,
);

TextStyle tenor12Gold = const TextStyle(
  fontFamily: tenorSans,
  fontSize: 12,
  color: HtpTheme.goldColor,
  // decoration: TextDecoration.underline,
  // decorationThickness: 2
);

TextStyle tenor10White = const TextStyle(
  fontFamily: tenorSans,
  fontSize: 10,
  color: HtpTheme.whiteColor,
);
TextStyle tenor10Black = const TextStyle(
  fontFamily: tenorSans,
  fontSize: 10,
  color: HtpTheme.blackColor,
);
TextStyle tenor10Gold = const TextStyle(
  fontFamily: tenorSans,
  fontSize: 10,
  color: HtpTheme.goldColor,
);

TextStyle tenor10WhiteW600 = const TextStyle(
  fontFamily: tenorSans,
  fontSize: 10,
  fontWeight: FontWeight.w600,
  color: HtpTheme.whiteColor,
);

const TextStyle tenor37LightBlue = TextStyle(
  fontFamily: tenorSans,
  fontSize: 37,
  color: HtpTheme.lightBlueColor,
);

const TextStyle tenor37LightBluelight = TextStyle(
  fontFamily: tenorSans,
  fontWeight: FontWeight.w200,
  fontSize: 37,
  color: HtpTheme.lightBlueColor,
);

const TextStyle tenor22LightBlue = TextStyle(
  fontFamily: tenorSans,
  fontSize: 22,
  color: HtpTheme.lightBlueColor,
);

const TextStyle tenor14LightBlue = TextStyle(
  fontFamily: tenorSans,
  fontSize: 14,
  color: HtpTheme.lightBlueColor,
);

const TextStyle tenor12LightBlue = TextStyle(
  fontFamily: tenorSans,
  fontSize: 12,
  color: HtpTheme.lightBlueColor,
);

// TextStyle tenor16Gold = const TextStyle(
//   fontFamily: tenorSans,
//   fontSize: 16,
//   color: HtpTheme.goldColor,
// );

TextStyle tenor22Gold = const TextStyle(
    fontFamily: tenorSans, fontSize: 22, color: HtpTheme.goldColor);

//--------------------------------------Manrope ----------------------

const TextStyle man16DarkBlue = TextStyle(
  fontFamily: manrope,
  fontSize: 16,
  color: HtpTheme.darkBlue2Color,
);

const TextStyle man12DarkBlue = TextStyle(
  fontFamily: manrope,
  fontSize: 12,
  color: HtpTheme.darkBlue2Color,
);

const TextStyle man10DarkBlue = TextStyle(
  fontFamily: manrope,
  fontWeight: FontWeight.bold,
  fontSize: 10,
  color: HtpTheme.darkBlue2Color,
);

const TextStyle man16White = TextStyle(
  fontFamily: manrope,
  fontSize: 16,
  color: HtpTheme.whiteColor,
);

const TextStyle man22White = TextStyle(
  fontFamily: manrope,
  fontSize: 22,
  color: HtpTheme.whiteColor,
);

const TextStyle man16LightBlue = TextStyle(
  fontFamily: manrope,
  fontSize: 16,
  color: HtpTheme.lightBlueColor,
);
const TextStyle man15Black = TextStyle(
  fontFamily: manrope,
  fontSize: 15,
  color: HtpTheme.blackColor,
);
const TextStyle man15White = TextStyle(
  fontFamily: manrope,
  fontSize: 15,
  color: HtpTheme.whiteColor,
);
const TextStyle man15LightBlue = TextStyle(
  fontFamily: manrope,
  fontSize: 15,
  color: HtpTheme.lightBlueColor,
);
const TextStyle man15Gold = TextStyle(
  fontFamily: manrope,
  fontSize: 15,
  color: HtpTheme.goldenColor,
);

const TextStyle man16BlackW5 = TextStyle(
    fontFamily: manrope,
    fontSize: 16,
    color: Colors.black,
    fontWeight: FontWeight.w500);

//
// const TextStyle man16DarkBlue = TextStyle(
//   fontFamily: manrope,
//   fontSize: 16,
//   color: HtpTheme.darkGrey4Color,
// );

TextStyle man14WhiteOpac = TextStyle(
  fontFamily: manrope,
  fontSize: 14,
  color: HtpTheme.whiteColor.withOpacity(0.4),
);

const TextStyle man14White = TextStyle(
  fontFamily: manrope,
  fontSize: 14,
  color: HtpTheme.whiteColor,
);

const TextStyle man14White1 = TextStyle(
  fontFamily: manrope,
  fontSize: 14,
  color: HtpTheme.white1Color,
);

TextStyle man12White = TextStyle(
  fontFamily: manrope,
  fontSize: 12,
  color: HtpTheme.whiteColor.withOpacity(0.6),
);

TextStyle man13White = TextStyle(
  fontFamily: manrope,
  fontSize: 13,
  color: HtpTheme.whiteColor.withOpacity(0.6),
);

const TextStyle man37Gold = TextStyle(
  fontFamily: manrope,
  fontSize: 37,
  color: HtpTheme.goldColor,
);

const TextStyle tenor37Gold = TextStyle(
  fontFamily: tenorSans,
  fontSize: 37,
  color: HtpTheme.goldColor,
);

const TextStyle man14Gold = TextStyle(
  fontFamily: manrope,
  fontSize: 14,
  color: HtpTheme.goldColor,
);

const TextStyle man12Gold = TextStyle(
  fontFamily: manrope,
  fontSize: 12,
  decorationThickness: 1,
  color: HtpTheme.goldColor,
);

const TextStyle man14LightBlue = TextStyle(
  fontFamily: manrope,
  fontSize: 14,
  color: HtpTheme.lightBlueColor,
);

const TextStyle man12LightBlue = TextStyle(
  fontFamily: manrope,
  fontSize: 12,
  color: HtpTheme.lightBlueColor,
);

TextStyle man12LightBlueOpac = TextStyle(
  fontFamily: manrope,
  fontSize: 12,
  color: HtpTheme.lightBlueColor.withOpacity(0.7),
);

const TextStyle man10Gold2 = TextStyle(
  fontFamily: manrope,
  fontSize: 10,
  color: HtpTheme.goldenColor,
);

const TextStyle man10LightBlue = TextStyle(
  fontFamily: manrope,
  fontSize: 10,
  color: HtpTheme.lightBlueColor,
);

TextStyle man10LightBlueOpac = TextStyle(
  fontFamily: manrope,
  fontSize: 10,
  color: HtpTheme.lightBlueColor.withOpacity(0.7),
);

TextStyle man14LightGreyOpac = TextStyle(
  fontFamily: manrope,
  fontSize: 14,
  color: HtpTheme.lightGreyColor.withOpacity(0.4),
);

const TextStyle man14LightGrey = TextStyle(
  fontFamily: manrope,
  fontSize: 14,
  color: HtpTheme.lightGreyColor,
);

TextStyle man12LightGreyOpac = TextStyle(
  fontFamily: manrope,
  fontSize: 12,
  color: HtpTheme.lightGreyColor.withOpacity(0.4),
);

TextStyle man12LightGrey = TextStyle(
  fontFamily: manrope,
  fontSize: 12,
  color: HtpTheme.lightGreyColor.withOpacity(0.9),
);

const TextStyle man16LightRed = TextStyle(
  fontFamily: manrope,
  fontSize: 16,
  color: HtpTheme.lightRedColor,
);

const TextStyle man14DarkGrey2 = TextStyle(
  fontFamily: manrope,
  fontSize: 14,
  color: HtpTheme.darkGrey2Color,
);

const TextStyle man15green = TextStyle(
  fontFamily: manrope,
  fontSize: 15,
  color: HtpTheme.lightgreen,
);
