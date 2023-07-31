import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:satudata_mobile/presentation/themes/app_fonts.dart';

import '../themes/app_colors.dart';

class SatuDataBotNav extends StatefulWidget {
  const SatuDataBotNav({
    super.key,
    required this.child,
  });

  final Widget? child;

  @override
  State<SatuDataBotNav> createState() => _SatuDataBotNavState();
}

class _SatuDataBotNavState extends State<SatuDataBotNav> {
  int _selectedIndex = 0;
  static final tabs = [
    GButton(
      icon: Icons.home,
      text: 'Beranda',
      textStyle: AppFonts.satuDataFonts.labelLarge!.copyWith(
        color: AppColors.ink05,
      ),
    ),
    GButton(
      icon: Icons.group,
      text: 'Organisasi',
      textStyle: AppFonts.satuDataFonts.labelLarge!.copyWith(
        color: AppColors.ink05,
      ),
    ),
    GButton(
      icon: Icons.newspaper,
      text: 'Topik',
      textStyle: AppFonts.satuDataFonts.labelLarge!.copyWith(
        color: AppColors.ink05,
      ),
    ),
    GButton(
      icon: Icons.public,
      text: 'Publikasi',
      textStyle: AppFonts.satuDataFonts.labelLarge!.copyWith(
        color: AppColors.ink05,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: widget.child!),
      bottomNavigationBar: Container(
        color: AppColors.ink05,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: GNav(
            selectedIndex: _selectedIndex,
            color: AppColors.ink01,
            activeColor: AppColors.ink05,
            tabBackgroundColor: AppColors.primaryColor,
            backgroundColor: AppColors.ink05,
            padding: const EdgeInsets.all(16),
            gap: 8,
            onTabChange: (index) {
              setState(
                () {
                  _selectedIndex = index;
                  switch (index) {
                    case 0:
                      context.go('/home');
                      break;
                    case 1:
                      context.go('/organisasi');
                      break;
                    case 2:
                      context.go('/topik');
                      break;
                    case 3:
                      context.go('/publikasi');
                      break;
                  }
                },
              );
            },
            tabs: tabs,
          ),
        ),
      ),
    );
  }
}
