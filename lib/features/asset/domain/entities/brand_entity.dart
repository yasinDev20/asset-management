import 'package:equatable/equatable.dart';

class BrandEntity extends Equatable {
  final String id;
  final String ownerId;
  final String name;

  const BrandEntity({
    required this.id,
    required this.ownerId,
    required this.name,
  });
  
  @override
  List<Object> get props => [id, ownerId, name];
}
