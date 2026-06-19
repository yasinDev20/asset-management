import 'package:equatable/equatable.dart';

class LocationDetailEntity extends Equatable {
  final String id;
  final String ownerId;
  final String name;

  const LocationDetailEntity({
    required this.id,
    required this.ownerId,
    required this.name,
  });
  
  @override
  List<Object> get props => [id, ownerId, name];
}
