import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:satudata_mobile/data/repository/api.dart';

import '../../../themes/app_fonts.dart';
import 'bloc/organisasi_bloc.dart';
import 'create_organisasi_table_screen.dart';
import 'edit_organisasi_table.dart';

class OrganisasiTableScreen extends StatefulWidget {
  const OrganisasiTableScreen({super.key});

  @override
  State<OrganisasiTableScreen> createState() => _OrganisasiTableScreenState();
}

class _OrganisasiTableScreenState extends State<OrganisasiTableScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<OrganisasiBloc>(context).add(FetchOrganisasi());
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
                SizedBox(height: 12.h),
                Text(
                  'Daftar Organisasi',
                  style: AppFonts.satuDataFonts.bodyLarge!.copyWith(
                    fontSize: 36,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const CreateOrganisasiTableScreen(),
                      ),
                    );
                  },
                  child: const Icon(Icons.create_new_folder),
                ),
                BlocListener<OrganisasiBloc, OrganisasiState>(
                  listener: (context, state) {
                    if (state is OrganisasiSuccess &&
                        state.deleteOrganisasi != null) {
                      BlocProvider.of<OrganisasiBloc>(context)
                          .add(FetchOrganisasi());
                    }
                  },
                  child: BlocBuilder<OrganisasiBloc, OrganisasiState>(
                    builder: (context, state) {
                      if (state is OrganisasiLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is OrganisasiSuccess &&
                          state.organisasi != null) {
                        return SizedBox(
                          width: 400.w,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              columns: const [
                                DataColumn(
                                  label: Text('No'),
                                ),
                                DataColumn(
                                  label: Text('Logo'),
                                ),
                                DataColumn(
                                  label: Text('Nama'),
                                ),
                                DataColumn(
                                  label: Text('Kontak'),
                                ),
                                DataColumn(
                                  label: Text('Edit'),
                                ),
                                DataColumn(
                                  label: Text('Hapus'),
                                ),
                              ],
                              rows: state.organisasi!
                                  .map(
                                    (organisasi) => DataRow(
                                      cells: [
                                        DataCell(
                                            Text(organisasi.id.toString())),
                                        DataCell(
                                          SizedBox(
                                            width: 40.w,
                                            child: Image.network(
                                                '${Api.baseUrl}${organisasi.url}'),
                                          ),
                                        ),
                                        DataCell(
                                          Text(organisasi.name!),
                                        ),
                                        DataCell(
                                          Text(organisasi.contact!),
                                        ),
                                        DataCell(
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditOrganisasiTableScreen(
                                                    organisasi: organisasi,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: const Icon(Icons.edit),
                                          ),
                                        ),
                                        DataCell(
                                          ElevatedButton(
                                            onPressed: () {
                                              BlocProvider.of<OrganisasiBloc>(
                                                      context)
                                                  .add(
                                                DeleteOrganisasi(
                                                  id: organisasi.id!,
                                                ),
                                              );
                                            },
                                            child: const Icon(Icons.delete),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        );
                      } else {
                        return const SizedBox(); // Add a default fallback widget
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
