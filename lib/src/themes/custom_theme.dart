import 'package:average/app_exports.dart';

class CustomTheme {
  static ThemeData get lightTheme => FlexThemeData.light(
        fontFamily: GoogleFonts.poppins().fontFamily,
      );

  static ThemeData get darkTheme => FlexThemeData.dark(
        fontFamily: GoogleFonts.poppins().fontFamily,
      );
}
