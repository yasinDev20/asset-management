import 'package:flutter/material.dart';

class StatusFilter extends StatefulWidget {
  final List<String>? initialValue;
  final void Function(List<String> status) onSelected;

  const StatusFilter({super.key, required this.onSelected, this.initialValue});

  @override
  State<StatusFilter> createState() => _StatusFilterState();
}

class _StatusFilterState extends State<StatusFilter> {
  late List<String> _status;
  @override
  void initState() {
    _status = widget.initialValue?.toList() ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text(
          'Status',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        Wrap(
          spacing: 4,
          runSpacing: 4,
          children: [
            //Available
            FilterChip(
              label: Text('Tersedia'),

              selected: _status.contains('Available'),
              onSelected: (value) {
                if (_status.contains('Available')) {
                  _status.remove('Available');
                } else {
                  _status.add('Available');
                }

                widget.onSelected(_status);
              },
            ),
            //In use
            FilterChip(
              label: Text('Digunakan'),
              selected: _status.contains('In use'),
              onSelected: (value) {
                if (_status.contains('In use')) {
                  _status.remove('In use');
                } else {
                  _status.add('In use');
                }

                widget.onSelected(_status);
              },
            ),

            //Maintenance
            FilterChip(
              label: Text('Perbaikan'),

              selected: _status.contains('Maintenance'),
              onSelected: (value) {
                if (_status.contains('Maintenance')) {
                  _status.remove('Maintenance');
                } else {
                  _status.add('Maintenance');
                }

                widget.onSelected(_status);
              },
            ),

            //Damaged
            FilterChip(
              label: Text('Rusak'),

              selected: _status.contains('Damaged'),
              onSelected: (value) {
                if (_status.contains('Damaged')) {
                  _status.remove('Damaged');
                } else {
                  _status.add('Damaged');
                }

                widget.onSelected(_status);
              },
            ),

            //Deleted
            FilterChip(
              label: Text('Dihapus'),

              selected: _status.contains('Deleted'),
              onSelected: (value) {
                if (_status.contains('Deleted')) {
                  _status.remove('Deleted');
                } else {
                  _status.add('Deleted');
                }

                widget.onSelected(_status);
              },
            ),
          ],
        ),
      ],
    );
  }
}
