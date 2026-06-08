import 'package:assetmanagement/features/asset/domain/entities/asset_ref_entity.dart';
import 'package:assetmanagement/features/asset/presentation/bloc/asset_bloc.dart';
import 'package:assetmanagement/features/asset/presentation/bloc/asset_support_bloc.dart';
import 'package:assetmanagement/features/asset/presentation/widgets/attachment_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ParentField extends StatefulWidget {
  final String labelText;
  final void Function(AssetRefEntity newItem) onAddItem;
  final void Function(String id) onDeletedChip;
  final AssetRefEntity? selections;
  const ParentField({
    super.key,
    required this.onDeletedChip,
    this.selections,
    required this.onAddItem,
    required this.labelText,
  });

  @override
  State<ParentField> createState() => _ParentFieldState();
}

class _ParentFieldState extends State<ParentField> {
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
      attachment: widget.selections != null
          ? [
              Chip(
                deleteIcon: Icon(Icons.close),
                labelStyle: TextStyle(),
                label: Text(
                  '${widget.selections!.qrCode} ${widget.selections!.categoryName}${widget.selections!.brandName.isNotEmpty ? ' ${widget.selections!.brandName}' : ''} ${widget.selections!.name}',
                ),
                onDeleted: () => widget.onDeletedChip(widget.selections!.id),
              ),
            ]
          : [SizedBox()],
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
                              context.read<AssetSupportBloc>().add(
                                GetAssetRefEvent(qrCode: value),
                              );
                            },
                          ),

                          BlocBuilder<AssetSupportBloc, AssetState>(
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
