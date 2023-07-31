import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../themes/app_colors.dart';

class SatuDataAppBar extends StatelessWidget {
  const SatuDataAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: AppColors.ink05,
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 90,
            child: ElevatedButton(
              onPressed: () {
                context.push('/login');
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text('Login'),
            ),
          ),
        ),
      ],
      title: Image.asset(
        'assets/images/logo.png',
        fit: BoxFit.cover,
        width: 160,
      ),
    );
  }
}
