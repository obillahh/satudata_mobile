import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:satudata_mobile/presentation/pages/admin/dataset_admin/admin_dataset.dart';
import 'package:satudata_mobile/presentation/pages/admin/organisasi_admin/admin_organisasi.dart';
import 'package:satudata_mobile/presentation/pages/admin/topik_admin/admin_topik.dart';

import '../../../../data/repository/api_session.dart';
import '../../../themes/app_colors.dart';
import '../../../themes/app_fonts.dart';
import '../dashboard_admin/admin_dasboard.dart';

class AdminDrawerDashboard extends StatefulWidget {
  const AdminDrawerDashboard({super.key});

  @override
  State<AdminDrawerDashboard> createState() => _DrawerDashboardState();
}

class _DrawerDashboardState extends State<AdminDrawerDashboard> {
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
        const AdminDashboardScreen(),
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
        const AdminDatasetScreen(),
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
        const AdminOrganisasiScreen(),
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
        const AdminTopikScreen(),
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
