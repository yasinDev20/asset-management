import 'package:assetmanagement/config/routes/route_names.dart';
import 'package:assetmanagement/features/asset_brand/presentation/bloc/asset_brand_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class BrandsPage extends StatefulWidget {
  const BrandsPage({super.key});

  @override
  State<BrandsPage> createState() => _BrandsPageState();
}

class _BrandsPageState extends State<BrandsPage> {
  @override
  void initState() {
    context.read<AssetBrandBloc>().add(SearchBrandsEvent(''));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Senarai merek')),
      body: Center(
        child: Column(
          spacing: 32,
          children: [
            SearchBar(
              hintText: 'Cari merek',
              onSubmitted: (value) =>
                  context.read<AssetBrandBloc>().add(SearchBrandsEvent(value)),
            ),
            Expanded(
              child: BlocBuilder<AssetBrandBloc, AssetBrandState>(
                builder: (context, state) {
                  if (state.status == BrandStatus.loading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (state.status == BrandStatus.getSuccess) {
                    final brands = state.brandsEntity;

                    return ListView.builder(
                      itemCount: brands.length,
                      itemBuilder: (context, index) {
                        final brand = brands[index];
                        return ListTile(
                          onTap: () async {
                            final result = await context.pushNamed(
                              RouteNames.editbrand,
                              pathParameters: {
                                'id': brand.id,
                                'name': brand.name,
                              },
                            );

                            if (result == true && mounted) {
                              this.context.read<AssetBrandBloc>().add(
                                SearchBrandsEvent(''),
                              );
                            }
                          },
                          title: Row(
                            spacing: 16,
                            children: [
                              Text((index + 1).toString()),
                              Flexible(child: Text(brand.name)),
                              Icon(Icons.edit),
                            ],
                          ),
                        );
                      },
                    );
                  }
                  return Center(
                    child: TextButton(
                      child: Text('Coba lagi'),
                      onPressed: () => context.read<AssetBrandBloc>().add(
                        SearchBrandsEvent(''),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
