import 'package:assetmanagement/core/common/widgets/text_form_field.dart';
import 'package:assetmanagement/features/asset_location/domain/entities/add_location_entity%20.dart';
import 'package:assetmanagement/features/asset_location/domain/entities/location_detail_entity.dart';
import 'package:assetmanagement/features/asset_location/presentation/bloc/asset_location_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

Future showLocationDialog({
  required BuildContext context,
  required void Function(LocationDetailEntity selectedLocation) onSelected,
  TextEditingController? locationController,
}) async {
  TextEditingController searchController = TextEditingController();
  TextEditingController newLocationController = TextEditingController();

  context.read<AssetLocationBloc>().add(GetRecentLocationSelectionsEvent());

  return await showDialog(
    context: context,
    barrierColor: Colors.transparent,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setStateDialog) {
          return Dialog(
            backgroundColor: Colors.white,
            child: SizedBox(
              width: 300,
              height: 300,
              child: Center(
                child: Padding(
                  padding: EdgeInsetsGeometry.all(16),
                  child: Column(
                    spacing: 16,
                    children: [
                      //add new location
                      CommonTextFormField(
                        labelText: 'Tambahkan lokasi baru',
                        controller: newLocationController,
                        inputFormatters: [
                          TextInputFormatter.withFunction(
                            (oldValue, newValue) => TextEditingValue(
                              selection: newValue.selection,
                              text:
                                  newValue.text[0].toUpperCase() +
                                  newValue.text.substring(1),
                            ),
                          ),
                        ],

                        suffixIcon: IconButton(
                          icon: Icon(Icons.add_circle_outline),
                          onPressed: () {
                            if (newLocationController.text.isNotEmpty) {
                              context.read<AssetLocationBloc>().add(
                                AddLocationEvent(
                                  locationEntity: AddLocationEntity(
                                    name: newLocationController.text,
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      //Search
                      CommonTextFormField(
                        labelText: 'Cari',
                        controller: searchController,
                        prefixIcon: Icon(Icons.search),
                        //close
                        suffixIcon: IconButton(
                          onPressed: () {
                            searchController.clear();
                          },
                          icon: Icon(Icons.close),
                        ),

                        onFieldSubmitted: (newValue) {
                          if (newValue.isNotEmpty) {
                            context.read<AssetLocationBloc>().add(
                              GetLocationsEvent(newValue),
                            );
                          }
                        },
                      ),

                      //search result
                      Expanded(
                        child: Column(
                          children: [
                            BlocBuilder<AssetLocationBloc, AssetLocationState>(
                              builder: (context, state) {
                                if (state.status == LocationStatus.loading) {
                                  return CircularProgressIndicator();
                                }
                                if (state.status == LocationStatus.getSuccess) {
                                  final allLocations = state.locationsEntity;
                                  return Expanded(
                                    child: ListView.builder(
                                      itemCount: allLocations.length,
                                      itemBuilder: (context, index) {
                                        final location = allLocations[index];
                                        return ListTile(
                                          title: Text(location.name),
                                          tileColor: Theme.of(
                                            context,
                                          ).colorScheme.surface,
                                          onTap: () {
                                            onSelected(location);
                                            locationController?.text =
                                                location.name;

                                            context.read<AssetLocationBloc>().add(
                                              AddRecentLocationSelectionEvent(
                                                locationEntity: location,
                                              ),
                                            );

                                            context.pop();
                                          },
                                        );
                                      },
                                    ),
                                  );
                                }
                                return SizedBox();
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    },
  );
}
