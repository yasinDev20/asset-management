import 'package:assetmanagement/config/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class AssetLiteCard extends StatelessWidget {
  final String id;
  final String image;
  final String status;
  final String category;
  final String brand;
  final String name;
  final String qrCode;
  final String location;
  final DateTime? nextSchedule;

  const AssetLiteCard({
    super.key,
    required this.id,
    required this.image,
    required this.status,
    required this.category,
    required this.brand,
    required this.name,
    required this.qrCode,
    required this.location,
    required this.nextSchedule,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(6),
      child: GestureDetector(
        onTap: () {
          context.goNamed(RouteNames.assetDetail, pathParameters: {'id' : id});
        },
        child: Column(
          children: [
            //Image+Status
            Flexible(
              flex: 4,
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  //Image
                  SizedBox(
                    width: double.infinity,
                    child: Image.network(image, fit: BoxFit.cover),
                  ),
        
                  //Label
                  Status(status: status),
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
                          category,
                          style: Theme.of(context).textTheme.bodySmall,
                          maxLines: 2,
                        ),
                        Text(
                          brand == 'noBrand' ? name : '$brand $name',
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
                            Icon(Icons.qr_code, size: 16),
                            Flexible(
                              child: Text(
                                qrCode,
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
                            Icon(Icons.location_on_outlined, size: 16),
                            Flexible(
                              child: Text(
                                location,
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
                            Icon(Icons.build_outlined, size: 16),
                            Text(
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurfaceVariant,
                                  ),
                              nextSchedule == null
                                  ? ''
                                  : DateFormat(
                                      'dd/MM/yyyy',
                                    ).format(nextSchedule!),
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
      ),
    );
  }
}

class Status extends StatelessWidget {
  final String status;
  const Status({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: (status == 'Service')
          ? Text(
              'Service',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
            )
          : (status == 'In Use')
          ? Text(
              'Digunakan',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Colors.green[400],
              ),
            )
          : (status == 'Maintenance')
          ? Text(
              'Diperbaiki',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Colors.blue,
              ),
            )
          : (status == 'Damaged')
          ? Text(
              'Rusak',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Colors.red[400],
              ),
            )
          : (status == 'Deleted')
          ? Text(
              'Dihapus',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
            )
          : (status == 'Available')
          ? Text(
              'Tersedia',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Colors.red,
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
