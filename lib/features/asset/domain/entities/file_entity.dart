import 'dart:typed_data';

import 'package:equatable/equatable.dart';

class FileEntity extends Equatable {
  final String name;
  final String? path;
  final Uint8List file;

  const FileEntity( {required this.name, required this.file,  this.path, });
  

  @override
  List<Object> get props => [name, ?path];
}
