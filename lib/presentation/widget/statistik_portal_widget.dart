import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../themes/app_fonts.dart';

class StatistikPortalWidget extends StatelessWidget {
  const StatistikPortalWidget({
    super.key,
    required this.image,
    required this.data,
    required this.name,
  });

  final Image image;
  final String data;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 45.w,
            child: image,
          ),
          SizedBox(width: 10.w),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                data,
                style: AppFonts.satuDataFonts.headlineMedium?.copyWith(
                  fontSize: 25.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                name,
                style: AppFonts.satuDataFonts.titleSmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
