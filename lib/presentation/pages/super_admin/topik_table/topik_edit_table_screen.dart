import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:satudata_mobile/data/models/topic/response_topic.dart';
import 'package:satudata_mobile/presentation/pages/super_admin/topik_table/bloc/topic_bloc.dart';

import '../../../themes/app_colors.dart';
import '../../../themes/app_fonts.dart';

class EditTopicTableScreen extends StatefulWidget {
  final ResponseTopic topic;
  const EditTopicTableScreen({super.key, required this.topic});

  @override
  State<EditTopicTableScreen> createState() => _EdtiTopicTableScreenState();
}

class _EdtiTopicTableScreenState extends State<EditTopicTableScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController topicLabel = TextEditingController();
  File? image;

  void pickImage() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      File file = File(result.files.single.path!);
      setState(() {
        image = file;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    topicLabel.text = widget.topic.name ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TopicBloc, TopicState>(
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.all(20.0.w),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Edit Topik',
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
                    key: const Key('textFielLabel'),
                    controller: topicLabel,
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
                      const Text('Upload Icon : '),
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
                final topic = ResponseTopic(
                  id: widget.topic.id,
                  name: topicLabel.text,
                  url: image != null ? image!.path : null,
                );
                context.read<TopicBloc>().add(EditTopic(topic: topic));
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
