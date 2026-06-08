import 'package:assetmanagement/core/common/widgets/text_field.dart';
import 'package:flutter/material.dart';

class VendorFilter extends StatefulWidget {
  final List<String>? initialValue;
  final void Function(List<String> vendors) onSelected;
  final void Function(String item)? onDeleted;

  const VendorFilter({
    super.key,
    required this.onSelected,
    this.initialValue,
    this.onDeleted,
  });

  @override
  State<VendorFilter> createState() => _VendorFilterState();
}

class _VendorFilterState extends State<VendorFilter> {
  List<String> get _vendors => widget.initialValue?.toList() ?? [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text(
          'Vendor',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        CommonTextField(
          labelText: 'Cari vendor',
          suffixIcon: Icon(Icons.arrow_drop_down),
          onSubmitted: (value) {
            final isDuplicate = _vendors.any((element) => element == value);
            if (!isDuplicate && _vendors.length < 3) {
              widget.onSelected([..._vendors, value]);
            }
          },
        ),
        Row(
          children: [
            ..._vendors.map(
              (e) => Chip(
                color: WidgetStatePropertyAll(
                  Theme.of(context).colorScheme.secondaryContainer,
                ),
                onDeleted: () {
                  widget.onDeleted?.call(e);
                },
                label: Text(e),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
