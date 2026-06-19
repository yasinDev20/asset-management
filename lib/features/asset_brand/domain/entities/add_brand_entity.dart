import 'package:equatable/equatable.dart';

class AddBrandEntity extends Equatable {
  final String name;

  const AddBrandEntity({
    required this.name,
  });
  
  @override
  List<Object> get props => [name];
}
