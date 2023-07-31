import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:satudata_mobile/presentation/pages/login/bloc/user_bloc.dart';
import 'package:satudata_mobile/presentation/pages/super_admin/topik_table/bloc/topic_bloc.dart';

import '../../../../data/models/organization/response_organization.dart';
import '../../../../data/models/user/response_user.dart';
import '../../../themes/app_colors.dart';
import '../../../themes/app_fonts.dart';
import '../organisasi_table/bloc/organisasi_bloc.dart';
import 'bloc/users_bloc.dart';

class EditUserTableScreen extends StatefulWidget {
  final User user;
  const EditUserTableScreen({super.key, required this.user});

  @override
  State<EditUserTableScreen> createState() => _EditUserTableScreenState();
}

class _EditUserTableScreenState extends State<EditUserTableScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController userName = TextEditingController();
  TextEditingController userEmail = TextEditingController();
  List<ResponseOrganization> organizations = [];
  String? selectedOrganizationId;
  String? role;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userName.text = widget.user.name ?? '';
    userEmail.text = widget.user.email ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.all(20.0.w),
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Edit User',
                    style: AppFonts.satuDataFonts.displaySmall!.copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 40.h),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Isi Nama User';
                      }
                      return null;
                    },
                    key: const Key('textFieldName'),
                    controller: userName,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.ink01,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Isi Email User';
                      }
                      return null;
                    },
                    key: const Key('textFieldEmail'),
                    controller: userEmail,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.ink01,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text('Organization : '),
                      Expanded(
                        child: BlocConsumer<OrganisasiBloc, OrganisasiState>(
                          listener: (context, state) {
                            if (state is OrganisasiSuccess) {
                              setState(() {
                                organizations = state.organisasi!;
                              });
                            }
                          },
                          builder: (context, state) {
                            return DropdownButton<String>(
                              value: selectedOrganizationId,
                              items: organizations.map((organization) {
                                return DropdownMenuItem<String>(
                                  value: organization.id.toString(),
                                  child: Text(organization.name!),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedOrganizationId = value;
                                });
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text('Role : '),
                      SizedBox(width: 30.w),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RadioListTile(
                              title: const Text('Super Admin'),
                              value: 'ROLE_SUPERADMIN',
                              groupValue: role,
                              onChanged: (value) {
                                setState(() {
                                  role = value;
                                });
                              },
                            ),
                            RadioListTile(
                              title: const Text('Admin'),
                              value: 'ROLE_ADMIN',
                              groupValue: role,
                              onChanged: (value) {
                                setState(() {
                                  role = value;
                                });
                              },
                            ),
                            RadioListTile(
                              title: const Text('User'),
                              value: 'ROLE_USER',
                              groupValue: role,
                              onChanged: (value) {
                                setState(() {
                                  role = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppColors.primaryColor,
            child: const Icon(Icons.save),
            onPressed: () {
              if (formKey.currentState != null &&
                  formKey.currentState!.validate()) {
                final user = User(
                  name: userEmail.text,
                  email: userEmail.text,
                  role: role ?? '',
                  organizationId: int.tryParse(
                    selectedOrganizationId ?? '',
                  ),
                );
                context.read<UsersBloc>().add(
                      CreateUser(
                        user: user,
                      ),
                    );
              }
            },
          ),
        );
      },
      listener: (context, state) {
        if (state is TopicSuccess) {
          context.pushReplacement('/superadmin_dashboard');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Edit Success'),
            ),
          );
        }
      },
    );
  }
}
