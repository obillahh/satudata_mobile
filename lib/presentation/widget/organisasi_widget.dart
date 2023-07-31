import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:satudata_mobile/data/repository/api.dart';
import 'package:satudata_mobile/presentation/themes/app_fonts.dart';

import '../../data/models/organization/response_organization.dart';
import '../themes/app_colors.dart';

class OrganisasiWidget extends StatelessWidget {
  const OrganisasiWidget({
    super.key,
    this.dataset,
    required this.fontSize,
    this.height,
    this.fontSizeDataset,
    required this.dataOrganisasi,
    this.scaleSizeImage,
  });

  final ResponseOrganization dataOrganisasi;
  final double fontSize;
  final double? fontSizeDataset;
  final double? scaleSizeImage;
  final double? height;
  final String? dataset;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push('/organisasi/dataset-organisasi');
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: scaleSizeImage!,
                child: Image.network(
                  '${Api.baseUrl}${dataOrganisasi.url}',
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                dataOrganisasi.name!,
                textAlign: TextAlign.center,
                style: AppFonts.satuDataFonts.titleLarge!.copyWith(
                  color: AppColors.ink01,
                  fontWeight: FontWeight.bold,
                  fontSize: fontSize.sp,
                ),
              ),
              SizedBox(height: height),
              Text(
                dataset ?? '',
                style: AppFonts.satuDataFonts.titleMedium!.copyWith(
                  color: AppColors.ink01,
                  fontWeight: FontWeight.w400,
                  fontSize: fontSizeDataset!.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
