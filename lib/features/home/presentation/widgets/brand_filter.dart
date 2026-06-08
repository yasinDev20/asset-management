import 'package:assetmanagement/core/common/widgets/text_field.dart';
import 'package:assetmanagement/features/asset/domain/entities/brand_entity.dart';
import 'package:assetmanagement/features/asset/presentation/widgets/show_brand_dialog.dart';
import 'package:flutter/material.dart';

class BrandFilter extends StatefulWidget {
  final List<BrandEntity>? initialValue;
  final void Function(List<BrandEntity> brands) onSelected;
  final void Function(BrandEntity item)? onDeleted;

  const BrandFilter({
    super.key,
    required this.onSelected,
    this.initialValue,
    this.onDeleted,
  });

  @override
  State<BrandFilter> createState() => _BrandFilterState();
}

class _BrandFilterState extends State<BrandFilter> {
  List<BrandEntity> get _brands => widget.initialValue?.toList() ?? [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text(
          'Merek',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        CommonTextField(
          labelText: 'Cari merek',
          readOnly: true,
          suffixIcon: Icon(Icons.arrow_drop_down),
          onTap: () {
            showBrandDialog(
              context: context,
              onSelected: (selectedBrand) {
                 final isDuplicate = _brands.any(
                  (element) => element.id == selectedBrand.id,
                );
                if (!isDuplicate && _brands.length < 3) {
                  widget.onSelected([..._brands, selectedBrand]);
                }
              },
            );
          },
        ),
        Row(
          children: [
            ..._brands.map(
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
