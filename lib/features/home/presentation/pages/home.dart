import 'package:assetmanagement/config/routes/route_names.dart';
import 'package:assetmanagement/core/utils/responsive_device_utils.dart';
import 'package:assetmanagement/features/asset/presentation/bloc/asset_bloc.dart';
import 'package:assetmanagement/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:assetmanagement/features/home/presentation/widgets/asset_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<AssetBloc>().add(GetAssetsLiteEvent([]));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        spacing: 16,
        children: [
          SizedBox(height: 0),
          //Username and setting
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: 4,
            children: [
              // name
              Flexible(
                child: BlocSelector<AuthBloc, AuthState, String?>(
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
              ),

              //Search bar non mobile
              (getDevicesize(context) != ResponsiveDevice.mobile)
                  ? Flexible(
                      flex: 3,
                      child: SearchBar(
                        hintText: 'Cari qr code',

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
              Flexible(
                child: IconButton(
                  icon: Icon(Icons.settings, size: 32),
                  onPressed: () {
                    context.goNamed(RouteNames.user);
                  },
                ),
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
            child: LayoutBuilder(
              builder: (context, constraints) {
                const minItemWidth = 148;
                final count = (constraints.maxWidth / minItemWidth)
                    .floor()
                    .clamp(1, 10);

                return BlocBuilder<AssetBloc, AssetState>(
                  builder: (context, state) {
                    if (state is GetAssetsLiteSuccsessState) {
                      final allAsset = state.allAsset;
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: count,
                          mainAxisExtent: 290,
                          mainAxisSpacing: 6,
                          crossAxisSpacing: 6,
                        ),
                        itemCount: allAsset.length,
                        itemBuilder: (context, index) {
                          final asset = allAsset[index];
                          return AssetLiteCard(
                            id : asset.id,
                            image: asset.image,
                            status: asset.status,
                            category: asset.categoryName,
                            brand: asset.brandName,
                            name: asset.name,
                            qrCode: asset.qrCode,
                            location: asset.location,
                            nextSchedule: asset.nextServiceSchedule,
                          );
                        },
                      );
                    }
                    return SizedBox();
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
