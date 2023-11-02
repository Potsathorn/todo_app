// Flutter imports:
import 'package:flutter/material.dart';

class AppColor {
  static const MaterialColor colorPrimary =
      MaterialColor(0xFFCF3339, <int, Color>{
    0: Color(0xFFCF3339),
    1: Color(0xFFF9636C),
    2: Color(0xFF00BBB4),
    3: Color(0xFFFFA255),
    4: Color(0xFFC7EBFF),
  });

  static const MaterialColor colorSecondary =
      MaterialColor(0xFFFFA5A5, <int, Color>{
    0: Color(0xFFFFA5A5),
    1: Color(0xFFFFF2F2),
    3: Color(0xFFC7EBFF),
  });

  static const MaterialColor colorGrey = MaterialColor(0xFF454545, <int, Color>{
    0: Color(0xFF454545),
    1: Color(0xFF5B6670),
    2: Color(0xFFDBDBDB),
    3: Color(0xFFE1E1E1),
    4: Color(0xFFE4E6EB),
    5: Color(0xFFFFFFFF),
    6: Color(0xFFEEEEEE),
    7: Color(0xECECECEC),
    8: Color(0xE1E1E1E1),
  });

  static const MaterialColor colorBackground =
      MaterialColor(0xFFFAFAFA, <int, Color>{
    0: Color(0xFFFAFAFA),
    1: Color(0xFFF7F7F7),
  });

  static const MaterialColor colorText = MaterialColor(0xFF212328, <int, Color>{
    0: Color(0xFF212328),
  });

  static const MaterialColor colorWhite =
      MaterialColor(0xFFFFFFFF, <int, Color>{
    0: Color(0xFFFFFFFF),
  });

  static const MaterialColor colorBlack =
      MaterialColor(0xFF161616, <int, Color>{
    0: Color(0xFF161616),
    1: Color(0xFF111933),
    2: Color(0xFF8D8D8D),
  });

  static const LinearGradient gradientPrimary = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFF89625),
      Color(0xFFF3591F),
      Color(0xFFF03366),
    ],
    tileMode: TileMode.mirror,
  );

  static const MaterialColor colorBlue = MaterialColor(
    0xff003d98,
    <int, Color>{
      0: Color(0xFF1C92FF),
    },
  );

  static const LinearGradient gradientBlueWhite = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xff003d98),
    ],
    tileMode: TileMode.mirror,
  );
}
