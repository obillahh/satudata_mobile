import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../themes/app_colors.dart';
import '../../../themes/app_fonts.dart';

class DatasetTopikScreen extends StatelessWidget {
  const DatasetTopikScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          'Dataset Topik',
          style: AppFonts.satuDataFonts.titleLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 6.sp),
            Text(
              'Sistem Neraca Regional',
              style: AppFonts.satuDataFonts.labelLarge!.copyWith(
                fontSize: 24.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              '0 Dataset Ditemukan',
              style: AppFonts.satuDataFonts.labelLarge!.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.ink02,
              ),
            ),
            SizedBox(height: 8.h),
            SizedBox(
              height: 470.h,
              child: ListView.separated(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Neraca Laba Rugi',
                            style: AppFonts.satuDataFonts.labelLarge!.copyWith(
                              fontSize: 16.sp,
                              color: AppColors.ink01,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'Dibuat Pada: 20 Oktober 2022',
                            style: AppFonts.satuDataFonts.labelLarge!.copyWith(
                              fontSize: 12.sp,
                              color: AppColors.ink03,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 8.h);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
