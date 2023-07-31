import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:satudata_mobile/data/models/dataset/response_dataset.dart';

import '../../../../data/models/organization/response_organization.dart';
import '../../../themes/app_colors.dart';
import '../../../themes/app_fonts.dart';
import '../organisasi_table/bloc/organisasi_bloc.dart';
import 'bloc/dataset_bloc.dart';

class CreateDatasetTableScreen extends StatefulWidget {
  const CreateDatasetTableScreen({Key? key}) : super(key: key);

  @override
  State<CreateDatasetTableScreen> createState() =>
      _CreateDatasetTableScreenState();
}

class _CreateDatasetTableScreenState extends State<CreateDatasetTableScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController titleDataset = TextEditingController();
  TextEditingController descriprion = TextEditingController();
  TextEditingController frekuensiPenerbitan = TextEditingController();
  TextEditingController cakupan = TextEditingController();
  TextEditingController penyajian = TextEditingController();
  List<ResponseOrganization> organizations = [];
  String? selectedOrganizationId;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<OrganisasiBloc>(context).add(FetchOrganisasi());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DatasetBloc, DatasetState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20.w),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Create Dataset',
                        style: AppFonts.satuDataFonts.displaySmall!.copyWith(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 40.h),
                      const Text('Organization : '),
                      SizedBox(height: 4.h),
                      BlocConsumer<OrganisasiBloc, OrganisasiState>(
                        listener: (context, state) {
                          if (state is OrganisasiSuccess) {
                            setState(() {
                              organizations = state.organisasi!;
                            });
                          }
                        },
                        builder: (context, state) {
                          return Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: AppColors.ink04, //<-- SEE HERE
                            ),
                            child: DropdownButton<String>(
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
                              dropdownColor: AppColors.ink05,
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 24.h),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Isi Judul';
                          }
                          return null;
                        },
                        key: const Key('textFieldTitle'),
                        controller: titleDataset,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          labelText: 'Judul',
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
                            return 'Isi Deskripsi';
                          }
                          return null;
                        },
                        key: const Key('textFieldDescription'),
                        controller: descriprion,
                        keyboardType: TextInputType.name,
                        maxLines: 5,
                        decoration: const InputDecoration(
                          labelText: 'Deskripsi Dataset',
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
                            return 'Isi Frekuensi Penerbitan';
                          }
                          return null;
                        },
                        key: const Key('textFieldFrekuensiPenerbitan'),
                        controller: frekuensiPenerbitan,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          labelText: 'Frekuensi Penerbitan',
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
                            return 'Isi Cakupan';
                          }
                          return null;
                        },
                        key: const Key('textFieldCakupan'),
                        controller: cakupan,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          labelText: 'Cakupan',
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
                            return 'Isi Penyajian';
                          }
                          return null;
                        },
                        key: const Key('textFieldPenyajian'),
                        controller: penyajian,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          labelText: 'Penyajian',
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
                      SizedBox(height: 12.h),
                    ],
                  ),
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppColors.primaryColor,
            child: const Icon(Icons.save),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                final dataset = ResponseDataset(
                  title: titleDataset.text,
                );
                context
                    .read<DatasetBloc>()
                    .add(CreateDataset(createDataset: dataset));
              }
            },
          ),
        );
      },
      listener: (context, state) {
        if (state is DatasetSuccess) {
          context.pushReplacement('/superadmin_dashboard');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Create Successed'),
              backgroundColor: Colors.greenAccent,
              behavior: SnackBarBehavior.floating,
            ),
          );
        } else if (state is DatasetFail) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Create Failed'),
              backgroundColor: Colors.redAccent,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
    );
  }
}
