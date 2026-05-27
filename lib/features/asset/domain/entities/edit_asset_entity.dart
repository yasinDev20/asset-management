import 'package:assetmanagement/features/asset/domain/entities/asset_ref_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/brand_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/category_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/location_entity.dart';
import 'package:equatable/equatable.dart';

import 'package:assetmanagement/features/asset/domain/entities/file_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/service_schedule_entity.dart';

class EditAssetEntity extends Equatable {
  final String id;
  final FileEntity? imageFile;
  final String? serialNumber;
  final String? name;
  final BrandEntity? brand;
  final CategoryEntity? category;
  final int? price;
  final int? productionYear;
  final LocationEntity? location;
  final String? status;
  final String? vendor;
  final int? purchaseYear;
  final int? warrantyEndYear;
  final List<ServiceScheduleEntity>? serviceSchedules;
  final AssetRefEntity? assetParent;
  final List<AssetRefEntity>? assetChilds;
  final FileEntity? invoiceFile;
  final String? notes;

  const EditAssetEntity({
    required this.id,
    required this.imageFile,
    required this.serialNumber,
    required this.name,
    required this.brand,
    required this.category,
    required this.price,
    required this.productionYear,
    required this.location,
    required this.status,
    required this.vendor,
    required this.purchaseYear,
    required this.warrantyEndYear,
    required this.serviceSchedules,
    required this.assetParent,
    required this.assetChilds,
    required this.invoiceFile,
    required this.notes,
   
  });

  @override
  List<Object> get props {
    return [
      ?serialNumber,
      ?name,
      ?brand,
      ?category,
      ?price,
      ?productionYear,
      ?location,
      ?status,
      ?vendor,
      ?purchaseYear,
      ?warrantyEndYear,
      ?serviceSchedules,
      ?assetParent,
      ?assetChilds,
      ?notes,
    ];
  }

  
}
