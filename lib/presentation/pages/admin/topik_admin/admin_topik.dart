import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:satudata_mobile/presentation/pages/admin/topik_admin/create_admin_topik.dart';
import 'package:satudata_mobile/presentation/pages/admin/topik_admin/edit_admin_topik.dart';

import '../../../../data/repository/api.dart';
import '../../../themes/app_fonts.dart';
import '../../super_admin/topik_table/bloc/topic_bloc.dart';
import '../../super_admin/user_table/bloc/users_bloc.dart';

class AdminTopikScreen extends StatefulWidget {
  const AdminTopikScreen({super.key});

  @override
  State<AdminTopikScreen> createState() => _AdminTopikScreenState();
}

class _AdminTopikScreenState extends State<AdminTopikScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<UsersBloc>(context).add(FetchUsers());
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
                  'Daftar Topik',
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
                        builder: (context) => const AdminCreateTopikScreen(),
                      ),
                    );
                  },
                  child: const Icon(Icons.create_new_folder),
                ),
                BlocListener<TopicBloc, TopicState>(
                  listener: (context, state) {
                    if (state is TopicSuccess && state.deleteTopic != null) {
                      BlocProvider.of<TopicBloc>(context).add(FetchTopics());
                    }
                  },
                  child: BlocBuilder<TopicBloc, TopicState>(
                    builder: (context, state) {
                      if (state is TopicLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is TopicSuccess && state.topic != null) {
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
                                  label: Text('Icon'),
                                ),
                                DataColumn(
                                  label: Text('Label'),
                                ),
                                DataColumn(
                                  label: Text('Edit'),
                                ),
                                DataColumn(
                                  label: Text('Hapus'),
                                ),
                              ],
                              rows: state.topic!
                                  .map(
                                    (topic) => DataRow(
                                      cells: [
                                        DataCell(Text(topic.id.toString())),
                                        DataCell(
                                          SizedBox(
                                            width: 40.w,
                                            child: Image.network(
                                                '${Api.baseUrl}${topic.url}'),
                                          ),
                                        ),
                                        DataCell(Text(topic.name!)),
                                        DataCell(
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      AdminEditTopikScreen(
                                                    topic: topic,
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
                                              BlocProvider.of<TopicBloc>(
                                                      context)
                                                  .add(
                                                DeleteTopic(
                                                  id: topic.id!,
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
                      }
                      return const SizedBox(); // Added a default return statement
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
