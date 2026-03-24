import 'dart:io';
import 'package:assetmanagement/core/common/extension/extension.dart';
import 'package:assetmanagement/core/common/widgets/text_form_field.dart';
import 'package:assetmanagement/core/platform/web/web_wrapper.dart';
import 'package:assetmanagement/features/asset/domain/entities/asset_detail_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/asset_ref_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/file_entity.dart';
import 'package:assetmanagement/features/asset/domain/models/asset_detail_model.dart';
import 'package:assetmanagement/features/asset/presentation/bloc/asset_bloc.dart';
import 'package:assetmanagement/features/asset/presentation/widgets/asset_dependency_attachment_field.dart';
import 'package:assetmanagement/features/asset/presentation/widgets/attachment_field.dart';
import 'package:assetmanagement/features/asset/presentation/widgets/service_schedule_attachment_field.dart';
import 'package:assetmanagement/features/asset/presentation/widgets/show_brand_dialog.dart';
import 'package:assetmanagement/features/asset/presentation/widgets/show_category_dialog.dart';
import 'package:assetmanagement/features/asset/presentation/widgets/show_location_dialog.dart';
import 'package:assetmanagement/features/asset/presentation/widgets/show_status_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_filex/open_filex.dart';

enum AssetFormMode { add, template, detail }

class AssetDetailPage extends StatefulWidget {
  final String? id;
  final AssetFormMode mode;
  const AssetDetailPage({super.key, required this.id, required this.mode});

  @override
  State<AssetDetailPage> createState() => _AssetDetailPageState();
}

class _AssetDetailPageState extends State<AssetDetailPage> {
  final qrCodeController = TextEditingController();
  final templateController = TextEditingController();
  final serialNumberController = TextEditingController();
  final brandController = TextEditingController();
  final categoryController = TextEditingController();
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final productionYearController = TextEditingController();
  final locationController = TextEditingController();
  final statusController = TextEditingController();
  final vendorController = TextEditingController();
  final purchaseController = TextEditingController();
  final warrantyEndYearController = TextEditingController();
  final notesController = TextEditingController();

  TextEditingController searchController = TextEditingController();
  TextEditingController newBrandController = TextEditingController();

  List<Map<String, dynamic>>? serviceSchedules;

  List<AssetRefEntity>? assetChilds;
  List<AssetRefEntity?>? assetParents;
  FileEntity? invoiceFile;
  List<Map<String, dynamic>>? assetChildQrCode;
  String? imageUrl;
  XFile? imageNonWeb;
  Uint8List? imageAtWeb;
  String? brandSelectedId;
  String? categoryId;
  String? categoryCode;
  String? locationId;
  String? statusSelectedValue;

  @override
  void initState() {
    if (widget.id?.isNotEmpty == true) {}
    context.read<AssetBloc>().add(GetAssetDetailEvent(widget.id!));

    super.initState();
  }

  @override
  void dispose() {
    qrCodeController.dispose();
    serialNumberController.dispose();
    brandController.dispose();
    categoryController.dispose();
    nameController.dispose();
    priceController.dispose();
    productionYearController.dispose();
    locationController.dispose();
    statusController.dispose();
    vendorController.dispose();
    purchaseController.dispose();
    warrantyEndYearController.dispose();
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail aset')),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: 500,
            child: Padding(
              padding: EdgeInsetsGeometry.all(16),
              child: Column(
                children: [
                  //Fields
                  BlocConsumer<AssetBloc, AssetState>(
                    listener: (context, state) {
                      if (state is AssetSuccesState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.message),
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.primary,
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      final AssetDetail assetDetail;
                      AssetDetailEntity? assetDetailEntity;
                      if (state is GetAssetDetailSuccsessState) {
                        assetDetail = state.assetDetail;
                        assetDetailEntity = assetDetail.assetDetailEntity;
                        qrCodeController.text = assetDetailEntity.qrCode;
                        templateController.text = assetDetailEntity.qrCode;
                        serialNumberController.text =
                            assetDetailEntity.serialNumber ?? '';
                        brandController.text =
                            assetDetailEntity.brand.name.isEmpty
                            ? 'Tidak ada merek'
                            : assetDetailEntity.brand.name;
                        categoryController.text =
                            assetDetailEntity.category.name;
                        nameController.text = assetDetailEntity.name;
                        priceController.text = assetDetailEntity.price
                            .toString();
                        productionYearController.text = assetDetailEntity
                            .productionYear
                            .toString();
                        locationController.text =
                            assetDetailEntity.location.name;
                        statusController.text = assetDetailEntity.status
                            .statusTypeToBahasa();
                        vendorController.text = assetDetailEntity.vendor;
                        purchaseController.text = assetDetailEntity.purchaseYear
                            .toString();
                        warrantyEndYearController.text = assetDetailEntity
                            .warrantyEndYear
                            .toString();
                        notesController.text = assetDetailEntity.notes ?? '';

                        serviceSchedules = assetDetailEntity.serviceSchedules;

                        assetChilds = assetDetailEntity.assetChilds;
                        assetParents = [assetDetailEntity.assetParent];
                        imageUrl = assetDetail.imageUrl;
                        invoiceFile = assetDetail.invoiceFile;
                      }
                      return Form(
                        child: Column(
                          spacing: 16,
                          children: [
                            //Image
                            if (widget.mode != AssetFormMode.template)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 8,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      buildLargeImagePreview() != null
                                          ? showDialog(
                                              context: context,
                                              barrierDismissible: true,

                                              builder: (context) {
                                                return Dialog(
                                                  child:
                                                      buildLargeImagePreview(),
                                                );
                                              },
                                            )
                                          : null;
                                    },
                                    child: buildSmallImagePreview(),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () async {
                                      imageNonWeb = await ImagePicker()
                                          .pickImage(
                                            source: ImageSource.gallery,
                                          );
                                      if (kIsWeb && imageNonWeb != null) {
                                        imageAtWeb = await imageNonWeb!
                                            .readAsBytes();
                                      }
                                      setState(() {});
                                    },
                                  ),
                                ],
                              ),

                            //Qr code
                            CommonTextFormField(
                              suffixIcon: Icon(Icons.edit_off_outlined),
                              readOnly: true,
                              labelText: '"Otomatis membuat Qr code"',
                              controller: qrCodeController,
                            ),

                            //Template
                            if (widget.mode == AssetFormMode.template)
                              CommonTextFormField(
                                controller: templateController,
                                labelText: '*Template',
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.arrow_drop_down),
                                  onPressed: () {},
                                ),
                              ),

                            //No seri
                            CommonTextFormField(
                              labelText: 'No seri',
                              controller: serialNumberController,
                            ),

                            //Merek
                            CommonTextFormField(
                              readOnly: true,
                              controller: brandController,
                              labelText: '*Merek',
                              suffixIcon: Icon(Icons.arrow_drop_down),
                              onTap: () {
                                showBrandDialog(
                                  context: context,
                                  brandController: brandController,
                                  brandSelectedId: brandSelectedId,
                                  onSelected: (value) => brandSelectedId,
                                );
                              },
                            ),
                            //Kategori
                            CommonTextFormField(
                              readOnly: true,
                              labelText: '*Kategori',
                              controller: categoryController,
                              suffixIcon: Icon(Icons.arrow_drop_down),
                              onTap: () {
                                showCategoryDialog(
                                  context: context,
                                  onSelected: ({required code, required id}) =>
                                      {categoryCode = code, categoryId = id},
                                  categorySelectedId: categoryId,
                                  categoryController: categoryController,
                                );
                              },
                            ),
                            //Nama
                            CommonTextFormField(
                              labelText: '*Nama',
                              controller: nameController,
                              inputFormatters: [
                                TextInputFormatter.withFunction(
                                  (oldValue, newValue) => TextEditingValue(
                                    selection: newValue.selection,
                                    text:
                                        newValue.text[0].toUpperCase() +
                                        newValue.text.substring(1),
                                  ),
                                ),
                              ],
                            ),
                            //Harga
                            CommonTextFormField(
                              labelText: '*Harga',
                              controller: priceController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                            ),
                            //Tahun pembuatan
                            CommonTextFormField(
                              labelText: '*Tahun pembuatan',
                              controller: productionYearController,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(4),
                              ],
                            ),
                            //Lokasi
                            CommonTextFormField(
                              readOnly: true,
                              labelText: '*Lokasi',
                              controller: locationController,
                              suffixIcon: Icon(Icons.arrow_drop_down),

                              onTap: () => showLocationDialog(
                                context: context,
                                locationId: locationId,
                                locationController: locationController,
                                onSelected: (selectedLocationId) =>
                                    locationId = selectedLocationId,
                              ),
                            ),
                            //Status
                            CommonTextFormField(
                              readOnly: true,
                              suffixIcon: Icon(Icons.arrow_drop_down),
                              labelText: '*Status',
                              controller: statusController,

                              onTap: () => {
                                showStatusDialog(
                                  context: context,
                                  statusSelectedValue: statusSelectedValue,
                                  statusController: statusController,
                                  onSelected: (value) =>
                                      statusSelectedValue = value,
                                ),
                              },
                            ),
                            //Vendor
                            CommonTextFormField(
                              labelText: '*Vendor',
                              controller: vendorController,
                              inputFormatters: [
                                TextInputFormatter.withFunction(
                                  (oldValue, newValue) => TextEditingValue(
                                    selection: newValue.selection,
                                    text:
                                        newValue.text[0].toUpperCase() +
                                        newValue.text.substring(1),
                                  ),
                                ),
                              ],
                            ),
                            //Tahun pembelian
                            CommonTextFormField(
                              labelText: '*Tahun pembelian ',
                              controller: purchaseController,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(4),
                              ],
                            ),
                            //Tahun akhir garansi
                            CommonTextFormField(
                              labelText: 'Tahun akhir garansi',
                              controller: warrantyEndYearController,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(4),
                              ],
                            ),
                            //Jadwal servis
                            ServiceScheduleAttachmentField(
                              serviceSchedules: serviceSchedules,
                              onDeletedChip: () {
                                setState(() {
                                  serviceSchedules?.removeLast();
                                });
                              },
                              onAddItem: (item) {
                                setState(() {
                                  serviceSchedules ??= [];
                                  serviceSchedules!.add(item);
                                });
                              },
                            ),
                            //Induk barang
                            AssetDependencyAttachmentField(
                              labelText: 'Induk Barang',
                              selections: assetParents,
                              onAddItem: (newItem) {
                                setState(() {
                                  assetParents ??= [];
                                  assetParents!.add(newItem);
                                });
                              },
                              onDeletedChip: () {
                                setState(() {
                                  assetParents?.removeLast();
                                });
                              },
                            ),
                            //Turunan barang
                            AssetDependencyAttachmentField(
                              labelText: 'Turunan barang',
                              selections: assetChilds,
                              onAddItem: (newItem) {
                                setState(() {
                                  assetChilds ??= [];
                                  assetChilds!.add(newItem);
                                });
                              },
                              onDeletedChip: () {
                                setState(() {
                                  assetChilds?.removeLast();
                                });
                              },
                            ),
                            //Invoice
                            BlocBuilder<AssetBloc, AssetState>(
                              builder: (context, state) {
                                if (state is DownloadFileSuccessState) {
                                  invoiceFile = state.file;
                                }
                                return AttachmentFormField(
                                  labelText: 'Invoice',
                                  attachment: invoiceFile != null
                                      ? [
                                          FilterChip(
                                            label: Text(
                                              invoiceFile?.name ?? '',
                                            ),
                                            deleteIcon: Icon(Icons.close),
                                            onSelected: (value) {
                                              //download file
                                              if (invoiceFile == null) {
                                                context.read<AssetBloc>().add(
                                                  DownloadFileEvent(
                                                    assetDetailEntity!
                                                        .invoicePath!,
                                                  ),
                                                );
                                              }
                                              //open file Web
                                              if (kIsWeb) {
                                                openFile(invoiceFile!.file);
                                              } else {
                                                if (invoiceFile?.path != null) {
                                                  OpenFilex.open(
                                                    invoiceFile!.path!,
                                                  );
                                                }
                                              }
                                            },
                                            onDeleted: () {
                                              setState(() {
                                                invoiceFile = null;
                                              });
                                            },
                                          ),
                                        ]
                                      : null,

                                  onAddItem: () async {
                                    FilePickerResult? result = await FilePicker
                                        .platform
                                        .pickFiles(withData: true);

                                    setState(() {
                                      // invoiceFile = result?.files.first != null
                                      //     ? File(path).
                                      //     : null;
                                      final bytes = result?.files.first.bytes;
                                      if (bytes != null) {
                                        final Uint8List file = bytes;

                                        final String name =
                                            result!.files.first.name;
                                        final String? path =
                                            result.files.first.path;

                                        invoiceFile = FileEntity(
                                          name: name,
                                          file: file,
                                          path: path,
                                        );
                                      }
                                    });
                                  },
                                );
                              },
                            ),
                            //Keterangan lainnya
                            CommonTextFormField(
                              labelText: 'Keterangan lainnya',
                              controller: notesController,
                              minLines: 1,
                              maxLines: 20,
                              inputFormatters: [
                                TextInputFormatter.withFunction(
                                  (oldValue, newValue) => TextEditingValue(
                                    selection: newValue.selection,
                                    text:
                                        newValue.text[0].toUpperCase() +
                                        newValue.text.substring(1),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  //Buttons
                  Row(children: []),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSmallImagePreview() {
    if (imageNonWeb == null && imageAtWeb == null) {
      if (imageUrl == null) {
        return Icon(Icons.image_outlined, size: 128, color: Colors.grey);
      } else {
        return Image.network(imageUrl!, width: 128, height: 128);
      }
    } else if (kIsWeb) {
      return Image.memory(imageAtWeb!, width: 128, height: 128);
    } else {
      return Image.file(File(imageNonWeb!.path), width: 128, height: 128);
    }
  }

  Widget? buildLargeImagePreview() {
    if (imageNonWeb == null && imageAtWeb == null) {
      if (imageUrl != null) {
        return Image.network(imageUrl!, fit: BoxFit.contain);
      }
    }
    if (kIsWeb && imageAtWeb != null) {
      return Image.memory(imageAtWeb!, fit: BoxFit.contain);
    }

    if (!kIsWeb && imageNonWeb != null) {
      return Image.file(File(imageNonWeb!.path), fit: BoxFit.contain);
    }

    return null;
  }
}
