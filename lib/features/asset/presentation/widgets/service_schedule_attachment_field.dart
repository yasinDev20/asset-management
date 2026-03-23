import 'package:assetmanagement/core/common/extension/extension.dart';
import 'package:assetmanagement/features/asset/presentation/widgets/attachment_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ServiceScheduleAttachmentField extends StatefulWidget {
  final List<Map<String, dynamic>>? serviceSchedules;
  final void Function()? onDeletedChip;
  final void Function(Map<String, dynamic> item) onAddItem;

  const ServiceScheduleAttachmentField({
    super.key,
    this.serviceSchedules = const [],
    this.onDeletedChip,
    required this.onAddItem,
  });

  @override
  State<ServiceScheduleAttachmentField> createState() =>
      _ServiceScheduleAttachmentFieldState();
}

class _ServiceScheduleAttachmentFieldState
    extends State<ServiceScheduleAttachmentField> {
  TextEditingController labelScheduleController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  @override
  void dispose() {
    labelScheduleController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AttachmentFormField(
      labelText: 'Jadwal servis',
      attachment: widget.serviceSchedules?.map((e) {
        final dateTimeFormated = DateFormat('d MMMM').format(e['time']);
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: [
            Text((e['type'] as String).serviceTypeToBahasa()),
            Chip(
              deleteIcon: Icon(Icons.close),
              labelStyle: TextStyle(),
              label: Text('${e['title']} :  $dateTimeFormated'),
              onDeleted: widget.onDeletedChip,
            ),
          ],
        );
      }).toList(),
      onAddItem: () async {
        String type = '';
        DateTime? dateTimePicked;
        showBottomSheet(
          context: context,
          showDragHandle: true,
          elevation: 10,
          builder: (context) => DraggableScrollableSheet(
            expand: false,
            builder: (context, scrollController) => StatefulBuilder(
              builder: (context, setStateBottomSheet) {
                return Center(
                  child: SizedBox(
                    width: 300,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        spacing: 16,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          //Type Checkbox
                          ListTile(
                            title: Text('Tahunan'),
                            trailing: Checkbox(
                              value: type == 'yearly',
                              onChanged: (value) {
                                setStateBottomSheet(() {
                                  type = (value == true) ? 'yearly' : '';
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: Text('Bulanan'),
                            trailing: Checkbox(
                              value: type == 'monthly',
                              onChanged: (value) {
                                setStateBottomSheet(() {
                                  type = (value == true) ? 'monthly' : '';
                                });
                              },
                            ),
                          ),
                          //Name
                          TextField(
                            controller: labelScheduleController,
                            decoration: InputDecoration(
                              labelText: 'Nama Jadwal',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          //DatePicker
                          TextField(
                            readOnly: true,
                            controller: dateController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.calendar_today),
                            ),

                            onTap: () async {
                             dateTimePicked = await showDatePicker(
                                context: context,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2100),
                              );

                              if (dateTimePicked != null) {
                                dateController.text = DateFormat(
                                  'd MMMM',
                                ).format(dateTimePicked!);
                              }
                            },
                          ),
                          //Add button
                          IconButton.filled(
                            icon: Icon(Icons.add, color: Colors.white),
                            onPressed: () {
                              if (labelScheduleController.text.isNotEmpty &&
                                  dateController.text.isNotEmpty &&
                                  type.isNotEmpty) {
                                widget.onAddItem({
                                  'title': labelScheduleController.text,
                                  'time': dateTimePicked ,
                                  'type': type,
                                });

                                labelScheduleController.clear();
                                dateController.clear();
                                type = '';

                                Navigator.pop(context);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
