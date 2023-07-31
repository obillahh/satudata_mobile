import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:satudata_mobile/data/models/dataset/response_dataset.dart';

import '../themes/app_colors.dart';
import '../themes/app_fonts.dart';

class DatasetItemWidget extends StatelessWidget {
  const DatasetItemWidget({
    super.key,
    this.sizeFontOrganisasi,
    this.heightSizedBox,
    required this.elevation,
    required this.dataset,
  });
  final ResponseDataset dataset;
  final double? sizeFontOrganisasi;
  final double? heightSizedBox;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push('/organisasi/detail-dataset');
      },
      child: Card(
        elevation: elevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                dataset.organization?.name ?? '',
                style: AppFonts.satuDataFonts.titleMedium!.copyWith(
                  color: AppColors.ink02,
                  fontSize: sizeFontOrganisasi ?? 0,
                  letterSpacing: 0,
                ),
              ),
              SizedBox(height: heightSizedBox ?? 0),
              Text(
                dataset.title ?? '',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: AppFonts.satuDataFonts.titleLarge!.copyWith(
                  color: AppColors.ink01,
                  letterSpacing: 0,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                dataset.updatedAt.toString(),
                style: AppFonts.satuDataFonts.titleSmall!.copyWith(
                  color: AppColors.ink03,
                  letterSpacing: 0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
