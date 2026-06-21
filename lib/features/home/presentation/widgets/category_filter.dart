import 'package:assetmanagement/core/common/widgets/text_field.dart';
import 'package:assetmanagement/features/asset_category/domain/entities/category_detail_entity.dart';
import 'package:assetmanagement/core/common/widgets/show_category_dialog.dart';
import 'package:flutter/material.dart';

class CategoryFilter extends StatefulWidget {
  final List<CategoryDetailEntity>? initialValue;
  final void Function(List<CategoryDetailEntity> categories) onSelected;
  final void Function(CategoryDetailEntity item)? onDeleted;

  const CategoryFilter({
    super.key,
    required this.onSelected,
    this.initialValue,
    this.onDeleted,
  });

  @override
  State<CategoryFilter> createState() => _CategoryFilterState();
}

class _CategoryFilterState extends State<CategoryFilter> {
  List<CategoryDetailEntity> get _categories => widget.initialValue?.toList() ?? [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text(
          'Kategori',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        CommonTextField(
          labelText: 'Cari kategori',
          readOnly: true,
          suffixIcon: Icon(Icons.arrow_drop_down),
          onTap: () {
            showCategoryDialog(
              context: context,

              onSelected: (selectedCategory) {
                final isDuplicate = _categories.any(
                  (element) => element.id == selectedCategory.id,
                );
                if (!isDuplicate && _categories.length < 3) {
                  widget.onSelected([..._categories, selectedCategory]);
                }
              },
            );
          },
        ),
        Row(
          children: [
            ..._categories.map(
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
