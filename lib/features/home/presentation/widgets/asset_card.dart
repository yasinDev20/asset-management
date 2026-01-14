import 'package:assetmanagement/core/constant/image_assets.dart';
import 'package:flutter/material.dart';

class AssetCard extends StatelessWidget {
  final String labelVariant;
  const AssetCard({super.key, required this.labelVariant});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(6),
      child: Column(
        children: [
          //Image+Label
          Flexible(
            flex: 4,
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                //Image
                SizedBox(
                  width: double.infinity,
                  child: Image.asset(ImageAssets.mouse, fit: BoxFit.cover),
                ),

                //Label
                Label(labelVariant: labelVariant),
              ],
            ),
          ),

          //Detail
          Flexible(
            flex: 6,
            child: Padding(
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
                        'Monitor xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
                        style: Theme.of(context).textTheme.bodySmall,
                        maxLines: 2,
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
                          Icon(Icons.qr_code, size: 16, ),
                          Flexible(
                            child: Text(
                              'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX',
                              maxLines: 1,
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
                          Icon(Icons.location_on_outlined, size: 16, ),
                          Flexible(
                            child: Text(
                              'Lokasi AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA',
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
                          Icon(Icons.build_outlined, size: 16, ),
                          Text(
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
                                ),
                            '09/05/2025',
                          ),
                        ],
                      ),
                   
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Label extends StatelessWidget {
  final String labelVariant;
  const Label({super.key, required this.labelVariant});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: (labelVariant == 'service')
          ? Text(
              'Service',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
            )
          : (labelVariant == 'inUse')
          ? Text(
              'Digunakan',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
            )
          : (labelVariant == 'maintenance')
          ? Text(
              'Diperbaiki',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
            )
          : (labelVariant == 'damaged')
          ? Text(
              'Rusak',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
            )
          : (labelVariant == 'deleted')
          ? Text(
              'Dihapus',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
            )
          : (labelVariant == 'available')
          ? Text(
              'Tersedia',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
            )
          : Text(
              'Error',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
    );
  }
}
