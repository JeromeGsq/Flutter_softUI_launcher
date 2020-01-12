import 'package:flutter/material.dart';
import 'package:softui_launcher/theme/app_colors.dart';

BoxDecoration nMbox({double radius = 15}) {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(radius),
    color: AppColors.mainColor,
    border: Border.all(
      color: Color.fromARGB(100, 255, 255, 255),
      width: 0,
    ),
    boxShadow: [
      BoxShadow(
        color: AppColors.mCD,
        offset: Offset(10, 10),
        blurRadius: 10,
      ),
      BoxShadow(
        color: AppColors.mCL,
        offset: Offset(-10, -10),
        blurRadius: 10,
      ),
    ],
  );
}

BoxDecoration nMboxInvert({double radius = 15}) {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(radius),
    color: AppColors.mCD,
    boxShadow: [
      BoxShadow(
        color: AppColors.mCL,
        offset: Offset(3, 3),
        blurRadius: 3,
        spreadRadius: -3,
      ),
    ],
  );
}

BoxDecoration nMboxInvertActive = nMboxInvert().copyWith(color: AppColors.mCC);

BoxDecoration nMbtn = BoxDecoration(
  borderRadius: BorderRadius.circular(10),
  color: AppColors.mainColor,
  boxShadow: [
    BoxShadow(
      color: AppColors.mCD,
      offset: Offset(2, 2),
      blurRadius: 2,
    )
  ],
);

BoxDecoration nMboxInner({double radius = 15}) {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(radius),
    border: Border.all(
      color: Color.fromARGB(100, 255, 255, 255),
      width: 1,
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.white60,
        offset: Offset(10, 10),
        blurRadius: 10,
      ),
      BoxShadow(
        color: AppColors.mCDD,
        offset: Offset(-10, -10),
        blurRadius: 10,
      ),
    ],
  );
}

BoxDecoration nMboxOuter({double radius = 15}) {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(radius),
    border: Border.all(
      color: Color.fromARGB(100, 255, 255, 255),
      width: 1,
    ),
    boxShadow: [
      BoxShadow(
        color: AppColors.mCDD,
        offset: Offset(30, 30),
        blurRadius: 15,
      ),
      BoxShadow(
        color: AppColors.mainColor,
        offset: Offset(-20, -20),
        blurRadius: 10,
      ),
    ],
  );
}
