import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:satudata_mobile/presentation/themes/app_fonts.dart';

import '../../data/models/topic/response_topic.dart';
import '../../data/repository/api.dart';

class DataStatistikWidget extends StatelessWidget {
  const DataStatistikWidget({
    super.key,
    required this.fontSize,
    required this.dataTopic,
    required this.scaleSizeLogo,
  });

  final ResponseTopic dataTopic;
  final double fontSize;
  final double scaleSizeLogo;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push('/topik/dataset-topik');
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 4,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: scaleSizeLogo,
                child: Image.network(
                  '${Api.baseUrl}${dataTopic.url}',
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                dataTopic.name!,
                style: AppFonts.satuDataFonts.titleSmall!.copyWith(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
