import 'package:equatable/equatable.dart';

class AssetSummaryEntity extends Equatable {
  final String id;
  final String status;
  final String image;
  final String categoryName;
  final String qrCode;
  final String brandName;
  final String name;
  final String location;
  final String? nextServiceSchedule;
  const AssetSummaryEntity({
    required this.id,
    required this.status,
    required this.image,
    required this.categoryName,
    required this.qrCode,
    required this.brandName,
    required this.name,
    required this.location,
    required this.nextServiceSchedule,
  });

  @override
  List<Object> get props {
    return [
      id,
      status,
      image,
      categoryName,
      qrCode,
      brandName,
      name,
      location,
      ?nextServiceSchedule,
    ];
  }
}
