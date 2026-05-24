import 'package:equatable/equatable.dart';

class ServiceScheduleEntity extends Equatable {
  final String title;
  final String type;
  final DateTime time;

  const ServiceScheduleEntity({required this.title, required this.type, required this.time});

  @override
  List<Object> get props => [title, type, time];
}
