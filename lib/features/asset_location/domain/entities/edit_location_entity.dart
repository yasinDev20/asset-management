import 'package:equatable/equatable.dart';

class EditLocationEntity extends Equatable {
  final String id;
  final String? name;

  const EditLocationEntity( {required this.id, this.name,});

  @override
  List<Object> get props => [?name];
}
