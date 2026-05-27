import 'package:assetmanagement/features/asset/domain/entities/file_entity.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageField extends StatefulWidget {
  final FileEntity? selectedImageFile;
  final String? imageUrl;
  final void Function(FileEntity image) onImagePicked;
  const ImageField({
    super.key,
    this.selectedImageFile,
    this.imageUrl,
    required this.onImagePicked,
  });

  @override
  State<ImageField> createState() => _ImageFieldState();
}

class _ImageFieldState extends State<ImageField> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        InkWell(
          onTap: () async {
            buildLargeImagePreview(widget.selectedImageFile, widget.imageUrl) != null
                ? showDialog(
                    context: context,
                    barrierDismissible: true,

                    builder: (context) {
                      return Dialog(
                        child: buildLargeImagePreview(
                          widget.selectedImageFile,
                          widget.imageUrl,
                        ),
                      );
                    },
                  )
                : null;
          },
          child: buildSmallImagePreview(widget.selectedImageFile, widget.imageUrl),
        ),
        IconButton(
          icon: Icon(Icons.edit),
          onPressed: () async {
            final imageResult = await ImagePicker().pickImage(
              source: ImageSource.gallery,
            );
            if (imageResult != null) {
              widget.onImagePicked(
                FileEntity(
                  name: imageResult.name,
                  file: await imageResult.readAsBytes(),
                ),
              );
            }
            
          },
        ),
      ],
    );
  }

  Widget buildSmallImagePreview(FileEntity? imageFile, String? imageUrl) {
    if (imageFile?.file != null) {
      return Image.memory(imageFile!.file, width: 128, height: 128);
    } else if (imageUrl != null) {
      return Image.network(imageUrl, width: 128, height: 128);
    } else {
      return Icon(Icons.image_outlined, size: 128, color: Colors.grey);
    }
  }

  Widget? buildLargeImagePreview(FileEntity? imageFile, String? imageUrl) {
    if (imageFile?.file != null) {
      return Image.memory(imageFile!.file, fit: BoxFit.contain);
    } else if (imageUrl != null) {
      return Image.network(imageUrl, fit: BoxFit.contain);
    } else {
      return null;
    }
  }
}
