import 'package:assetmanagement/config/routes/route_names.dart';
import 'package:assetmanagement/core/common/widgets/button.dart';
import 'package:assetmanagement/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengaturan'),

        actions: [
          BlocSelector<AuthBloc, AuthState, bool>(
            selector: (state) {
              return state.status == AuthStatus.loading;
            },
            builder: (context, isLoading) {
              return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: CommonButton(
                  text: isLoading ? 'Loading...' : 'Sign Out',
                  onPressed: () => context.read<AuthBloc>().add(SignOutEvent()),
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            //Categories
            ListTile(
              leading: Icon(Icons.category),
              title: Text('Senarai category'),
              onTap: () {
                context.pushNamed(RouteNames.categories);
              },
            ),
            //Brands
            ListTile(
              leading: Icon(Icons.copyright),
              title: Text('Senarai merek'),
              onTap: () {
                context.goNamed(RouteNames.brands);
              },
            ),
            //Locations
            ListTile(
              leading: Icon(Icons.location_on),
              title: Text('Senarai lokasi'),
              onTap: () {
                context.goNamed(RouteNames.locations);
              },
            ),
            //Templates
            ListTile(
              leading: Icon(Icons.assignment_add),
              title: Text('Senarai template'),
              onTap: () {
                context.goNamed(RouteNames.templates);
              },
            ),
          ],
        ),
      ),
    );
  }
}
