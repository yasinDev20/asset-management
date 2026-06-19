import 'package:assetmanagement/core/common/widgets/text_form_field.dart';
import 'package:assetmanagement/features/asset_brand/domain/entities/add_brand_entity.dart';
import 'package:assetmanagement/features/asset_brand/domain/entities/brand_detail_entity.dart';
import 'package:assetmanagement/features/asset_brand/presentation/bloc/asset_brand_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

Future showBrandDialog({
  required BuildContext context,
  required void Function(BrandDetailEntity selectedBrand) onSelected,
  TextEditingController? brandController,
}) async {
  TextEditingController searchController = TextEditingController();
  TextEditingController newBrandController = TextEditingController();

  context.read<AssetBrandBloc>().add(GetRecentBrandSelectionsEvent());

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
                      //add new brand
                      CommonTextFormField(
                        labelText: 'Tambahkan merk baru',
                        controller: newBrandController,
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
                            if (newBrandController.text.isNotEmpty) {
                              context.read<AssetBrandBloc>().add(
                                AddBrandEvent(
                                  AddBrandEntity(name: newBrandController.text),
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
                            context.read<AssetBrandBloc>().add(
                              GetBrandsEvent(newValue),
                            );
                          }
                        },
                      ),

                      //search result
                      Expanded(
                        child: Column(
                          children: [
                            //Nobrand
                            ListTile(
                              tileColor: Theme.of(context).colorScheme.surface,
                              title: Text('Tidak ada merk'),
                              onTap: () {
                                onSelected(
                                  BrandDetailEntity(
                                    id: '550e8400-e29b-41d4-a716-446655440000',
                                    ownerId:
                                        '550e8400-e29b-41d4-a716-446655440000',
                                    name: 'No Brand',
                                  ),
                                );

                                brandController?.text = 'Tidak ada merk';
                                context.pop();
                              },
                            ),
                            BlocBuilder<AssetBrandBloc, AssetBrandState>(
                              builder: (context, state) {
                                if (state.status == BrandStatus.loading) {
                                  return CircularProgressIndicator();
                                }
                                if (state.status == BrandStatus.getSuccess) {
                                  final allBrands = state.brandsEntity;
                                  return Expanded(
                                    child: ListView.builder(
                                      itemCount: allBrands.length,
                                      itemBuilder: (context, index) {
                                        final brand = allBrands[index];
                                        return ListTile(
                                          title: Text(brand.name),
                                          tileColor: Theme.of(
                                            context,
                                          ).colorScheme.surface,
                                          onTap: () {
                                            onSelected(brand);
                                            brandController?.text = brand.name;

                                            context.read<AssetBrandBloc>().add(
                                              AddRecentBrandSelectionEvent(
                                                brandEntity: brand,
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
