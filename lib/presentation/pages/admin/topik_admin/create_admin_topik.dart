import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../data/models/topic/response_topic.dart';
import '../../../themes/app_colors.dart';
import '../../../themes/app_fonts.dart';
import '../../super_admin/topik_table/bloc/topic_bloc.dart';

class AdminCreateTopikScreen extends StatefulWidget {
  const AdminCreateTopikScreen({super.key});

  @override
  State<AdminCreateTopikScreen> createState() => _AdminCreateTopikScreenState();
}

class _AdminCreateTopikScreenState extends State<AdminCreateTopikScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController labelTopic = TextEditingController();
  File? image;

  void pickImage() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null && result.files.isNotEmpty) {
      File file = File(result.files.single.path!);
      setState(() {
        image = file;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TopicBloc, TopicState>(
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
                    'Create Label',
                    style: AppFonts.satuDataFonts.displaySmall!.copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 40.h),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Isi Label';
                      }
                      return null;
                    },
                    key: const Key('textFieldLabel'),
                    controller: labelTopic,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      labelText: 'Label',
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text('Upload Icon: '),
                      SizedBox(width: 20.w),
                      Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              pickImage();
                            },
                            child: const Text('Pilih File'),
                          ),
                          if (image != null)
                            Image.file(
                              image!,
                              scale: 6.r,
                            ),
                        ],
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
              if (formKey.currentState!.validate()) {
                final create = ResponseTopic(
                  name: labelTopic.text,
                  url: image != null ? image!.path : null,
                );
                context.read<TopicBloc>().add(CreateTopic(createTopic: create));
              }
            },
          ),
        );
      },
      listener: (context, state) {
        if (state is TopicSuccess) {
          context.pushReplacement('/admin_dashboard');
        }
      },
    );
  }
}
