import 'dart:ui';

import 'package:computer_lab_inventory_application/config/routes/route_names.dart';
import 'package:computer_lab_inventory_application/core/constant/icon_assets.dart';
import 'package:computer_lab_inventory_application/features/product/presentation/widgets/products_product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //User setting
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              spacing: 4,
              children: [
                Text(style: Theme.of(context).textTheme.labelMedium, 'User'),
                IconButton(
                  icon: SvgPicture.asset(
                    IconAssets.accountCircle,
                    height: 32,
                    width: 32,
                  ),
                  onPressed: () {
                    context.goNamed(RouteNames.user);
                  },
                ),
              ],
            ),

            //New Item+data
            Column(
              spacing: 8,
              children: [
                //Masuk
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8,
                  children: [
                    //Title header
                    Row(
                      spacing: 16,
                      children: [
                        Text(
                          'Masuk',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        IconButton(
                          icon: SvgPicture.asset(
                            IconAssets.expandContent,
                            width: 24,
                            height: 24,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),

                    //Item scroll
                    SizedBox(
                      height: 330,

                      child: ScrollConfiguration(
                        behavior: const MaterialScrollBehavior().copyWith(
                          dragDevices: {
                            PointerDeviceKind.mouse,
                            PointerDeviceKind.touch,
                            PointerDeviceKind.trackpad,
                          },
                        ),
                        child: ListView.separated(
                          separatorBuilder: (context, index) =>
                              SizedBox(width: 8),
                          scrollDirection: Axis.horizontal,
                          itemCount: 25,
                          itemBuilder: (context, index) {
                            return SizedBox(width: 124, child: ProductCard());
                          },
                        ),
                      ),
                    ),
                  ],
                ),

                //Perubahan
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8,
                  children: [
                    //Title header
                    Row(
                      spacing: 16,
                      children: [
                        Text(
                          'Perubahan',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        IconButton(
                          icon: SvgPicture.asset(
                            IconAssets.expandContent,
                            width: 24,
                            height: 24,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),

                    //Item scroll
                    SizedBox(
                      height: 330,

                      child: ScrollConfiguration(
                        behavior: const MaterialScrollBehavior().copyWith(
                          dragDevices: {
                            PointerDeviceKind.mouse,
                            PointerDeviceKind.touch,
                            PointerDeviceKind.trackpad,
                          },
                        ),
                        child: ListView.separated(
                          separatorBuilder: (context, index) =>
                              SizedBox(width: 8),
                          scrollDirection: Axis.horizontal,
                          itemCount: 25,
                          itemBuilder: (context, index) {
                            return SizedBox(width: 124, child: ProductCard());
                          },
                        ),
                      ),
                    ),
                  ],
                ),

                //Data barang
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8,
                  children: [
                    //Tittle header
                    Text(
                      'Data barang',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),

                    //Data title
                    Row(
                      spacing: 60,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Jumlah',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              '100.000',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurfaceVariant,
                                  ),
                            ),
                          ],
                        ),

                        Column(
                          children: [
                            Text(
                              'Diubah',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              '100.000',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurfaceVariant,
                                  ),
                            ),
                          ],
                        ),

                        Column(
                          children: [
                            Text(
                              'Dihapus',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              '100.000',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurfaceVariant,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
