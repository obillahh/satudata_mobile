import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:satudata_mobile/presentation/themes/app_fonts.dart';
import 'package:satudata_mobile/presentation/widget/data_statistik_widget.dart';

import '../../../widget/appbar_widget.dart';
import '../../../widget/dataset_item_widget.dart';
import '../../../widget/organisasi_widget.dart';
import '../../../widget/searc_bar_widget.dart';
import '../../../widget/statistik_portal_widget.dart';
import '../../super_admin/dataset_table/bloc/dataset_bloc.dart';
import '../../super_admin/organisasi_table/bloc/organisasi_bloc.dart';
import '../../super_admin/topik_table/bloc/topic_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<OrganisasiBloc>(context).add(FetchOrganisasiWithToken());
    BlocProvider.of<TopicBloc>(context).add(FetchTopicsWithToken());
    BlocProvider.of<DatasetBloc>(context).add(FetchDatasetsWithToken());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: const SatuDataAppBar(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SearchBarWidget(),
              SizedBox(height: 20.h),
              buildStatistikPortal(),
              SizedBox(height: 10.h),
              buildOrganisasiTerkait(),
              SizedBox(height: 10.h),
              buildDataStatistik(),
              SizedBox(height: 10.h),
              buildDatasetTerbaru(),
            ],
          ),
        ),
      ),
    );
  }

  Column buildDatasetTerbaru() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Dataset Terbaru',
          style: AppFonts.satuDataFonts.headlineMedium?.copyWith(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 10.h),
        BlocBuilder<DatasetBloc, DatasetState>(
          builder: (context, state) {
            
            if (state is DatasetLoading) {
              
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is DatasetSuccess) {
              if (state.listDataset != null || state.listDataset!.isNotEmpty) {
                return SizedBox(
                  height: 140.h,
                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 4 / 7,
                    ),
                    itemCount: state.listDataset!.length,
                    itemBuilder: (context, index) {
                      final dataset = state.listDataset![index];

                      return DatasetItemWidget(
                        sizeFontOrganisasi: 14.sp,
                        heightSizedBox: 8.h,
                        elevation: 8,
                        dataset: dataset,
                      );
                    },
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
      ],
    );
  }

  Column buildDataStatistik() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Data Statistik',
          style: AppFonts.satuDataFonts.headlineMedium?.copyWith(
            fontSize: 22.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 10.h),
        BlocBuilder<TopicBloc, TopicState>(
          builder: (context, state) {
            if (state is TopicLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TopicSuccess) {
              if (state.topic != null && state.topic!.isNotEmpty) {
                return SizedBox(
                  height: 210.h,
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                    ),
                    itemCount: state.topic!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final topic = state.topic![index];
                      return DataStatistikWidget(
                        fontSize: 12.sp,
                        dataTopic: topic,
                        scaleSizeLogo: 40.w,
                      );
                    },
                  ),
                );
              } else {
                // Handle the case when state.topic is null or empty
                return const Center(child: Text('Topic list is empty'));
              }
            } else {
              return const Center(child: Text('Failed to load topics'));
            }
          },
        ),
      ],
    );
  }

  Column buildOrganisasiTerkait() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Organisasi Terkait',
          style: AppFonts.satuDataFonts.headlineMedium?.copyWith(
            fontSize: 22.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 10.h),
        BlocBuilder<OrganisasiBloc, OrganisasiState>(
          builder: (context, state) {
            if (state is OrganisasiLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is OrganisasiSuccess) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 210.h,
                    child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                      ),
                      itemBuilder: (context, index) {
                        if (state.organisasi != null &&
                            state.organisasi!.isNotEmpty) {
                          final response = state.organisasi![index];
                          return OrganisasiWidget(
                            fontSize: 8.sp,
                            fontSizeDataset: 0,
                            scaleSizeImage: 40.w,
                            dataOrganisasi: response,
                          );
                        } else {
                          // Handle the case when state.organisasi is null or empty
                          return Container(); // Replace with appropriate widget or loading indicator
                        }
                      },
                      itemCount: state.organisasi?.length ?? 0,
                    ),
                  ),
                  SizedBox(height: 10.h),
                ],
              );
            } else {
              return const Center(child: Text('Organization empty'));
            }
          },
        ),
      ],
    );
  }

  Column buildStatistikPortal() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Statistik Portal',
          style: AppFonts.satuDataFonts.headlineMedium?.copyWith(
            fontSize: 22.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12.h),
        SizedBox(
          height: 140.h,
          child: GridView.count(
            childAspectRatio: (5 / 2),
            crossAxisCount: 2,
            children: [
              BlocBuilder<DatasetBloc, DatasetState>(
                builder: (context, state) {
                  return StatistikPortalWidget(
                    image: Image.asset('assets/images/dataset.png'),
                    data: state is DatasetSuccess
                        ? (state.listDataset?.length ?? 0).toString()
                        : '0',
                    name: 'Dataset',
                  );
                },
              ),
              BlocBuilder<OrganisasiBloc, OrganisasiState>(
                builder: (context, state) {
                  return StatistikPortalWidget(
                    image: Image.asset('assets/images/organisasi.png'),
                    data: state is OrganisasiSuccess
                        ? (state.organisasi?.length ?? 0).toString()
                        : '0',
                    name: 'Organisasi',
                  );
                },
              ),
              BlocBuilder<TopicBloc, TopicState>(
                builder: (context, state) {
                  return StatistikPortalWidget(
                    image: Image.asset('assets/images/topik.png'),
                    data: state is TopicSuccess
                        ? (state.topic?.length ?? 0).toString()
                        : '0',
                    name: 'Topik',
                  );
                },
              ),
              StatistikPortalWidget(
                image: Image.asset('assets/images/publikasi.png'),
                data: '0',
                name: 'Publikasi',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
