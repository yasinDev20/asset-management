import 'package:equatable/equatable.dart';

class AssetRefEntity extends Equatable {
  final String id;
  final String categoryName;
  final String qrCode;
  final String brandName;
  final String name;

  const AssetRefEntity({
    required this.id,
    required this.categoryName,
    required this.qrCode,
    required this.brandName,
    required this.name,
  });

  @override
  List<Object> get props {
    return [id, categoryName, qrCode, brandName, name];
  }
}
