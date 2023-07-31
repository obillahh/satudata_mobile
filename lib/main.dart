import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:satudata_mobile/presentation/config/app_router_config.dart';
import 'package:satudata_mobile/presentation/pages/login/bloc/login_bloc.dart';
import 'package:satudata_mobile/presentation/pages/login/bloc/user_bloc.dart';
import 'package:satudata_mobile/presentation/pages/super_admin/dataset_table/bloc/dataset_bloc.dart';
import 'package:satudata_mobile/presentation/pages/super_admin/topik_table/bloc/topic_bloc.dart';
import 'package:satudata_mobile/presentation/pages/super_admin/user_table/bloc/users_bloc.dart';
import 'package:satudata_mobile/presentation/themes/app_colors.dart';

import 'presentation/pages/super_admin/organisasi_table/bloc/organisasi_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<OrganisasiBloc>(
          create: (context) => OrganisasiBloc()
            ..add(FetchOrganisasi())
            ..add(FetchOrganisasiWithToken()),
        ),
        BlocProvider<TopicBloc>(
          create: (context) => TopicBloc()
            ..add(FetchTopics())
            ..add(FetchTopicsWithToken()),
        ),
        BlocProvider<DatasetBloc>(
          create: (context) => DatasetBloc()
            ..add(FetchDatasets())
            ..add(FetchDatasetsWithToken()),
        ),
        BlocProvider<UsersBloc>(
          create: (context) => UsersBloc()..add(FetchUsers()),
        ),
        BlocProvider<LoginBloc>(create: (context) => LoginBloc()),
        BlocProvider<UserBloc>(create: (context) => UserBloc()),
      ],
      child: ScreenUtilInit(
        builder: (context, child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Satu Data Mobile',
            theme: ThemeData(
              textTheme: GoogleFonts.interTextTheme(
                Theme.of(context).textTheme,
              ),
              colorScheme: ColorScheme.fromSwatch().copyWith(
                primary: AppColors.primaryColor,
              ),
            ),
            routerConfig: router,
          );
        },
      ),
    );
  }
}
