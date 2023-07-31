import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../themes/app_fonts.dart';
import 'bloc/users_bloc.dart';
import 'create_user_table.dart';

class UserTableScreen extends StatefulWidget {
  const UserTableScreen({super.key});

  @override
  State<UserTableScreen> createState() => _UserTableScreenState();
}

class _UserTableScreenState extends State<UserTableScreen> {
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
                  'Daftar User',
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
                        builder: (context) => const CreateUserTableScreen(),
                      ),
                    );
                  },
                  child: const Icon(Icons.create_new_folder),
                ),
                BlocBuilder<UsersBloc, UsersState>(
                  builder: (context, state) {
                    if (state is UsersLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is UsersSuccess && state.user != null) {
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
                                label: Text('Name'),
                              ),
                              DataColumn(
                                label: Text('Email'),
                              ),
                              DataColumn(
                                label: Text('Role'),
                              ),
                              DataColumn(
                                label: Text('Hapus'),
                              ),
                            ],
                            rows: state.user!
                                .map(
                                  (user) => DataRow(
                                    cells: [
                                      DataCell(Text(user.id.toString())),
                                      DataCell(
                                        SizedBox(
                                          width: 120.w,
                                          child: Text(
                                            user.name!,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                      DataCell(Text(user.email!)),
                                      DataCell(Text(user.role!)),
                                      DataCell(
                                        ElevatedButton(
                                          onPressed: () {
                                            BlocProvider.of<UsersBloc>(context)
                                                .add(
                                              DeleteUser(id: user.id!),
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
                    } else if (state is UsersFail) {
                      return Center(
                        child: Text(state.errorMessage),
                      );
                    }
                    return const Center(
                      child: Text('Users empty'),
                    );
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
