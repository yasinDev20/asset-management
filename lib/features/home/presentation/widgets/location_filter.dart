import 'package:assetmanagement/core/common/widgets/show_location_dialog.dart';
import 'package:assetmanagement/core/common/widgets/text_field.dart';
import 'package:assetmanagement/features/asset/domain/entities/location_entity.dart';
import 'package:flutter/material.dart';

class LocationFilter extends StatefulWidget {
  final List<LocationEntity>? initialValue;
  final void Function(List<LocationEntity> locations) onSelected;
  final void Function(LocationEntity item)? onDeleted;

  const LocationFilter({
    super.key,
    this.initialValue = const [],
    required this.onSelected,
    this.onDeleted,
  });

  @override
  State<LocationFilter> createState() => _LocationFilterState();
}

class _LocationFilterState extends State<LocationFilter> {
  List<LocationEntity> get _locations => widget.initialValue ?? [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text(
          'Lokasi',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        CommonTextField(
          labelText: 'Cari Lokasi',
          readOnly: true,
          suffixIcon: Icon(Icons.arrow_drop_down),
          onTap: () {
            showLocationDialog(
              context: context,
              onSelected: (selectedLocation) {
                final isDuplicate = _locations.any(
                  (element) => element.id == selectedLocation.id,
                );
                if (!isDuplicate && _locations.length < 3) {
                  widget.onSelected([..._locations, selectedLocation]);
                }
              },
            );
          },
        ),
        Row(
          children: [
            ..._locations.map(
              (e) => Chip(
                color: WidgetStatePropertyAll(
                  Theme.of(context).colorScheme.secondaryContainer,
                ),
                onDeleted: () {
                  widget.onDeleted?.call(e);
                },
                label: Text(e.name),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
