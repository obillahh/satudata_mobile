import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:satudata_mobile/presentation/widget/appbar_widget.dart';
import 'package:satudata_mobile/presentation/widget/data_statistik_widget.dart';

import '../../super_admin/topik_table/bloc/topic_bloc.dart';

class TopikScreen extends StatefulWidget {
  const TopikScreen({super.key});

  @override
  State<TopikScreen> createState() => _TopikScreenState();
}

class _TopikScreenState extends State<TopikScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<TopicBloc>(context).add(FetchTopicsWithToken());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: SatuDataAppBar(),
      ),
      body: BlocBuilder<TopicBloc, TopicState>(
        builder: (context, state) {
          if (state is TopicLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TopicSuccess) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 18,
                ),
                itemBuilder: (context, index) {
                  final topic = state.topic![index];
                  return DataStatistikWidget(
                    fontSize: 16.sp,
                    dataTopic: topic,
                    scaleSizeLogo: 60.w,
                  );
                },
                itemCount: state.topic!.length,
              ),
            );
          } else if (state is TopicFail) {
            return Center(
              child: Text(state.errorMessage),
            );
          }
          return const Center(
            child: Text('Topic empty'),
          );
        },
      ),
    );
  }
}
