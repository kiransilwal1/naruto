import 'package:flutter/material.dart';

class AppTheme {
  static const Color brandGreen100 = Color(0xFFfbfeda);
  static const Color brandGreen200 = Color(0xFFf7fdb5);
  static const Color brandGreen300 = Color(0xFFf0fb90);
  static const Color brandGreen400 = Color(0xFFe8f774);
  static const Color brandGreen500 = Color(0xFFddf247);
  static const Color brandGreen600 = Color(0xFFbad033);
  static const Color brandGreen700 = Color(0xFF99ae23);
  static const Color brandGreen800 = Color(0xFF798c16);
  static const Color brandGreen900 = Color(0xFF62740d);

  static const Color neutral0 = Color(0xFFFFFFFF);
  static const Color neutral100 = Color(0xFFf3f3f3);
  static const Color neutral200 = Color(0xFFe7e7e7);
  static const Color neutral300 = Color(0xFFb7b7b7);
  static const Color neutral400 = Color(0xFF6f6f6f);
  static const Color neutral500 = Color(0xFF101010);
  static const Color neutral600 = Color(0xFF0d0b0b);
  static const Color neutral700 = Color(0xFF0b0808);
  static const Color neutral800 = Color(0xFF090506);
  static const Color neutral900 = Color(0xFF070304);

  static const Color success100 = Color(0xFFedf8ef);
  static const Color success200 = Color(0xFFa1f9b4);
  static const Color success300 = Color(0xFF9bebbc);
  static const Color success400 = Color(0xFF7bd7ab);
  static const Color success500 = Color(0xFF52bd94);
  static const Color success600 = Color(0xFF3ba285);
  static const Color success700 = Color(0xFF298876);
  static const Color success800 = Color(0xFF1a6d66);
  static const Color success900 = Color(0xFF0f595a);

  static const Color error100 = Color(0xFFfff5f1);
  static const Color error200 = Color(0xFFffc3b7);
  static const Color error300 = Color(0xFFff9c93);
  static const Color error400 = Color(0xFFff7879);
  static const Color error500 = Color(0xFFff4c5e);
  static const Color error600 = Color(0xFFdb3756);
  static const Color error700 = Color(0xFFb7264f);
  static const Color error800 = Color(0xFF931846);
  static const Color error900 = Color(0xFF7a0e40);

  static const Color warning100 = Color(0xFFfefbe7);
  static const Color warning200 = Color(0xFFfef3b2);
  static const Color warning300 = Color(0xFFfee98c);
  static const Color warning400 = Color(0xFFfde06f);
  static const Color warning500 = Color(0xFFfcd240);
  static const Color warning600 = Color(0xFFd8ae2e);
  static const Color warning700 = Color(0xFFb58d20);
  static const Color warning800 = Color(0xFF926d14);
  static const Color warning900 = Color(0xFF78560c);

  static const Color info100 = Color(0xFFeaf1ff);
  static const Color info200 = Color(0xFFaac4f9);
  static const Color info300 = Color(0xFF7c9fef);
  static const Color info400 = Color(0xFF597fe0);
  static const Color info500 = Color(0xFF2952cc);
  static const Color info600 = Color(0xFF1d3eaf);
  static const Color info700 = Color(0xFF142d92);
  static const Color info800 = Color(0xFF0d1f76);
  static const Color info900 = Color(0xFF071561);

  static const Color secondary100 = Color(0xFFfeeeda);
  static const Color secondary200 = Color(0xFFfdd9b5);
  static const Color secondary300 = Color(0xFFfbbe90);
  static const Color secondary400 = Color(0xFFf7a474);
  static const Color secondary500 = Color(0xFFf27a47);
  static const Color secondary600 = Color(0xFFd05833);
  static const Color secondary700 = Color(0xFFae3a23);
  static const Color secondary800 = Color(0xFF8c2216);
  static const Color secondary900 = Color(0xFF74100d);

  static const Color saropa100 = Color(0xFFe8eaef);
  static const Color saropa200 = Color(0xFF9ea8bf);
  static const Color saropa300 = Color(0xFF7987a5);
  static const Color saropa400 = Color(0xFF5d6e93);
  static const Color saropa500 = Color(0xFF425584);
  static const Color saropa600 = Color(0xFF3c4e7b);
  static const Color saropa700 = Color(0xFF344470);
  static const Color saropa800 = Color(0xFF2d3b63);
  static const Color saropa900 = Color(0xFF232b4a);

  static const BoxShadow cardShadowSmall = BoxShadow(
    color: Color(0x1A465793),
    offset: Offset(4, 8),
    blurRadius: 24,
    spreadRadius: 0,
  );

  static const BoxShadow cardShadowMedium = BoxShadow(
    color: Color(0x14465793),
    offset: Offset(4, 12),
    blurRadius: 32,
    spreadRadius: 0,
  );

  static const BoxShadow cardShadowMain = BoxShadow(
    color: Color(0x1F465793),
    offset: Offset(4, 16),
    blurRadius: 32,
    spreadRadius: 0,
  );

  static const String fontFamilyUrbanist = 'Urbanist';

  static const double fontSize10 = 10.0;
  static const double fontSize11 = 11.0;
  static const double fontSize12 = 12.0;
  static const double fontSize14 = 14.0;
  static const double fontSize16 = 16.0;
  static const double fontSize18 = 18.0;
  static const double fontSize20 = 20.0;
  static const double fontSize24 = 24.0;
  static const double fontSize30 = 30.0;
  static const double fontSize36 = 36.0;
  static const double fontSize48 = 48.0;
  static const double fontSize70 = 70.0;

  static TextStyle headline100 = const TextStyle(
    fontFamily: fontFamilyUrbanist,
    fontWeight: FontWeight.w500,
    fontSize: fontSize10,
    letterSpacing: 1.0,
    height: 1.0,
  );

  static TextStyle headline200 = const TextStyle(
    fontFamily: fontFamilyUrbanist,
    fontWeight: FontWeight.bold,
    fontSize: fontSize12,
    letterSpacing: 1.0,
    height: 1.0,
  );

  static TextStyle headline300 = const TextStyle(
    fontFamily: fontFamilyUrbanist,
    fontWeight: FontWeight.bold,
    fontSize: fontSize14,
    letterSpacing: 0.01,
    height: 1.5,
  );

  static TextStyle headline400 = const TextStyle(
    fontFamily: fontFamilyUrbanist,
    fontWeight: FontWeight.w600,
    fontSize: fontSize16,
    letterSpacing: 1.0,
    height: 1.0,
  );

  static TextStyle headline500 = const TextStyle(
    fontFamily: fontFamilyUrbanist,
    fontWeight: FontWeight.bold,
    fontSize: fontSize18,
    letterSpacing: 1.0,
    height: 1.0,
  );

  static TextStyle headline600 = const TextStyle(
    fontFamily: fontFamilyUrbanist,
    fontWeight: FontWeight.bold,
    fontSize: fontSize20,
    letterSpacing: 1.0,
    height: 1.0,
  );

  static TextStyle headline700 = const TextStyle(
    fontFamily: fontFamilyUrbanist,
    fontWeight: FontWeight.w600,
    fontSize: fontSize30,
    letterSpacing: 1.0,
    height: 1.0,
  );

  static TextStyle headline800 = const TextStyle(
    fontFamily: fontFamilyUrbanist,
    fontWeight: FontWeight.w600,
    fontSize: fontSize30,
    letterSpacing: 1.0,
    height: 1.0,
  );

  static TextStyle headline900 = const TextStyle(
    fontFamily: fontFamilyUrbanist,
    fontWeight: FontWeight.bold,
    fontSize: fontSize48,
    letterSpacing: 1.0,
    height: 1.0,
  );

  static TextStyle headline1000 = const TextStyle(
    fontFamily: fontFamilyUrbanist,
    fontWeight: FontWeight.bold,
    fontSize: fontSize70,
    letterSpacing: 1.0,
    height: 1.0,
  );
  static TextStyle body10 = const TextStyle(
    fontFamily: fontFamilyUrbanist,
    fontWeight: FontWeight.w500,
    fontSize: fontSize12,
    letterSpacing: 0.01,
    height: 1.5,
  );

  static TextStyle body100 = const TextStyle(
    fontFamily: fontFamilyUrbanist,
    fontWeight: FontWeight.w500,
    fontSize: fontSize12,
    letterSpacing: 0.01,
    height: 1.83,
  );

  static TextStyle body200 = const TextStyle(
    fontFamily: fontFamilyUrbanist,
    fontWeight: FontWeight.w500,
    fontSize: fontSize14,
    letterSpacing: 0.01,
    height: 1.5,
  );

  static TextStyle body300 = const TextStyle(
    fontFamily: fontFamilyUrbanist,
    fontWeight: FontWeight.w500,
    fontSize: fontSize16,
    letterSpacing: 1.0,
    height: 1.5,
  );

  static TextStyle body400 = const TextStyle(
    fontFamily: fontFamilyUrbanist,
    fontWeight: FontWeight.w500,
    fontSize: fontSize18,
    letterSpacing: 1.0,
    height: 1.5,
  );

  static TextStyle body500 = const TextStyle(
    fontFamily: fontFamilyUrbanist,
    fontWeight: FontWeight.w500,
    fontSize: fontSize20,
    letterSpacing: 1.0,
    height: 1.5,
  );

  static TextStyle body600 = const TextStyle(
    fontFamily: fontFamilyUrbanist,
    fontWeight: FontWeight.w500,
    fontSize: fontSize24,
    letterSpacing: 1.0,
    height: 1.5,
  );
}
