import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:satudata_mobile/presentation/themes/app_colors.dart';
import 'package:satudata_mobile/presentation/themes/app_fonts.dart';

import '../dataset_table/bloc/dataset_bloc.dart';
import '../organisasi_table/bloc/organisasi_bloc.dart';
import '../topik_table/bloc/topic_bloc.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final Color dataColor = AppColors.primaryColor;
  final double width = 24;
  List<BarChartGroupData>? rawBarGroups;
  List<BarChartGroupData>? showingBarGroups;

  @override
  void initState() {
    super.initState();
    final barGroup1 = makeGroupData(0, 11);
    final barGroup2 = makeGroupData(1, 10);
    final barGroup3 = makeGroupData(2, 12);
    final barGroup4 = makeGroupData(3, 15);
    final barGroup5 = makeGroupData(4, 18);

    final items = [barGroup1, barGroup2, barGroup3, barGroup4, barGroup5];

    rawBarGroups = items;
    showingBarGroups = rawBarGroups;

    BlocProvider.of<OrganisasiBloc>(context).add(FetchOrganisasiWithToken());
    BlocProvider.of<TopicBloc>(context).add(FetchTopicsWithToken());
    BlocProvider.of<DatasetBloc>(context).add(FetchDatasetsWithToken());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 12.h,
                ),
                Text(
                  'Statistik Portal Data Palembang',
                  style: AppFonts.satuDataFonts.bodyLarge!.copyWith(
                    fontSize: 36,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 24.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlocBuilder<DatasetBloc, DatasetState>(
                      builder: (context, state) {
                        return buildCardWithImage(
                          'dataset',
                          'Dataset',
                          state is DatasetSuccess
                              ? (state.listDataset?.length ?? 0).toString()
                              : '0',
                        );
                      },
                    ),
                    BlocBuilder<OrganisasiBloc, OrganisasiState>(
                      builder: (context, state) {
                        return buildCardWithImage(
                          'organisasi',
                          'Organisasi',
                          state is OrganisasiSuccess
                              ? (state.organisasi?.length ?? 0).toString()
                              : '0',
                        );
                      },
                    ),
                    BlocBuilder<TopicBloc, TopicState>(
                      builder: (context, state) {
                        return buildCardWithImage(
                          'topik',
                          'Topik',
                          state is TopicSuccess
                              ? (state.topic?.length ?? 0).toString()
                              : '0',
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                buildChartSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCardWithImage(String tag, String title, String value) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      child: Row(
        children: [
          Hero(
            tag: tag,
            child: Image.asset(
              'assets/images/$tag.png',
              scale: 5.r,
            ),
          ),
          SizedBox(width: 8.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: AppFonts.satuDataFonts.headlineMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                title,
                style: AppFonts.satuDataFonts.titleMedium!.copyWith(
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildChartSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Jumlah Dataset per Organisasi',
          style: AppFonts.satuDataFonts.bodyLarge!.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 16.h),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            height: 300.h,
            width: MediaQuery.of(context).size.width,
            child: BarChart(
              BarChartData(
                maxY: 18,
                titlesData: FlTitlesData(
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      getTitlesWidget: bottomTitles,
                      showTitles: true,
                      reservedSize: 40,
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      getTitlesWidget: leftTitles,
                      showTitles: true,
                      reservedSize: 30,
                      interval: 1,
                    ),
                  ),
                ),
                borderData: FlBorderData(show: true),
                gridData: const FlGridData(show: true),
                barGroups: showingBarGroups,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    final titles = [
      'Kec. Ilir Barat Satu',
      'Kec. Ilir Timur Tiga',
      'Kec. Alang Alang Lebar',
      'Kec. Sematang Borang',
      'Kec. Kertapati',
    ];

    final Widget text = Text(
      titles[value.toInt()],
      style: const TextStyle(
        color: Color(0xff7589a2),
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10, //margin top
      child: text,
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    String text;
    if (value == 0) {
      text = '0';
    } else if (value == 5) {
      text = '5';
    } else if (value == 10) {
      text = '10';
    } else if (value == 15) {
      text = '15';
    } else if (value == 20) {
      text = '20';
    } else {
      return Container();
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10, //margin right
      child: Text(text, style: style),
    );
  }

  BarChartGroupData makeGroupData(int x, double y1) {
    return BarChartGroupData(
      barsSpace: 0,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          color: dataColor,
          width: width,
        ),
      ],
    );
  }
}
