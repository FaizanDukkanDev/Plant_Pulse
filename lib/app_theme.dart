import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';


class AppTheme {
  static ThemeData appTheme = ThemeData(
    // pageTransitionsTheme: PageTransitionsTheme(
    //   builders: {
    //     TargetPlatform.android: CustomPageTransitionBuilder(),
    //     TargetPlatform.iOS: CustomPageTransitionBuilder(),
    //   },
    // ),
    primaryColor: const Color(0xFF24D900),
    canvasColor: Colors.grey,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    scaffoldBackgroundColor: Colors.white,
    indicatorColor: const Color(0xFFF6BC18),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      toolbarHeight: 28.h,
    ),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.poppins(
        fontSize: 93.sp,
        fontWeight: FontWeight.w300,
        letterSpacing: -1.5,
        color: Colors.white,
      ),
      displayMedium: GoogleFonts.poppins(
        fontSize: 58.sp,
        fontWeight: FontWeight.w300,
        letterSpacing: -0.5,
        color: Colors.white,
      ),
      displaySmall: GoogleFonts.poppins(
        fontSize: 46.sp,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      headlineMedium: GoogleFonts.poppins(
        fontSize: 33.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        color: Colors.white,
      ),
      headlineSmall: GoogleFonts.poppins(
        fontSize: 23.sp,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      titleLarge: GoogleFonts.poppins(
        fontSize: 19.sp,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
        color: const Color(0xFF000812),
      ),
      titleMedium: GoogleFonts.poppins(
        fontSize: 15.sp,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.15,
        color: const Color(0xFF000812),
      ),
      titleSmall: GoogleFonts.poppins(
        fontSize: 13.sp,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        color: const Color(0xFF000812),
      ),
      bodyLarge: GoogleFonts.openSans(
        color: const Color(0xFF000812),
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
      ),
      bodyMedium: GoogleFonts.openSans(
        color: const Color(0xFF000812),
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.25,
      ),
      labelLarge: GoogleFonts.poppins(
        color: Colors.white,
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.25,
      ),
      bodySmall: GoogleFonts.poppins(
        color: Colors.grey,
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
      ),
      labelSmall: GoogleFonts.poppins(
        color: Colors.grey,
        fontSize: 10.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: 1.5,
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: const Color(0xFF000812).withOpacity(0.4),
      selectionHandleColor: const Color(0xFF000812),
      // cursorColor:  AppTheme.appTheme.primaryColor,
      cursorColor: const Color(0xFF24D900),
    ),
    floatingActionButtonTheme:  FloatingActionButtonThemeData(elevation: 10, backgroundColor: Color(0xFF24D900)),
    listTileTheme: const ListTileThemeData(
      iconColor: Color(0xFF24D900),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: false,
      hintStyle: GoogleFonts.poppins(
        color: Colors.grey.withOpacity(0.5),
        fontWeight: FontWeight.w500,
        letterSpacing: 0.25,
      ),
      labelStyle: GoogleFonts.poppins(
        color: Colors.grey.withOpacity(0.5),
        fontWeight: FontWeight.w500,
        letterSpacing: 0.25,
      ),
      floatingLabelStyle: GoogleFonts.poppins(
        color: const Color(0xFF000812),
        fontWeight: FontWeight.w500,
        letterSpacing: 0.25,
      ),
      isCollapsed: false,
      // isDense: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 18.h),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50.r),
        borderSide:  BorderSide(
            color: Color(0xFF000812).withOpacity(0.7)

        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50.r),
        borderSide: BorderSide(
            color: Color(0xFF000812).withOpacity(0.7)
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50.r),
        borderSide:  BorderSide(
            color: Color(0xFF000812).withOpacity(0.7)
          // color: Color(0xFF000812),
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50.r),
        borderSide: const BorderSide(
          color: Colors.redAccent,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50.r),
        borderSide: const BorderSide(
          color: Colors.redAccent,
        ),
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.all<Color>(const Color(0xFF000812)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(3.r),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return const Color(0xFF24D900).withOpacity(0.7);
          } else {
            return const Color(0xFF24D900);
          }
        }),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        minimumSize: MaterialStateProperty.all(Size(double.infinity, 48.h)),
        shape: MaterialStateProperty.all<OutlinedBorder>(const StadiumBorder()),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        side: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return BorderSide(width: 1.0.w, color: const Color(0xFF000812).withOpacity(0.7));
          } else {
            return  BorderSide(width: 1.0.w, color: Color(0xFF000812).withOpacity(0.7));
          }
        }),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        maximumSize: MaterialStateProperty.all(Size(double.infinity, 48.h)),
        minimumSize: MaterialStateProperty.all(Size(64.w, 48.h)),
        shape: MaterialStateProperty.all<OutlinedBorder>(const StadiumBorder()),
      ),
    ), colorScheme: ColorScheme.fromSwatch(
      accentColor: const Color(0xFF261854),
      errorColor: Colors.red,
    ).copyWith(error: Colors.redAccent),
  );
}



// import 'package:flutter/material.dart';
//
// class AppTheme {
//   AppTheme._();
//
//   static const Color background = Color(0xFFEEEFF4);
//   static const Color nearlyDarkGreen = Color(0xFF2EC821);
//   static const Color nearlyGreen = Color(0xFF24D900);
    int kPastelGreen = 0xFF10d180;
    int kBrownClr = 0xFFA1887F;
    int kGreyBlueClr = 0xFFCFD8DC;
    int kTealClr = 0xFF80CBC4;
//
//   static const Color notWhite = Color(0xFFEDF0F2);
//   static const Color nearlyWhite = Color(0xFFFEFEFE);
//   static const Color white = Color(0xFFFFFFFF);
//   static const Color nearlyBlack = Color(0xFF213333);
//   static const Color grey = Color(0xFF3A5160);
//   static const Color dark_grey = Color(0xFF313A44);
//
//   static const Color darkText = Color(0xFF253840);
//   static const Color darkerText = Color(0xFF17262A);
//   static const Color lightText = Color(0xFF4A6572);
//   static const Color deactivatedText = Color(0xFF767676);
//   static const Color dismissibleBackground = Color(0xFF364A54);
//   static const Color chipBackground = Color(0xFFEEF1F3);
//   static const Color spacer = Color(0xFFF2F2F2);
//   static const String fontName = 'Roboto';
//
//   static const TextTheme textTheme = TextTheme(
//     headlineMedium: headline4,
//     headlineSmall: headline5,
//     titleLarge: headline6,
//     titleSmall: subtitle2,
//     bodyMedium: bodyText2,
//     bodyLarge: bodyText1,
//     bodySmall: caption,
//   );
//
//   static const TextStyle headline4 = TextStyle(
//     fontFamily: fontName,
//     fontWeight: FontWeight.bold,
//     fontSize: 36,
//     letterSpacing: 0.4,
//     height: 0.9,
//     color: darkerText,
//   );
//
//   static const TextStyle headline5 = TextStyle(
//     fontFamily: fontName,
//     fontWeight: FontWeight.bold,
//     fontSize: 24,
//     letterSpacing: 0.27,
//     color: darkerText,
//   );
//
//   static const TextStyle headline6 = TextStyle(
//     fontFamily: fontName,
//     fontWeight: FontWeight.bold,
//     fontSize: 16,
//     letterSpacing: 0.18,
//     color: darkerText,
//   );
//
//   static const TextStyle subtitle2 = TextStyle(
//     fontFamily: fontName,
//     fontWeight: FontWeight.w400,
//     fontSize: 14,
//     letterSpacing: -0.04,
//     color: darkText,
//   );
//
//   static const TextStyle bodyText2 = TextStyle(
//     fontFamily: fontName,
//     fontWeight: FontWeight.w400,
//     fontSize: 14,
//     letterSpacing: 0.2,
//     color: darkText,
//   );
//
//   static const TextStyle bodyText1 = TextStyle(
//     fontFamily: fontName,
//     fontWeight: FontWeight.w600,
//     fontSize: 14,
//     letterSpacing: -0.05,
//     color: darkText,
//   );
//
//   static const TextStyle caption = TextStyle(
//     fontFamily: fontName,
//     fontWeight: FontWeight.w400,
//     fontSize: 12,
//     letterSpacing: 0.2,
//     color: lightText,
//   );
//
//   static const AppBarTheme appBarTheme = AppBarTheme(
//     color: white,
//   );
//
//   static InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
//     border: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(32.0),
//       borderSide: BorderSide(
//         width: 0.0,
//         style: BorderStyle.none,
//       ),
//     ),
//     errorBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(32.0),
//       borderSide: BorderSide(
//         width: 2.0,
//         color: Colors.red,
//       ),
//     ),
//     focusedErrorBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(32.0),
//       borderSide: BorderSide(
//         width: 2.0,
//         color: Colors.red,
//       ),
//     ),
//     filled: true,
//     fillColor: white,
//     errorMaxLines: 3,
//     labelStyle: TextStyle(
//       fontWeight: FontWeight.w600,
//       fontSize: 14,
//       letterSpacing: 0.2,
//       color: lightText,
//     ),
//     errorStyle: TextStyle(
//       fontWeight: FontWeight.w600,
//       fontSize: 14,
//       letterSpacing: 0.2,
//       color: Colors.red,
//     ),
//   );
// }
