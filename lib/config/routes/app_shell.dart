import 'package:assetmanagement/config/routes/route_names.dart';
import 'package:assetmanagement/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:assetmanagement/core/constant/Icon_assets.dart';
import 'package:go_router/go_router.dart';

class AppShell extends StatelessWidget {
  final Widget child;
  const AppShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SelectionArea(child: SafeArea(child: child)),
      //  BlocListener<AuthBloc, AuthState>(
      //   listener: (context, state) {
      //     switch (state) {
      //       case FailureState(message: final message):
      //         ScaffoldMessenger.of(
      //           context,
      //         ).showSnackBar(SnackBar(content: Text(message)));
      //         context.goNamed(RouteNames.login);

      //       case UnAuthenticatedState():
      //         ScaffoldMessenger.of(
      //           context,
      //         ).showSnackBar(const SnackBar(content: Text('Please login')));
      //         context.goNamed(RouteNames.login);
      //     }
      //   },
      //   child: 
        
      //   SelectionArea(child: SafeArea(child: child)),
      // ),

      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex(context),
        onDestinationSelected: (int index) => _onItemTapped(index, context),

        backgroundColor: Colors.white,

        destinations: [
          NavigationDestination(
            icon: SvgPicture.asset(IconAssets.computer),
            label: "Barang",
          ),
          NavigationDestination(
            icon: SvgPicture.asset(IconAssets.qrCodeScanner),
            label: "Qr Scanner",
          ),
          NavigationDestination(
            icon: SvgPicture.asset(IconAssets.hugeiconsComputerAdd),
            label: "Tambah",
          ),
        ],
      ),
    );
  }

  static int _selectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    if (location.startsWith('/')) {
      return 0;
    }
    if (location.startsWith('/')) {
      return 1;
    }
    if (location.startsWith('/${RouteNames.addAsset}')) {
      return 2;
    }
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        GoRouter.of(context).goNamed(RouteNames.home);
      case 1:
        GoRouter.of(context).goNamed('/');
      case 2:
        GoRouter.of(context).goNamed(RouteNames.addAsset);
    }
  }
}
