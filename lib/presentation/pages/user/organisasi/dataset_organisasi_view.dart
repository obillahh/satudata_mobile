import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:satudata_mobile/presentation/themes/app_colors.dart';
import 'package:satudata_mobile/presentation/themes/app_fonts.dart';
import 'package:satudata_mobile/presentation/widget/dataset_item_widget.dart';

import '../../super_admin/dataset_table/bloc/dataset_bloc.dart';

class DatasetOrganisasiScreen extends StatelessWidget {
  const DatasetOrganisasiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          'Dataset Organisasi',
          style: AppFonts.satuDataFonts.titleLarge,
        ),
      ),
      body: BlocBuilder<DatasetBloc, DatasetState>(
        builder: (context, state) {
          if (state is DatasetLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is DatasetSuccess) {
            if (state.listDataset != null || state.listDataset!.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 6.sp),
                    Text(
                      'Dinas Komunikasi dan Informatikan',
                      style: AppFonts.satuDataFonts.labelLarge!.copyWith(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    SizedBox(height: 10.sp),
                    Text(
                      '${state.listDataset!.length} Dataset Ditemukan',
                      style: AppFonts.satuDataFonts.labelLarge!.copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.ink02,
                      ),
                    ),
                    SizedBox(height: 8.sp),
                    SizedBox(
                      height: 440.h,
                      child: ListView.separated(
                        itemCount: state.listDataset!.length,
                        itemBuilder: (context, index) {
                          final dataset = state.listDataset![index];

                          return DatasetItemWidget(
                            elevation: 4,
                            dataset: dataset,
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(height: 8.h);
                        },
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(child: Text('Dataset list is empty'));
            }
          } else {
            return const Center(child: Text('Failed to load Datasets'));
          }
        },
      ),
    );
  }
}
