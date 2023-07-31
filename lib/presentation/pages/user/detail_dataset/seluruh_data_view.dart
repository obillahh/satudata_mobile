import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:satudata_mobile/presentation/themes/app_colors.dart';
import 'package:satudata_mobile/presentation/themes/app_fonts.dart';

class SeluruhData extends StatefulWidget {
  const SeluruhData({super.key});
  final Color data1 = Colors.red;
  final Color data2 = Colors.orange;
  final Color data3 = Colors.yellow;
  final Color data4 = Colors.green;
  final Color data5 = Colors.blue;

  @override
  State<SeluruhData> createState() => _SeluruhDataState();
}

class _SeluruhDataState extends State<SeluruhData> {
  final double width = 7;

  List<BarChartGroupData>? rawBarGroups;
  List<BarChartGroupData>? showingBarGroups;

  @override
  void initState() {
    super.initState();
    final barGroup1 = makeGroupData(0, 11, 3, 1, 0, 0);
    final barGroup2 = makeGroupData(1, 0, 0, 0, 0, 1);
    final barGroup3 = makeGroupData(2, 4, 4, 2, 0, 0);
    final barGroup4 = makeGroupData(3, 3, 2, 1, 0, 0);
    final barGroup5 = makeGroupData(4, 18, 9, 4, 0, 1);

    final items = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
    ];

    rawBarGroups = items;
    showingBarGroups = rawBarGroups;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.ink05,
        title: Text(
          'Seluruh Data',
          style: AppFonts.satuDataFonts.titleLarge!.copyWith(
            color: AppColors.primaryColor,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 20.h),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              height: 250.h,
              width: 600.w,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Kelurahan')),
                  DataColumn(label: Text('SD')),
                  DataColumn(label: Text('SMP')),
                  DataColumn(label: Text('SMA')),
                  DataColumn(label: Text('SMK')),
                  DataColumn(label: Text('Universitas')),
                ],
                rows: const [
                  DataRow(
                    cells: [
                      DataCell(Text('Talang Kelapa')),
                      DataCell(Text('11')),
                      DataCell(Text('3')),
                      DataCell(Text('1')),
                      DataCell(Text('0')),
                      DataCell(Text('0')),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(Text('Alang-Alang Lebar')),
                      DataCell(Text('0')),
                      DataCell(Text('0')),
                      DataCell(Text('0')),
                      DataCell(Text('0')),
                      DataCell(Text('1')),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(Text('Karya Baru')),
                      DataCell(Text('4')),
                      DataCell(Text('4')),
                      DataCell(Text('2')),
                      DataCell(Text('0')),
                      DataCell(Text('0')),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(Text('Srijaya')),
                      DataCell(Text('3')),
                      DataCell(Text('2')),
                      DataCell(Text('1')),
                      DataCell(Text('0')),
                      DataCell(Text('0')),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(Text('Total')),
                      DataCell(Text('18')),
                      DataCell(Text('9')),
                      DataCell(Text('4')),
                      DataCell(Text('0')),
                      DataCell(Text('1')),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 8.h),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              height: 250.h,
              width: 600.w,
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
                        showTitles: true,
                        getTitlesWidget: bottomTitles,
                        reservedSize: 42,
                      ),
                    ),
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 28,
                        interval: 1,
                        getTitlesWidget: leftTitles,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  gridData: const FlGridData(show: false),
                  barGroups: showingBarGroups,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    final titles = <String>[
      'Talang Kelapa',
      'Alang-Alang Lebar',
      'Karya Baru',
      'Srijaya',
      'Total',
    ];

    final Widget text = Text(
      titles[value.toInt()],
      style: const TextStyle(
        color: Color(0xff7589a2),
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16, //margin top
      child: text,
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y1,
    double y2,
    double y3,
    double y4,
    double y5,
  ) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          color: widget.data1,
          width: width,
        ),
        BarChartRodData(
          toY: y2,
          color: widget.data2,
          width: width,
        ),
        BarChartRodData(
          toY: y3,
          color: widget.data3,
          width: width,
        ),
        BarChartRodData(
          toY: y4,
          color: widget.data4,
          width: width,
        ),
        BarChartRodData(
          toY: y5,
          color: widget.data5,
          width: width,
        ),
      ],
    );
  }
}

Widget leftTitles(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Color(0xff7589a2),
    fontWeight: FontWeight.bold,
    fontSize: 14,
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
    space: 0,
    child: Text(text, style: style),
  );
}
