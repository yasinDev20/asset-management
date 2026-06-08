import 'package:assetmanagement/core/common/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class YearFilter extends StatefulWidget {
  final String labelText;
  final List<int>? initialValue;
  final void Function(List<int> years) onSelected;
  final void Function(int item)? onDeleted;

  const YearFilter({
    super.key,
    required this.labelText,
    required this.onSelected,
    this.initialValue,
    this.onDeleted,
  });

  @override
  State<YearFilter> createState() => _YearFilterState();
}

class _YearFilterState extends State<YearFilter> {
  List<int> get _years => widget.initialValue?.toList() ?? [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text(
          widget.labelText,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        CommonTextField(
          labelText: 'Cari ${widget.labelText.toLowerCase()}',
          suffixIcon: Icon(Icons.arrow_drop_down),
          keyboardType: TextInputType.number,

          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(4)
          ],
          onSubmitted: (value) {
            final isDuplicate = _years.any(
              (element) => element == int.parse(value),
            );
            if (!isDuplicate && _years.length < 3) {
              widget.onSelected([..._years, int.parse(value)]);
            }
          },
        ),
        Row(
          children: [
            ..._years.map(
              (e) => Chip(
                color: WidgetStatePropertyAll(
                  Theme.of(context).colorScheme.secondaryContainer,
                ),
                onDeleted: () {
                  widget.onDeleted?.call(e);
                },
                label: Text(e.toString()),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
