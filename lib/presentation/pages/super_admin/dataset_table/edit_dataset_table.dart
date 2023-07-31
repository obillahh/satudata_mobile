import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../data/models/dataset/response_dataset.dart';
import '../../../themes/app_colors.dart';
import '../../../themes/app_fonts.dart';
import 'bloc/dataset_bloc.dart';

class EditDatasetTableScreen extends StatefulWidget {
  const EditDatasetTableScreen({super.key});

  @override
  State<EditDatasetTableScreen> createState() => _EditDatasetTableScreenState();
}

class _EditDatasetTableScreenState extends State<EditDatasetTableScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController titleDataset = TextEditingController();
  TextEditingController description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DatasetBloc, DatasetState>(
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.all(20.w),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Create Dataset',
                    style: AppFonts.satuDataFonts.displaySmall!.copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 40.h),
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
                    controller: description,
                    keyboardType: TextInputType.name,
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
                  SizedBox(height: 12.h),
                ],
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
