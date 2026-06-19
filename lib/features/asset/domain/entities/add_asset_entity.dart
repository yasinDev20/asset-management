import 'package:assetmanagement/features/asset_category/domain/entities/category_detail_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/service_schedule_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:assetmanagement/features/asset/domain/entities/file_entity.dart';

class AddAssetEntity extends Equatable {
  final String ownerId;
  final FileEntity imageFile;
  final String? serialNumber;
  final String name;
  final String brandId;
  final CategoryDetailEntity category;
  final int price;
  final int productionYear;
  final String locationId;
  final String status;
  final String vendor;
  final int purchaseYear;
  final int? warrantyEndYear;
  final List<ServiceScheduleEntity>? serviceSchedules;
  final String? assetParent;
  final List<String>? assetChilds;
  final FileEntity? invoiceFile;
  final String? notes;

  const AddAssetEntity({
    required this.imageFile,
    required this.serialNumber,
    required this.name,
    required this.brandId,
    required this.category,
    required this.price,
    required this.productionYear,
    required this.locationId,
    required this.status,
    required this.vendor,
    required this.purchaseYear,
    required this.warrantyEndYear,
    required this.serviceSchedules,
    required this.assetParent,
    required this.assetChilds,
    required this.invoiceFile,
    required this.notes, required this.ownerId,
  });

  @override
  List<Object> get props {
    return [
      ?serialNumber,
      imageFile,
      name,
      brandId,
      category,
      price,
      productionYear,
      locationId,
      status,
      vendor,
      purchaseYear,
      ?warrantyEndYear,
      ?serviceSchedules,
      ?assetParent,
      ?assetChilds,
      ?invoiceFile,
      ?notes,
    ];
  }
}
