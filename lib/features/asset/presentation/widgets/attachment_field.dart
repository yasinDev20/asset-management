import 'package:flutter/material.dart';

class AttachmentFormField extends StatefulWidget {
  final void Function() onAddItem;
  final List<Widget>? attachment;
  final String labelText;
  const AttachmentFormField({
    super.key,
    required this.attachment,
    required this.labelText,
    required this.onAddItem,
  });
  @override
  State<AttachmentFormField> createState() => _AttachmentFormFieldState();
}

class _AttachmentFormFieldState extends State<AttachmentFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        prefixIcon: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              spacing: 12,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(widget.labelText),
                ),
                ...widget.attachment ?? [],
                IconButton.filled(
                  icon: Icon(Icons.add, color: Colors.white),
                  onPressed: widget.onAddItem,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
