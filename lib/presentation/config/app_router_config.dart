import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:satudata_mobile/presentation/config/app_router_constants.dart';
import 'package:satudata_mobile/presentation/widget/botnav_widget.dart';

import '../pages/admin/widgets/drawer_admin_dashboard.dart';
import '../pages/login/login_view.dart';
import '../pages/login/splash_screen.dart';
import '../pages/super_admin/widgets/drawer_dashboard.dart';
import '../pages/user/detail_dataset/detail_dataset_view.dart';
import '../pages/user/detail_dataset/seluruh_data_view.dart';
import '../pages/user/home/home_view.dart';
import '../pages/user/organisasi/dataset_organisasi_view.dart';
import '../pages/user/organisasi/organisasi_view.dart';
import '../pages/user/publikasi/publikasi_view.dart';
import '../pages/user/topik/dataset_topik_view.dart';
import '../pages/user/topik/topik_view.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _bottomNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  initialLocation: '/splash',
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  routes: [
    ShellRoute(
      navigatorKey: _bottomNavigatorKey,
      pageBuilder: (context, state, child) {
        return NoTransitionPage(
          child: SatuDataBotNav(
            child: child,
          ),
        );
      },
      routes: [
        GoRoute(
          path: '/home',
          parentNavigatorKey: _bottomNavigatorKey,
          name: SatuDataRoute.homeRouteName,
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/organisasi',
          parentNavigatorKey: _bottomNavigatorKey,
          name: SatuDataRoute.organisasiRouteName,
          builder: (context, state) => const OrganisasiScreen(),
          routes: [
            GoRoute(
              path: 'dataset-organisasi',
              name: SatuDataRoute.datasetOrganisasiRouteName,
              builder: (context, state) => const DatasetOrganisasiScreen(),
            ),
            GoRoute(
              path: 'detail-dataset',
              name: SatuDataRoute.detailDatasetRouteName,
              builder: (context, state) => const DetailDatasetScreen(),
            ),
            GoRoute(
              path: 'seluruh-data',
              name: SatuDataRoute.seluruhDataRouteName,
              builder: (context, state) => const SeluruhData(),
            ),
          ],
        ),
        GoRoute(
          path: '/topik',
          parentNavigatorKey: _bottomNavigatorKey,
          name: SatuDataRoute.topikRouteName,
          builder: (context, state) => const TopikScreen(),
          routes: [
            GoRoute(
              path: 'dataset-topik',
              name: SatuDataRoute.datasetTopikRouteName,
              builder: (context, state) => const DatasetTopikScreen(),
            ),
          ],
        ),
        GoRoute(
          path: '/publikasi',
          parentNavigatorKey: _bottomNavigatorKey,
          name: SatuDataRoute.publikasiRouteName,
          builder: (context, state) => const PublikasiScreen(),
        ),
      ],
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/splash', // Add the path for the splash screen
      name: SatuDataRoute
          .splashScreenRouteName, // Replace with the desired route name
      builder: (context, state) =>
          const SplashScreen(), // Use the SplashScreen widget
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/login',
      name: SatuDataRoute.loginRouteName,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/superadmin-dashboard',
      name: SatuDataRoute.superadminDashboardRouteName,
      builder: (context, state) => const SuperAdminDrawerDashboard(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/admin-dashboard',
      name: SatuDataRoute.adminDashboardRouteName,
      builder: (context, state) => const AdminDrawerDashboard(),
    ),
    // GoRoute(
    //   parentNavigatorKey: _rootNavigatorKey,
    //   path: '/user_dashboard',
    //   name: SatuDataRoute.superadminDashboardRouteName,
    //   builder: (context, state) => const SuperAdminDrawerDashboard(),
    // ),
  ],
);
