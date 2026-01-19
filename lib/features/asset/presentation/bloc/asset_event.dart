// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'asset_bloc.dart';

abstract class AssetEvent extends Equatable {
  const AssetEvent();

  @override
  List<Object> get props => [];
}

class GetAssetsEvent extends AssetEvent {
  final List<Map<String,String>> filter;
  const GetAssetsEvent(this.filter);
}
