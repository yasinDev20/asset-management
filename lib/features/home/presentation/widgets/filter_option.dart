import 'package:assetmanagement/features/asset/domain/entities/asset_filter_entity.dart';
import 'package:assetmanagement/features/asset/presentation/bloc/asset_bloc.dart';
import 'package:assetmanagement/features/asset/presentation/bloc/asset_list_bloc.dart';
import 'package:assetmanagement/features/asset/presentation/bloc/asset_support_bloc.dart';
import 'package:assetmanagement/features/home/presentation/widgets/brand_filter.dart';
import 'package:assetmanagement/features/home/presentation/widgets/category_filter.dart';
import 'package:assetmanagement/features/home/presentation/widgets/location_filter.dart';
import 'package:assetmanagement/features/home/presentation/widgets/status_filter.dart';
import 'package:assetmanagement/features/home/presentation/widgets/vendor_filter.dart';
import 'package:assetmanagement/features/home/presentation/widgets/year_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<AssetFilterEntity?> showFilterOption({
  required BuildContext context,
  AssetFilterEntity? initialValue,
}) async {
  AssetFilterEntity filter = initialValue ?? AssetFilterEntity();

  void applyFilter(BuildContext context) {
    context.read<AssetListBloc>().add(GetAssetsLiteEvent(filter: filter));
  }

  return await showDialog(
    context: context,
    builder: (context) {
      return PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (!didPop) Navigator.pop(context, filter);
        },
        child: StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              constraints: BoxConstraints(maxWidth: 400),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(
                    context,
                  ).copyWith(scrollbars: false),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 16,
                      children: [
                        //location filter
                        LocationFilter(
                          initialValue: filter.locations,
                          onSelected: (locations) {
                            setState(() {
                              filter = filter.copyWith(locations: locations);

                              applyFilter(context);
                            });
                          },
                          onDeleted: (item) {
                            setState(() {
                              filter = filter.copyWith(
                                locations: filter.locations
                                    .where((element) => element.id != item.id)
                                    .toList(),
                              );
                              applyFilter(context);
                            });
                          },
                        ),

                        //Category Filter
                        CategoryFilter(
                          initialValue: filter.categories,
                          onDeleted: (item) {
                            setState(() {
                              filter = filter.copyWith(
                                categories: filter.categories
                                    .where((element) => element.id != item.id)
                                    .toList(),
                              );
                              applyFilter(context);
                            });
                          },
                          onSelected: (categories) {
                            setState(() {
                              filter = filter.copyWith(categories: categories);
                              applyFilter(context);
                            });
                          },
                        ),

                        //Brand Filter
                        BrandFilter(
                          initialValue: filter.brands,
                          onSelected: (brands) {
                            setState(() {
                              filter = filter.copyWith(brands: brands);
                              applyFilter(context);
                            });
                          },

                          onDeleted: (item) {
                            setState(() {
                              filter = filter.copyWith(
                                brands: filter.brands
                                    .where((element) => element.id != item.id)
                                    .toList(),
                              );
                              applyFilter(context);
                            });
                          },
                        ),
                        //Vendor Filter
                        VendorFilter(
                          initialValue: filter.vendor,
                          onSelected: (vendors) {
                            setState(() {
                              filter = filter.copyWith(vendor: vendors);
                              applyFilter(context);
                            });
                          },

                          onDeleted: (item) {
                            setState(() {
                              filter = filter.copyWith(
                                vendor: filter.vendor
                                    .where((element) => element != item)
                                    .toList(),
                              );
                              applyFilter(context);
                            });
                          },
                        ),
                        //Status Filter
                        StatusFilter(
                          initialValue: filter.status,
                          onSelected: (status) {
                            setState(() {
                              filter = filter.copyWith(status: status);
                              applyFilter(context);
                            });
                          },
                        ),
                        //Production Year Filter
                        YearFilter(
                          initialValue: filter.productionYear,
                          labelText: 'Tahun produksi',
                          onSelected: (years) {
                            setState(() {
                              filter = filter.copyWith(productionYear: years);
                              applyFilter(context);
                            });
                          },
                          onDeleted: (item) {
                            setState(() {
                              filter = filter.copyWith(
                                productionYear: filter.productionYear
                                    .where((element) => element != item)
                                    .toList(),
                              );
                              applyFilter(context);
                            });
                          },
                        ),
                        //Purchase Year Filter
                        YearFilter(
                          initialValue: filter.purchaseYear,
                          labelText: 'Tahun pembelian',
                          onSelected: (years) {
                            setState(() {
                              filter = filter.copyWith(purchaseYear: years);
                              applyFilter(context);
                            });
                          },
                          onDeleted: (item) {
                            setState(() {
                              filter = filter.copyWith(
                                purchaseYear: filter.purchaseYear
                                    .where((element) => element != item)
                                    .toList(),
                              );
                              applyFilter(context);
                            });
                          },
                        ),

                        //Warranty End Year Filter
                        YearFilter(
                          initialValue: filter.warrantyEndYear,
                          labelText: 'Tahun akhir garansi',
                          onSelected: (years) {
                            setState(() {
                              filter = filter.copyWith(warrantyEndYear: years);
                              applyFilter(context);
                            });
                          },
                          onDeleted: (item) {
                            setState(() {
                              filter = filter.copyWith(
                                warrantyEndYear: filter.warrantyEndYear
                                    .where((element) => element != item)
                                    .toList(),
                              );
                              applyFilter(context);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    },
  );
}
