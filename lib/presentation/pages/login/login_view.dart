import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:satudata_mobile/presentation/themes/app_colors.dart';
import 'package:satudata_mobile/presentation/themes/app_fonts.dart';

import '../../../data/repository/api_session.dart';
import 'bloc/login_bloc.dart';
import 'bloc/user_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.primaryColor,
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            _handleLoginSuccess(state.login.role!);
          } else if (state is LoginError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Email/Password salah',
                  style: AppFonts.satuDataFonts.labelLarge!.copyWith(
                    color: AppColors.ink05,
                  ),
                ),
                backgroundColor: Colors.redAccent,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        builder: (context, state) {
          return _buildLoginForm(context);
        },
      ),
    );
  }

  void _handleLoginSuccess(String role) {
    switch (role) {
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

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Login Success',
          style: AppFonts.satuDataFonts.labelLarge!.copyWith(
            color: AppColors.ink05,
          ),
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Login',
                style: AppFonts.satuDataFonts.displayLarge!.copyWith(
                  color: AppColors.ink05,
                ),
              ),
            ),
            SizedBox(height: 90.h),
            Text(
              'Email',
              style: AppFonts.satuDataFonts.titleLarge!.copyWith(
                color: AppColors.ink05,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextFormField(
              key: const Key('formFieldEmail'),
              validator: (value) {
                return null;
              },
              controller: usernameController,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.ink05,
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    width: 2,
                    color: AppColors.ink05,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: 'Masukkan Email',
                hintStyle: AppFonts.satuDataFonts.titleMedium!.copyWith(
                  color: AppColors.ink04,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              'Password',
              style: AppFonts.satuDataFonts.titleLarge!.copyWith(
                color: AppColors.ink05,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextFormField(
              obscureText: showPassword,
              key: const Key('formFieldPassword'),
              validator: (value) {
                return null;
              },
              controller: passwordController,
              decoration: InputDecoration(
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                  child: Icon(
                    showPassword ? Icons.visibility_off : Icons.visibility,
                    color:
                        showPassword ? AppColors.ink02 : AppColors.primaryColor,
                  ),
                ),
                filled: true,
                fillColor: AppColors.ink05,
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    width: 3,
                    color: AppColors.ink05,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: 'Masukkan Password',
                hintStyle: AppFonts.satuDataFonts.titleMedium!.copyWith(
                  color: AppColors.ink04,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 30.h),
            Column(
              children: [
                ElevatedButton(
                  key: const Key('btnLogin'),
                  onPressed: () => login(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.ink01,
                    minimumSize: const Size.fromHeight(50),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Submit',
                    style: AppFonts.satuDataFonts.titleMedium!.copyWith(
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                ElevatedButton(
                  key: const Key('btnForget'),
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.ink01,
                    minimumSize: const Size.fromHeight(50),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Lupa Password?',
                    style: AppFonts.satuDataFonts.titleMedium!.copyWith(
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void login(BuildContext context) async {
    String username = usernameController.text;
    String password = passwordController.text;
    var loginBloc = BlocProvider.of<LoginBloc>(context);
    var userBloc = BlocProvider.of<UserBloc>(context);
    var userGet = await ApiSession.getUser();
    loginBloc.add(Login(password: password, email: username));
    userBloc.add(SetUser(user: userGet));
  }
}
