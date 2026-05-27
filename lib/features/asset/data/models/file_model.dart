import 'dart:typed_data';

import 'package:assetmanagement/features/asset/domain/entities/file_entity.dart';
import 'package:equatable/equatable.dart';

class FileModel extends Equatable {
  final String name;
  final String? path;
  final Uint8List file;

  const FileModel({required this.name, required this.file, this.path});

  @override
  List<Object> get props => [name, ?path];

  FileEntity toEntity() {
    return FileEntity(name: name, file: file, path: path);
  }

  factory FileModel.fromEntity(FileEntity fileEntity) {
    return FileModel(
      name: fileEntity.name,
      file: fileEntity.file,
      path: fileEntity.path,
    );
  }
}
