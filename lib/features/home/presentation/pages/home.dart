import 'package:assetmanagement/config/routes/route_names.dart';
import 'package:assetmanagement/core/utils/responsive_device_utils.dart';
import 'package:assetmanagement/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:assetmanagement/features/home/presentation/widgets/asset_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        spacing: 16,
        children: [
          SizedBox(height: 8),
          //Username and setting
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: 4,
            children: [
              // name
              BlocSelector<AuthBloc, AuthState, String?>(
                selector: (state) {
                  if (state is AuthenticatedState) {
                    return state.authEntity.user.name;
                  }
                  return null;
                },
                builder: (context, name) {
                  return Text(
                    style: Theme.of(context).textTheme.labelLarge,
                    'Halo, $name',
                  );
                },
              ),

              //Search bar non mobile
              (getDevicesize(context) != ResponsiveDevice.mobile)
                  ? Flexible(
                      child: SearchBar(
                        hintText: 'Cari barang',

                        trailing: [
                          Stack(
                            alignment: AlignmentGeometry.topRight,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: IconButton(
                                  icon: Icon(Icons.filter_list, size: 24),
                                  onPressed: () {},
                                ),
                              ),
                              Badge(
                                label: Text('+5'),
                                backgroundColor: Theme.of(
                                  context,
                                ).colorScheme.primary,
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  : SizedBox(),

              //settings
              IconButton(
                icon: Icon(Icons.settings, size: 32),
                onPressed: () {
                  context.goNamed(RouteNames.user);
                },
              ),
            ],
          ),

          //Search bar on mobile
          (getDevicesize(context) == ResponsiveDevice.mobile)
              ? SearchBar(
                hintText: 'Cari barang',
              
                trailing: [
                  Stack(
                    alignment: AlignmentGeometry.topRight,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          icon: Icon(Icons.filter_list, size: 24),
                          onPressed: () {},
                        ),
                      ),
                      Badge(
                        label: Text('+5'),
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.primary,
                      ),
                    ],
                  ),
                ],
              )
              : SizedBox(),
          //Asset grid
          Expanded(
            child: GridView.builder(
              itemCount: 20,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 186,
                mainAxisExtent: 290,
                mainAxisSpacing: 6,
                crossAxisSpacing: 6,
              ),
              itemBuilder: (context, index) =>
                  AssetCard(labelVariant: 'available'),
            ),
          ),
        ],
      ),
    );
  }
}
