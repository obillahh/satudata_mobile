import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:satudata_mobile/presentation/widget/appbar_widget.dart';

import '../../../widget/organisasi_widget.dart';
import '../../super_admin/organisasi_table/bloc/organisasi_bloc.dart';

class OrganisasiScreen extends StatefulWidget {
  const OrganisasiScreen({super.key});

  @override
  State<OrganisasiScreen> createState() => _OrganisasiScreenState();
}

class _OrganisasiScreenState extends State<OrganisasiScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<OrganisasiBloc>(context).add(FetchOrganisasiWithToken());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: const SatuDataAppBar(),
      ),
      body: BlocBuilder<OrganisasiBloc, OrganisasiState>(
        builder: (context, state) {
          if (state is OrganisasiLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is OrganisasiSuccess) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                ),
                itemBuilder: (context, index) {
                  final organisasi = state.organisasi![index];
                  return OrganisasiWidget(
                    fontSize: 12.sp,
                    height: 4.h,
                    dataset: '0 Dataset',
                    fontSizeDataset: 12.sp,
                    scaleSizeImage: 60.w,
                    dataOrganisasi: organisasi,
                  );
                },
                itemCount: state.organisasi!.length,
              ),
            );
          } else if (state is OrganisasiError) {
            return Center(
              child: Text(state.errorMessage),
            );
          }
          return const Center(
            child: Text('Organization empty'),
          );
        },
      ),
    );
  }
}
