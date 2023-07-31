import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:satudata_mobile/data/repository/api_session.dart';
import 'package:satudata_mobile/presentation/themes/app_colors.dart';
import 'package:satudata_mobile/presentation/themes/app_fonts.dart';

import '../dashboard/dashboard_screen.dart';
import '../dataset_table/dataset_table_screen.dart';
import '../organisasi_table/organisasi_table_screen.dart';
import '../topik_table/topik_table_screen.dart';
import '../user_table/user_table_screen.dart';

class SuperAdminDrawerDashboard extends StatefulWidget {
  const SuperAdminDrawerDashboard({super.key});

  @override
  State<SuperAdminDrawerDashboard> createState() => _DrawerDashboardState();
}

class _DrawerDashboardState extends State<SuperAdminDrawerDashboard> {
  List<ScreenHiddenDrawer> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages = [
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'Dashboard',
          baseStyle: AppFonts.satuDataFonts.headlineMedium!.copyWith(
            color: AppColors.ink01,
          ),
          selectedStyle: AppFonts.satuDataFonts.headlineMedium!.copyWith(
            color: AppColors.ink05,
            fontWeight: FontWeight.bold,
          ),
        ),
        const DashboardScreen(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'Dataset',
          baseStyle: AppFonts.satuDataFonts.headlineMedium!.copyWith(
            color: AppColors.ink01,
          ),
          selectedStyle: AppFonts.satuDataFonts.headlineMedium!.copyWith(
            color: AppColors.ink05,
            fontWeight: FontWeight.bold,
          ),
        ),
        const DatasetTableScreen(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'Organisasi',
          baseStyle: AppFonts.satuDataFonts.headlineMedium!.copyWith(
            color: AppColors.ink01,
          ),
          selectedStyle: AppFonts.satuDataFonts.headlineMedium!.copyWith(
            color: AppColors.ink05,
            fontWeight: FontWeight.bold,
          ),
        ),
        const OrganisasiTableScreen(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'Topik',
          baseStyle: AppFonts.satuDataFonts.headlineMedium!.copyWith(
            color: AppColors.ink01,
          ),
          selectedStyle: AppFonts.satuDataFonts.headlineMedium!.copyWith(
            color: AppColors.ink05,
            fontWeight: FontWeight.bold,
          ),
        ),
        const TopikTableScreen(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'User',
          baseStyle: AppFonts.satuDataFonts.headlineMedium!.copyWith(
            color: AppColors.ink01,
          ),
          selectedStyle: AppFonts.satuDataFonts.headlineMedium!.copyWith(
            color: AppColors.ink05,
            fontWeight: FontWeight.bold,
          ),
        ),
        const UserTableScreen(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return HiddenDrawerMenu(
      actionsAppBar: [
        IconButton(
          onPressed: () {
            ApiSession.clearUser();
            context.go('/home');
          },
          icon: const Icon(Icons.logout),
        ),
      ],
      screens: _pages,
      backgroundColorMenu: AppColors.primaryColor,
      initPositionSelected: 0,
    );
  }
}
