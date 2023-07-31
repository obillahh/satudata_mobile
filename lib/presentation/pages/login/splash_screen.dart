import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:satudata_mobile/data/repository/api_session.dart';

import 'bloc/user_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  checkLogin() async {
    var userBloc = BlocProvider.of<UserBloc>(context);
    var user = await ApiSession.getUser();
    if (user.accessToken == null) {
      Timer(const Duration(seconds: 2), () {
        context.go('/home');
      });
    } else {
      userBloc.add(SetUser(user: user));
      Timer(const Duration(seconds: 2), () {
        switch (user.role) {
          case "ROLE_SUPERADMIN":
            context.go('/superadmin-dashboard');
            break;
          case "ROLE_ADMIN":
            context.go('/admin-dashboard');
            break;
          case "ROLE_USER":
            context.go('/user-dashboard');
            break;
          default:
            break;
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      checkLogin();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        key: const Key('screenSplashScreen'),
        bottom: false,
        child: Center(
          child: Image.asset(
            'assets/images/satudata.png',
            key: const Key('logo'),
          ),
        ),
      ),
    );
  }
}
