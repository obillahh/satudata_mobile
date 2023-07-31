import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:satudata_mobile/presentation/pages/super_admin/dataset_table/bloc/dataset_bloc.dart';

import '../../../themes/app_fonts.dart';
import 'create_dataset_table.dart';

class DatasetTableScreen extends StatefulWidget {
  const DatasetTableScreen({super.key});

  @override
  State<DatasetTableScreen> createState() => _DatasetTableScreenState();
}

class _DatasetTableScreenState extends State<DatasetTableScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<DatasetBloc>(context).add(FetchDatasets());
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
                  'Daftar Dataset',
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
                        builder: (context) => const CreateDatasetTableScreen(),
                      ),
                    );
                  },
                  child: const Icon(Icons.create_new_folder),
                ),
                BlocBuilder<DatasetBloc, DatasetState>(
                  builder: (context, state) {
                    if (state is DatasetLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is DatasetSuccess &&
                        state.listDataset != null) {
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
                                label: Text('Judul'),
                              ),
                              DataColumn(
                                label: Text('Organisasi'),
                              ),
                              DataColumn(
                                label: Text('Topik'),
                              ),
                              DataColumn(
                                label: Text('Edit'),
                              ),
                              DataColumn(
                                label: Text('Hapus'),
                              ),
                              DataColumn(
                                label: Text('Status'),
                              ),
                            ],
                            rows: state.listDataset!
                                .map(
                                  (dataset) => DataRow(
                                    cells: [
                                      DataCell(Text(dataset.id.toString())),
                                      DataCell(
                                        SizedBox(
                                          width: 200.w,
                                          child: Text(
                                            dataset.title!,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        Text(
                                          dataset.organization?.name! ?? '',
                                        ),
                                      ),
                                      DataCell(
                                        Text(
                                          dataset.organization?.name! ?? '',
                                        ),
                                      ),
                                      DataCell(
                                        ElevatedButton(
                                          onPressed: () {},
                                          child: const Icon(Icons.edit),
                                        ),
                                      ),
                                      DataCell(
                                        ElevatedButton(
                                          onPressed: () {},
                                          child: const Icon(Icons.delete),
                                        ),
                                      ),
                                      DataCell(
                                        ElevatedButton(
                                          onPressed: () {},
                                          child:
                                              const Icon(Icons.visibility_off),
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
                      return const SizedBox();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
