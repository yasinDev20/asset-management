import 'package:computer_lab_inventory_application/config/routes/route_names.dart';
import 'package:computer_lab_inventory_application/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:computer_lab_inventory_application/core/constant/Icon_assets.dart';
import 'package:go_router/go_router.dart';

class RootPage extends StatelessWidget {
  final Widget child;
  const RootPage({super.key, required this.child});

  // final List<Widget> _pages = [ProductsPage()];
  @override
  Widget build(BuildContext context) {
    // int _currentIndex = 0;

    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          switch (state) {
            case FailureState(message: final message):
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(message)));
              context.goNamed(RouteNames.login);

            case UnAuthenticatedState():
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Please login')));
          }
        },
        child: SelectionArea(child: SafeArea(child: child)),
      ),

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
    if (location.startsWith('/${RouteNames.addProduct}')) {
      return 2;
    }
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        GoRouter.of(context).goNamed(RouteNames.products);
      case 1:
        GoRouter.of(context).goNamed('/');
      case 2:
        GoRouter.of(context).go('/c');
    }
  }
}
