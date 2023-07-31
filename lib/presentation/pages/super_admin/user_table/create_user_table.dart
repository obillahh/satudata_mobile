import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:satudata_mobile/data/models/user/response_user.dart';
import 'package:satudata_mobile/presentation/pages/super_admin/user_table/bloc/users_bloc.dart';

import '../../../../data/models/organization/response_organization.dart';
import '../../../themes/app_colors.dart';
import '../../../themes/app_fonts.dart';
import '../organisasi_table/bloc/organisasi_bloc.dart';

class CreateUserTableScreen extends StatefulWidget {
  const CreateUserTableScreen({super.key});

  @override
  State<CreateUserTableScreen> createState() => _CreateUserTableScreenState();
}

class _CreateUserTableScreenState extends State<CreateUserTableScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameUser = TextEditingController();
  TextEditingController emailUser = TextEditingController();
  TextEditingController passwordUser = TextEditingController();
  TextEditingController confirmPasswordUser = TextEditingController();
  List<ResponseOrganization> organizations = [];
  String? selectedOrganizationId;
  String? role;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<OrganisasiBloc>(context).add(FetchOrganisasi());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UsersBloc, UsersState>(
      listener: (context, state) {
        if (state is UsersSuccess) {
          context.pushReplacement('/superadmin_dashboard');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Create Successed'),
              backgroundColor: Colors.greenAccent,
              behavior: SnackBarBehavior.floating,
            ),
          );
        } else if (state is OrganisasiError) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Create Failed'),
              backgroundColor: Colors.redAccent,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.all(20.w),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Text(
                    'Create User',
                    style: AppFonts.satuDataFonts.displaySmall!.copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 40.h),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Isi Nama';
                      }
                      return null;
                    },
                    key: const Key('textFieldName'),
                    controller: nameUser,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      labelText: 'Nama',
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
                        return 'Isi Email';
                      }
                      return null;
                    },
                    key: const Key('textFieldEmail'),
                    controller: emailUser,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email',
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
                        return 'Isi Password';
                      }
                      return null;
                    },
                    key: const Key('textFieldPassword'),
                    controller: passwordUser,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: const InputDecoration(
                      labelText: 'Password',
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
                        return 'Isi Confirm Password';
                      }
                      return null;
                    },
                    key: const Key('textFieldConfirmPassword'),
                    controller: confirmPasswordUser,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: const InputDecoration(
                      labelText: 'Confirm Password',
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
                  name: nameUser.text,
                  email: emailUser.text,
                  role: role ?? '',
                  organizationId: int.tryParse(
                    selectedOrganizationId ?? '',
                  ),
                );
                context.read<UsersBloc>().add(
                      CreateUser(
                        user: user,
                        password: passwordUser.text,
                        confPassword: confirmPasswordUser.text,
                      ),
                    );
              }
            },
          ),
        );
      },
    );
  }
}
