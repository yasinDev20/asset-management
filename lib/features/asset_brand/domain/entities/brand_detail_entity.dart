import 'package:equatable/equatable.dart';

class BrandDetailEntity extends Equatable {
  final String id;
  final String ownerId;
  final String name;

  const BrandDetailEntity({
    required this.id,
    required this.ownerId,
    required this.name,
  });
  
  @override
  List<Object> get props => [id, ownerId, name];
}
