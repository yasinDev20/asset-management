import 'package:assetmanagement/config/routes/route_names.dart';
import 'package:flutter/material.dart';
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
      appBar: AppBar(title: Text('Pengaturan')),
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
