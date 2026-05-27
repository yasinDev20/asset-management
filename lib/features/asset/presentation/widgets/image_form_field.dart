import 'package:assetmanagement/features/asset/domain/entities/file_entity.dart';
import 'package:assetmanagement/features/asset/presentation/widgets/image_field.dart';
import 'package:flutter/material.dart';

class ImageFormField extends FormField<FileEntity?> {
  ImageFormField({
    super.key,
    super.initialValue,
    super.validator,
    FileEntity? selectedImageFile,
    String? imageUrl,
    required Function(FileEntity image) onImagePicked,
  }) : super(
         builder: (state) {
           return Column(
             children: [
               ImageField(
                 selectedImageFile: selectedImageFile,
                 imageUrl: imageUrl,
                 onImagePicked: (file) {
                   // update ke Form
                   state.didChange(file);

                   onImagePicked(file);
                 },
               ),

               //  error dari validator
               if (state.hasError)
                 Padding(
                   padding: const EdgeInsets.only(top: 8),
                   child: Text(
                     state.errorText!,
                     style: const TextStyle(color: Colors.red),
                   ),
                 ),
             ],
           );
         },
       );
}
