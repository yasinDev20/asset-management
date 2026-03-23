import 'package:assetmanagement/features/asset/domain/entities/asset_ref_entity.dart';
import 'package:assetmanagement/features/asset/presentation/bloc/asset_bloc.dart';
import 'package:assetmanagement/features/asset/presentation/widgets/attachment_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AssetDependencyAttachmentField extends StatefulWidget {
  final String labelText;
  final void Function(AssetRefEntity newItem) onAddItem;
  final void Function() onDeletedChip;
  final List<AssetRefEntity?>? selections;
  const AssetDependencyAttachmentField({
    super.key,
    required this.onDeletedChip,
    this.selections,
    required this.onAddItem,
    required this.labelText,
  });

  @override
  State<AssetDependencyAttachmentField> createState() =>
      _AssetDependencyAttachmentFieldState();
}

class _AssetDependencyAttachmentFieldState
    extends State<AssetDependencyAttachmentField> {
  TextEditingController qrCodeSearchController = TextEditingController();

  @override
  void dispose() {
    qrCodeSearchController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AttachmentFormField(
      labelText: widget.labelText,
      attachment: widget.selections?.map((e) {
        if (e != null) {
          return Chip(
            deleteIcon: Icon(Icons.close),
            labelStyle: TextStyle(),
            label: Text(
              '${e.qrCode} ${e.categoryName}${e.brandName.isNotEmpty ? ' ${e.brandName}' : ''} ${e.name}',
            ),
            onDeleted: widget.onDeletedChip,
          );
        }
        return SizedBox();
      }).toList(),
      onAddItem: () async {
        showBottomSheet(
          context: context,
          showDragHandle: true,
          elevation: 10,
          builder: (context) => DraggableScrollableSheet(
            expand: false,
            builder: (context, scrollController) => StatefulBuilder(
              builder: (context, setStateBottomSheet) {
                return Center(
                  child: SizedBox(
                    width: 300,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        spacing: 16,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          //Search
                          TextField(
                            controller: qrCodeSearchController,
                            decoration: InputDecoration(
                              labelText: 'Cari Qr code',
                              border: OutlineInputBorder(),
                            ),
                            onSubmitted: (value) {
                              context.read<AssetBloc>().add(
                                GetAssetRefEvent(qrCodes: [value]),
                              );
                            },
                          ),

                          BlocBuilder<AssetBloc, AssetState>(
                            builder: (context, state) {
                              if (state is GetAssetRefSuccsessState &&
                                  state.assetRefEntity.isEmpty) {
                                return Text('Tidak ditemukan');
                              }
                              if (state is GetAssetRefSuccsessState &&
                                  state.assetRefEntity.isNotEmpty) {
                                final assetRef = state.assetRefEntity.first;
                                final assetFullName =
                                    '${assetRef.qrCode} ${assetRef.categoryName}${assetRef.brandName.isNotEmpty ? ' ${assetRef.brandName}' : ''} ${assetRef.name}';
                                return ListTile(
                                  title: Text(assetFullName),
                                  onTap: () {
                                    widget.onAddItem(assetRef);
                                    Navigator.of(context).pop();
                                  },
                                );
                              }
                              return SizedBox();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
