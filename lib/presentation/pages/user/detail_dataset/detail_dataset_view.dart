import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:satudata_mobile/presentation/themes/app_colors.dart';
import 'package:satudata_mobile/presentation/themes/app_fonts.dart';

class DetailDatasetScreen extends StatelessWidget {
  const DetailDatasetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dataset Detail',
          style: AppFonts.satuDataFonts.titleLarge!.copyWith(
            fontSize: 20.sp,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 4.h),
              Text(
                'Jumlah Sekolah, Guru dan Murid Sekolah Menengah Atas (SMA) dibawah Kementerian Pendidikan dan Kebudayaan Menurut Kelurahan di Kecamatan Ilir Timur Dua',
                style: AppFonts.satuDataFonts.titleLarge!.copyWith(
                  color: AppColors.primaryColor,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 20.h),
              Text(
                'Deskripsi : ',
                style: AppFonts.satuDataFonts.bodyLarge!.copyWith(
                  color: AppColors.ink01,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Jumlah Sekolah, Guru dan Murid Sekolah Menengah Atas (SMA) dibawah Kementerian Pendidikan dan Kebudayaan Menurut Kelurahan di Kecamatan Ilir Timur Dua',
                style: AppFonts.satuDataFonts.bodyLarge!.copyWith(
                  color: AppColors.ink01,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                'Download',
                style: AppFonts.satuDataFonts.bodyLarge!.copyWith(
                  color: AppColors.ink02,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.ink03,
                      fixedSize: Size(80.w, 30.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Excel',
                      style: AppFonts.satuDataFonts.labelLarge,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.ink03,
                      fixedSize: Size(80.w, 30.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'CSV',
                      style: AppFonts.satuDataFonts.labelLarge,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.ink03,
                      fixedSize: Size(80.w, 30.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'JSON',
                      style: AppFonts.satuDataFonts.labelLarge,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.push('/organisasi/seluruh-data');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      fixedSize: Size(80.w, 30.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Data',
                      style: AppFonts.satuDataFonts.labelLarge,
                    ),
                  ),
                ],
              ),
              DataTable(
                columns: const [
                  DataColumn(
                    label: Text('Field'),
                  ),
                  DataColumn(
                    label: Text('Value'),
                  ),
                ],
                rows: const [
                  DataRow(
                    cells: [
                      DataCell(Text('Sumber')),
                      DataCell(Text('Kecamatan Alang-alang Lebar')),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(Text('Terakhir Diperbaharui')),
                      DataCell(Text('Senin, 5 Juni 2023')),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(Text('Dibuat')),
                      DataCell(Text('Senin, 29 Mei 2023')),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(Text('Frekuensi Penerbit')),
                      DataCell(Text('1 Tahun Sekali')),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(Text('Cakupan')),
                      DataCell(Text('Kecamatan Alang-alang lebar')),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(Text('Penyajian')),
                      DataCell(Text('Kelurahan')),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(Text('Kontak')),
                      DataCell(Text('kec_aal.satudata@palembang.go.id')),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
