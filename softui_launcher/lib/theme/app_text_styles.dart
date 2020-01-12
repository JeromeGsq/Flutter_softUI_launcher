import 'package:flutter/widgets.dart';
import 'package:softui_launcher/theme/app_colors.dart';

/// Text styles used in the app.
class AppTextStyles {
  AppTextStyles._();

  static const TextStyle homeGreeting = _AppTextStyle(
    fontWeight: FontWeight.w500,
    color: AppColors.white,
    fontSize: 20,
  );

  static const TextStyle paragraphNormal = _AppTextStyle(
    fontWeight: FontWeight.w500,
    color: AppColors.darkBlue,
    fontSize: 14,
  );

  static const TextStyle paragraphNormalGreen = _AppTextStyle(
    fontWeight: FontWeight.w500,
    color: AppColors.lightGreen,
    fontSize: 13,
  );

  static const TextStyle paragraphNormalValidated = _AppTextStyle(
    fontWeight: FontWeight.w500,
    color: AppColors.green,
    fontSize: 13,
  );

  static const TextStyle paragraphSmall = _AppTextStyle(
    fontWeight: FontWeight.w500,
    color: AppColors.darkGrey,
    fontSize: 12,
    letterSpacing: -0.46,
  );
}

class _AppTextStyle extends TextStyle {
  const _AppTextStyle({
    FontWeight fontWeight,
    Color color,
    double fontSize,
    double letterSpacing,
    FontStyle fontStyle = FontStyle.normal,
  }) : super(
          fontWeight: fontWeight,
          fontStyle: fontStyle,
          color: color,
          fontSize: fontSize,
          letterSpacing: letterSpacing,
          fontFamily: 'Roboto',
        );
}
