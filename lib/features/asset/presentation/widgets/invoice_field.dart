import 'package:assetmanagement/features/asset/domain/entities/file_entity.dart';
import 'package:assetmanagement/features/asset/presentation/widgets/attachment_field.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:assetmanagement/core/platform/web/web_wrapper.dart';
import 'package:open_filex/open_filex.dart';
import 'package:url_launcher/url_launcher.dart';

class InvoiceField extends StatefulWidget {
  final FileEntity? invoiceFile;
  final String? invoiceUrl;
  final void Function(FileEntity newItem) onAddItem;

  const InvoiceField({
    super.key,
    required this.invoiceFile,
    required this.invoiceUrl,
    required this.onAddItem,
  });

  @override
  State<InvoiceField> createState() => _InvoiceFieldState();
}

class _InvoiceFieldState extends State<InvoiceField> {
  @override
  Widget build(BuildContext context) {
    String label = '';
    bool check = widget.invoiceUrl != null && widget.invoiceFile == null;
    if (check) {
      label = Uri.parse(widget.invoiceUrl!).pathSegments.last;
    } else if (widget.invoiceFile != null) {
      label = widget.invoiceFile!.name;
    }

    return AttachmentFormField(
      labelText: 'Invoice',
      attachment: widget.invoiceUrl == null && widget.invoiceFile == null
          ? null
          : [
              FilterChip(
                label: Text(label),
                deleteIcon: Icon(Icons.close),
                onSelected: (value) {
                  if (check) {
                    launchUrl(Uri.parse(widget.invoiceUrl!));
                  } else {
                    if (kIsWeb && widget.invoiceFile != null) {
                      openFile(widget.invoiceFile!.file);
                    } else if (widget.invoiceFile != null) {
                      OpenFilex.open(widget.invoiceFile!.path!);
                    }
                  }
                },
              ),
            ],

      onAddItem: () async {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png', 'webp'],
          withData: true,
        );

        final bytes = result?.files.first.bytes;
        if (bytes != null) {
          final Uint8List file = bytes;

          final String name = result!.files.first.name;
          final String? path = result.files.first.path;

          final newItem = FileEntity(name: name, file: file, path: path);

          widget.onAddItem(newItem);
        }
      },
    );
  }
}
