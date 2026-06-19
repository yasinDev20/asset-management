import 'package:assetmanagement/config/routes/route_names.dart';
import 'package:assetmanagement/features/asset_location/presentation/bloc/asset_location_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LocationsPage extends StatefulWidget {
  const LocationsPage({super.key});

  @override
  State<LocationsPage> createState() => _LocationsPageState();
}

class _LocationsPageState extends State<LocationsPage> {
  @override
  void initState() {
    context.read<AssetLocationBloc>().add(SearchLocationsEvent(''));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Senarai lokasi')),
      body: Center(
        child: Column(
          spacing: 32,
          children: [
            SearchBar(
              hintText: 'Cari lokasi',
              onSubmitted: (value) => context.read<AssetLocationBloc>().add(
                SearchLocationsEvent(value),
              ),
            ),
            Expanded(
              child: BlocBuilder<AssetLocationBloc, AssetLocationState>(
                builder: (context, state) {
                  if (state.status == LocationStatus.loading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (state.status == LocationStatus.getSuccess) {
                    final locations = state.locationsEntity;

                    return ListView.builder(
                      itemCount: locations.length,
                      itemBuilder: (context, index) {
                        final location = locations[index];
                        return ListTile(
                          onTap: () async {
                            final result = await context.pushNamed(
                              RouteNames.editlocation,
                              pathParameters: {
                                'id': location.id,
                                'name': location.name,
                              },
                            );

                            if (result == true && mounted) {
                              this.context.read<AssetLocationBloc>().add(
                                SearchLocationsEvent(''),
                              );
                            }
                          },
                          title: Row(
                            spacing: 16,
                            children: [
                              Text((index + 1).toString()),
                              Flexible(child: Text(location.name)),
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
                      onPressed: () => context.read<AssetLocationBloc>().add(
                        SearchLocationsEvent(''),
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
