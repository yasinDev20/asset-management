import 'package:assetmanagement/core/constant/Icon_assets.dart';
import 'package:assetmanagement/core/constant/image_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(6),
      child: Column(
        children: [
          //Image+Label
          Stack(
            alignment: Alignment.topRight,

            children: [
              //Image
              SizedBox(
                height: 124,
                child: Image.asset(ImageAssets.mouse, fit: BoxFit.fill),
              ),

              //Label
              Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Dihapus',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              ),
            ],
          ),

          //Detail
          Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 4),
            child: Column(
              spacing: 6,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Category + Brand + Name
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Monitor',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      '#Samsung 55” Odyssey Ark G97NC UHD 165Hz Mini LED Smart Gaming Monitor',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),

                //Qr + Location + Time
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  spacing: 4,
                  children: [
                    //Qr
                    Row(
                      spacing: 4,
                      children: [
                        SvgPicture.asset(
                          IconAssets.accountCircle,
                          height: 16,
                          width: 16,
                        ),
                        Flexible(
                          child: Text(
                            'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX',
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
                                ),
                          ),
                        ),
                      ],
                    ),

                    //Location
                    Row(
                      spacing: 4,
                      children: [
                        SvgPicture.asset(
                          IconAssets.accountCircle,
                          height: 16,
                          width: 16,
                        ),
                        Flexible(
                          child: Text(
                            'Technopreneur dan Inkubator Bisnis',
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
                                ),
                          ),
                        ),
                      ],
                    ),

                    //Time
                    Row(
                      spacing: 4,
                      children: [
                        SvgPicture.asset(
                          IconAssets.accountCircle,
                          height: 16,
                          width: 16,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurfaceVariant,
                                  ),
                              '09/05/2025',
                            ),
                            //Time
                            Text(
                              '16:59',
                              style: Theme.of(context).textTheme.bodySmall
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
          ),
        ],
      ),
    );
  }
}
