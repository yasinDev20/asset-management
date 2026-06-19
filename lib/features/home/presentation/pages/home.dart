import 'package:assetmanagement/config/routes/route_names.dart';
import 'package:assetmanagement/core/utils/responsive_device_utils.dart';
import 'package:assetmanagement/features/asset/domain/entities/asset_filter_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/asset_lite_entity.dart';
import 'package:assetmanagement/features/asset/presentation/bloc/asset_bloc.dart';
import 'package:assetmanagement/features/asset/presentation/bloc/asset_list_bloc.dart';
import 'package:assetmanagement/features/asset/presentation/bloc/asset_support_bloc.dart';
import 'package:assetmanagement/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:assetmanagement/features/home/presentation/widgets/asset_card.dart';
import 'package:assetmanagement/features/home/presentation/widgets/filter_option.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AssetFilterEntity? filter;
  final _scrollController = ScrollController();
  final _qrCodeSearchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<AssetListBloc>().add(GetAssetsLiteEvent(filter: filter));
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();

    _qrCodeSearchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 300) {
      context.read<AssetListBloc>().add(LoadMoreAssetsEvent(filter: filter));
    }
  }

  int get _filterCount {
    if (filter == null) return 0;
    int count = 0;
    if (filter!.locations.isNotEmpty == true) count++;
    if (filter!.categories.isNotEmpty == true) count++;
    if (filter!.brands.isNotEmpty == true) count++;
    if (filter!.vendor.isNotEmpty == true) count++;
    if (filter!.status.isNotEmpty == true) count++;
    if (filter!.productionYear.isNotEmpty == true) count++;
    if (filter!.purchaseYear.isNotEmpty == true) count++;
    if (filter!.warrantyEndYear.isNotEmpty == true) count++;
    return count;
  }

  Future<void> _onFilterTapped() async {
    final newFilter = await showFilterOption(
      context: context,
      initialValue: filter,
    );

    // newFilter null berarti dialog di-cancel, jangan lakukan apa-apa
    if (newFilter == null && filter == null) return;

    setState(() => filter = newFilter);

    // if (!mounted) return;
    // context.read<AssetBloc>().add(GetAssetsLiteEvent(filter: filter));
  }

  Widget _buildFilterButton() {
    return Stack(
      alignment: AlignmentGeometry.topRight,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            icon: const Icon(Icons.filter_list, size: 24),
            onPressed: _onFilterTapped,
          ),
        ),
        if (_filterCount > 0)
          Badge(
            label: Text('$_filterCount'),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
      ],
    );
  }

  Widget _buildGrid({
    required BuildContext context,
    required List<AssetLiteEntity> assets,
    required bool isLoadingMore,
    required int columnCount,
  }) {
    return GridView.builder(
      controller: _scrollController,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columnCount,// jumlah colomn
        mainAxisExtent: 290, //tinggi maksimum
        mainAxisSpacing: 6,
        crossAxisSpacing: 6,
      ),
      itemCount: isLoadingMore ? assets.length + 1 : assets.length,
      itemBuilder: (context, index) {
        // Loading indicator di item terakhir
        if (index == assets.length) {
          return const Center(child: CircularProgressIndicator());
        }

        final asset = assets[index];
        return AssetLiteCard(
          id: asset.id,
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        spacing: 16,
        children: [
          const SizedBox(height: 0),

          // Username and setting
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: 4,
            children: [
              Flexible(
                child: BlocSelector<AuthBloc, AuthState, String?>(
                  selector: (state) => state is AuthenticatedState
                      ? state.authEntity.user.name
                      : null,
                  builder: (context, name) {
                    return Text(
                      'Halo, $name',
                      style: Theme.of(context).textTheme.labelLarge,
                    );
                  },
                ),
              ),

              if (getDevicesize(context) != ResponsiveDevice.mobile)
                Flexible(
                  flex: 3,
                  child: SearchBar(
                    controller: _qrCodeSearchController,
                    hintText: 'Cari qr code',
                    trailing: [_buildFilterButton()],
                    onChanged: (value) {
                      if (filter != null) {
                        filter = filter!.copyWith(
                          qrCode: _qrCodeSearchController.text,
                        );
                      } else {
                        filter = AssetFilterEntity(
                          qrCode: _qrCodeSearchController.text,
                        );
                      }
                      context.read<AssetListBloc>().add(
                        GetAssetsLiteEvent(filter: filter),
                      );
                    },
                  ),
                ),

                Flexible(
                  child: IconButton(
                    icon: const Icon(Icons.settings, size: 32),
                    onPressed: () => context.pushNamed  (RouteNames.settings),
                  ),
                ),
            ],
          ),

          // Search bar mobile
          if (getDevicesize(context) == ResponsiveDevice.mobile)
            SearchBar(
              hintText: 'Cari barang',
              trailing: [_buildFilterButton()],
            ),

          // Asset grid
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                const minItemWidth = 148;
                final columnCount = (constraints.maxWidth / minItemWidth)
                    .floor()
                    .clamp(1, 10);

                return BlocBuilder<AssetListBloc, AssetState>(
                  builder: (context, state) {
                    if (state is AssetLoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is AssetFailureState) {
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(state.failure.message),
                            TextButton(
                              onPressed: () => context
                                  .read<AssetListBloc>()
                                  .add(GetAssetsLiteEvent(filter: filter)),
                              child: const Text('Coba lagi'),
                            ),
                          ],
                        ),
                      );
                    }

                    if (state is GetAssetsLiteSuccessState) {
                      if (state.assets.isEmpty) {
                        return const Center(child: Text('Tidak ada aset'));
                      }
                      return _buildGrid(
                        context: context,
                        assets: state.assets,
                        isLoadingMore: false,
                        columnCount: columnCount,
                      );
                    }

                    if (state is AssetLoadingMoreState) {
                      return _buildGrid(
                        context: context,
                        assets: state.currentAssets,
                        isLoadingMore: true,
                        columnCount: columnCount,
                      );
                    }

                    return const SizedBox();
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
