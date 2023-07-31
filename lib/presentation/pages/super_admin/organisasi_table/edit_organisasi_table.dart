import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:satudata_mobile/presentation/themes/app_colors.dart';
import 'package:satudata_mobile/presentation/themes/app_fonts.dart';

import '../../../../data/models/organization/response_organization.dart';
import 'bloc/organisasi_bloc.dart';

class EditOrganisasiTableScreen extends StatefulWidget {
  final ResponseOrganization organisasi;
  const EditOrganisasiTableScreen({Key? key, required this.organisasi})
      : super(key: key);

  @override
  State<EditOrganisasiTableScreen> createState() =>
      _EditOrganisasiTableScreenState();
}

class _EditOrganisasiTableScreenState extends State<EditOrganisasiTableScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameOrganisasi = TextEditingController();
  TextEditingController contactOrganisasi = TextEditingController();
  String dropdownValue = 'kecamatan';
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
    super.initState();
    nameOrganisasi.text = widget.organisasi.name ?? '';
    contactOrganisasi.text = widget.organisasi.contact ?? '';
    dropdownValue = widget.organisasi.type ?? 'kecamatan';
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrganisasiBloc, OrganisasiState>(
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
                    'Edit Organisasi',
                    style: AppFonts.satuDataFonts.displaySmall!.copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 40.h),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Isi Nama Organisasi';
                      }
                      return null;
                    },
                    key: const Key('textFieldName'),
                    controller: nameOrganisasi,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      labelText: 'Nama Organisasi',
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
                      const Text('Upload Logo : '),
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
                  SizedBox(height: 12.h),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Isi Contact';
                      }
                      return null;
                    },
                    key: const Key('textFieldContact'),
                    controller: contactOrganisasi,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      labelText: 'Contact Organisasi',
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text('Type : '),
                      SizedBox(width: 30.w),
                      DropdownButton<String>(
                        value: dropdownValue,
                        items: const [
                          DropdownMenuItem<String>(
                            value: 'kecamatan',
                            child: Text('Kecamatan'),
                          ),
                          DropdownMenuItem<String>(
                            value: 'opd',
                            child: Text('OPD'),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            dropdownValue = value!;
                          });
                        },
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
                final organization = ResponseOrganization(
                  id: widget.organisasi.id, // Set the id field
                  name: nameOrganisasi.text,
                  url: image != null ? image!.path : null,
                  contact: contactOrganisasi.text,
                  type: dropdownValue,
                );
                context
                    .read<OrganisasiBloc>()
                    .add(EditOrganisasi(organization: organization));
              }
            },
          ),
        );
      },
      listener: (context, state) {
        if (state is OrganisasiSuccess) {
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
