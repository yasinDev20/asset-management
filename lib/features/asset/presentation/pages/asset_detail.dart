import 'package:assetmanagement/core/common/widgets/button.dart';
import 'package:assetmanagement/core/common/widgets/text_form_field.dart';
import 'package:assetmanagement/features/asset/domain/entities/asset_detail_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/asset_ref_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/asset_template_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/brand_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/category_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/add_asset_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/edit_asset_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/file_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/location_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/service_schedule_entity.dart';
import 'package:assetmanagement/features/asset/domain/models/asset_detail_model.dart';
import 'package:assetmanagement/features/asset/presentation/bloc/asset_bloc.dart';
import 'package:assetmanagement/features/asset/presentation/widgets/attachment_field.dart';
import 'package:assetmanagement/features/asset/presentation/widgets/parent_field.dart';
import 'package:assetmanagement/features/asset/presentation/widgets/image_form_field.dart';
import 'package:assetmanagement/features/asset/presentation/widgets/invoice_field.dart';
import 'package:assetmanagement/features/asset/presentation/widgets/service_schedule_attachment_field.dart';
import 'package:assetmanagement/features/asset/presentation/widgets/show_brand_dialog.dart';
import 'package:assetmanagement/features/asset/presentation/widgets/show_category_dialog.dart';
import 'package:assetmanagement/features/asset/presentation/widgets/show_location_dialog.dart';
import 'package:assetmanagement/features/asset/presentation/widgets/show_status_dialog.dart';
import 'package:assetmanagement/features/asset/presentation/widgets/show_template_dialog.dart';
import 'package:assetmanagement/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
// import 'package:open_filex/open_filex.dart';
import 'package:collection/collection.dart';
import 'package:go_router/go_router.dart';

enum AssetFormMode { add, template, edit }

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
  final purchaseYearController = TextEditingController();
  final warrantyEndYearController = TextEditingController();
  final notesController = TextEditingController();

  TextEditingController searchController = TextEditingController();
  TextEditingController newBrandController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? id;
  List<ServiceScheduleEntity>? serviceSchedules;
  List<AssetRefEntity>? assetChilds;
  AssetRefEntity? assetParent;
  FileEntity? invoiceFile;
  String? invoiceUrl;
  List<Map<String, dynamic>>? assetChildQrCode;
  String? imageUrl;
  String? imagePath;
  String? invoicePath;
  FileEntity? imageFile;
  BrandEntity? brand;
  CategoryEntity? category;
  LocationEntity? location;
  EditAssetEntity? oldData;

  @override
  void initState() {
    if (widget.id?.isNotEmpty == true) {}
    context.read<AssetBloc>().add(
      GetAssetDetailEvent('42ac0ebc-f908-44bf-89f1-34e8f3e4d011'),
    );

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
    purchaseYearController.dispose();
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
              padding: EdgeInsetsGeometry.directional(
                start: 16,
                end: 16,
                bottom: 52,
              ),
              child: BlocConsumer<AssetBloc, AssetState>(
                listener: (context, state) {
                  final AssetDetail assetDetailViewModel;
                  final AssetDetailEntity assetDetailEntity;

                  if (state is GetAssetDetailSuccsessState) {
                    assetDetailViewModel = state.assetDetail;
                    assetDetailEntity = assetDetailViewModel.assetDetailEntity;

                    oldData = EditAssetEntity(
                      id: '',
                      imageFile: null,
                      serialNumber: assetDetailEntity.serialNumber,
                      name: assetDetailEntity.name,
                      brand: assetDetailEntity.brand,
                      category: assetDetailEntity.category,
                      price: assetDetailEntity.price,
                      productionYear: assetDetailEntity.productionYear,
                      location: assetDetailEntity.location,
                      status: assetDetailEntity.status,
                      vendor: assetDetailEntity.vendor,
                      purchaseYear: assetDetailEntity.purchaseYear,
                      warrantyEndYear: assetDetailEntity.warrantyEndYear,
                      serviceSchedules: assetDetailEntity.serviceSchedules,
                      assetParent: assetDetailEntity.assetParent,
                      assetChilds: assetDetailEntity.assetChilds?.toList(),
                      invoiceFile: null,
                      notes: assetDetailEntity.notes,
                    );

                    id = assetDetailViewModel.assetDetailEntity.id;
                    imagePath =
                        assetDetailViewModel.assetDetailEntity.imagePath;
                    invoicePath =
                        assetDetailViewModel.assetDetailEntity.invoicePath;
                    qrCodeController.text = assetDetailEntity.qrCode;
                    serialNumberController.text =
                        assetDetailEntity.serialNumber ?? '';

                    brand = assetDetailEntity.brand;
                    brandController.text = assetDetailEntity.brand.name;

                    category = assetDetailEntity.category;
                    categoryController.text =
                        '${assetDetailEntity.category.name} (${assetDetailEntity.category.code})';
                    nameController.text = assetDetailEntity.name;
                    priceController.text = assetDetailEntity.price.toString();
                    productionYearController.text = assetDetailEntity
                        .productionYear
                        .toString();
                    location = assetDetailEntity.location;
                    locationController.text = assetDetailEntity.location.name;

                    statusController.text = assetDetailEntity.status;

                    vendorController.text = assetDetailEntity.vendor;
                    purchaseYearController.text = assetDetailEntity.purchaseYear
                        .toString();
                    warrantyEndYearController.text = assetDetailEntity
                        .warrantyEndYear
                        .toString();
                    imageUrl = assetDetailViewModel.imageUrl;
                    serviceSchedules = assetDetailEntity.serviceSchedules
                        ?.toList();
                    assetParent = assetDetailEntity.assetParent;
                    assetChilds = assetDetailEntity.assetChilds?.toList();
                    invoiceUrl = assetDetailViewModel.invoiceUrl;
                    notesController.text = assetDetailEntity.notes ?? '';
                  }
                  if (state is AddAssetSuccessState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: Theme.of(context).colorScheme.primary,
                      ),
                    );
                  }
                  if (state is EditAssetSuccessState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: Theme.of(context).colorScheme.primary,
                      ),
                    );
                  }
                  if (state is AddToTemplateSuccessState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: Theme.of(context).colorScheme.primary,
                      ),
                    );
                  }
                  if (state is AssetFailureState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: Theme.of(context).colorScheme.error,
                      ),
                    );
                  }
                },

                builder: (context, state) {
                  return Column(
                    spacing: 52,
                    children: [
                      //Fields
                      Form(
                        key: _formKey,
                        child: Column(
                          spacing: 16,
                          children: [
                            //Image
                            if (widget.mode != AssetFormMode.template)
                              ImageFormField(
                                selectedImageFile: imageFile,
                                imageUrl: imageUrl,
                                onImagePicked: (image) {
                                  setState(() {
                                    imageFile = image;
                                  });
                                },
                                validator: FormBuilderValidators.required(),
                              ),
                            //Qr code
                            CommonTextFormField(
                              suffixIcon: Icon(Icons.edit_off_outlined),
                              readOnly: true,
                              labelText: '"Otomatis membuat Qr code"',
                              controller: qrCodeController,
                            ),

                            //Template
                            if (widget.mode == AssetFormMode.add)
                              CommonTextFormField(
                                controller: templateController,
                                labelText: '*Template',
                                suffixIcon: Icon(Icons.arrow_drop_down),
                                onTap: () {
                                  context.read<AssetBloc>().add(
                                    GetTemplatesEvent(value: ''),
                                  );
                                  showTemplateDialog(
                                    context: context,
                                    onSelected: (selectedTemplate) {
                                      setState(() {
                                        brand = selectedTemplate.brand;
                                        brandController.text =
                                            selectedTemplate.brand?.name ?? '';

                                        category = selectedTemplate.category;
                                        categoryController.text =
                                            '${selectedTemplate.category?.name} (${selectedTemplate.category?.code})';
                                        nameController.text =
                                            selectedTemplate.name ?? '';
                                        priceController.text = selectedTemplate
                                            .price
                                            .toString();
                                        productionYearController.text =
                                            selectedTemplate.productionYear
                                                .toString();
                                        location = selectedTemplate.location;
                                        locationController.text =
                                            selectedTemplate.location?.name ??
                                            '';

                                        statusController.text =
                                            selectedTemplate.status ?? '';

                                        vendorController.text =
                                            selectedTemplate.vendor ?? '';
                                        purchaseYearController.text =
                                            selectedTemplate.purchaseYear
                                                .toString();
                                        warrantyEndYearController.text =
                                            selectedTemplate.warrantyEndYear
                                                .toString();

                                        serviceSchedules = selectedTemplate
                                            .serviceSchedules
                                            ?.toList();
                                        assetParent =
                                            selectedTemplate.assetParent;

                                        notesController.text =
                                            selectedTemplate.notes ?? '';
                                      });
                                    },
                                  );
                                },
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
                              validator: FormBuilderValidators.required(),
                              onTap: () {
                                showBrandDialog(
                                  context: context,
                                  brandController: brandController,
                                  initialValue: brand,
                                  onSelected: (selectedBrand) {
                                    setState(() {
                                      brand = selectedBrand;
                                    });
                                  },
                                );
                              },
                            ),
                            //Kategori
                            CommonTextFormField(
                              readOnly: true,
                              labelText: '*Kategori',
                              controller: categoryController,
                              suffixIcon: Icon(Icons.arrow_drop_down),
                              validator: FormBuilderValidators.required(),
                              onTap: () {
                                showCategoryDialog(
                                  context: context,
                                  categoryController: categoryController,
                                  initialValue: category,
                                  onSelected: (selectedCategory) =>
                                      setState(() {
                                        category = selectedCategory;
                                      }),
                                );
                              },
                            ),
                            //Nama
                            CommonTextFormField(
                              labelText: '*Nama',
                              controller: nameController,
                              validator: FormBuilderValidators.required(),
                              inputFormatters: [
                                TextInputFormatter.withFunction(
                                  (oldValueue, newValue) => TextEditingValue(
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
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                                FormBuilderValidators.numeric(),
                              ]),
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
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                                FormBuilderValidators.numeric(),
                                FormBuilderValidators.equalLength(4),
                              ]),
                            ),
                            //Lokasi
                            CommonTextFormField(
                              readOnly: true,
                              labelText: '*Lokasi',
                              controller: locationController,
                              suffixIcon: Icon(Icons.arrow_drop_down),
                              validator: FormBuilderValidators.required(),

                              onTap: () => showLocationDialog(
                                context: context,
                                initialValue: location,
                                locationController: locationController,
                                onSelected: (selectedLocation) {
                                  location = selectedLocation;
                                },
                              ),
                            ),
                            //Status
                            CommonTextFormField(
                              readOnly: true,
                              suffixIcon: Icon(Icons.arrow_drop_down),
                              labelText: '*Status',
                              controller: statusController,
                              validator: FormBuilderValidators.required(),

                              onTap: () => {
                                showStatusDialog(
                                  context: context,
                                  statusController: statusController,
                                  onSelected: (value) {
                                    statusController.text = value;
                                  },
                                ),
                              },
                            ),
                            //Vendor
                            CommonTextFormField(
                              labelText: '*Vendor',
                              controller: vendorController,
                              validator: FormBuilderValidators.required(),
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
                              controller: purchaseYearController,
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                                FormBuilderValidators.numeric(),
                                FormBuilderValidators.equalLength(4),
                              ]),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(4),
                              ],
                            ),
                            //Tahun akhir garansi
                            CommonTextFormField(
                              labelText: 'Tahun akhir garansi',
                              controller: warrantyEndYearController,
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.equalLength(
                                  4,
                                  checkNullOrEmpty: false,
                                ),
                                FormBuilderValidators.numeric(
                                  checkNullOrEmpty: false,
                                ),
                              ]),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(4),
                              ],
                            ),
                            //Jadwal servis
                            ServiceScheduleAttachmentField(
                              serviceSchedules: serviceSchedules,
                              onDeletedChip: (item) {
                                setState(() {
                                  serviceSchedules?.removeWhere(
                                    (element) =>
                                        item.hashCode == element.hashCode,
                                  );
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
                            ParentField(
                              labelText: 'Induk Barang',
                              selections: assetParent,
                              onAddItem: (newItem) {
                                setState(() {
                                  assetParent = newItem;
                                });
                              },
                              onDeletedChip: (id) {
                                setState(() {
                                  assetParent = null;
                                });
                              },
                            ),

                            //Turunan barang
                            //TODO: ketika di klik maka akan ke asset detail
                            AttachmentFormField(
                              labelText: 'Turunan barang',
                              attachment: assetChilds
                                  ?.map(
                                    (e) => Chip(
                                      deleteIcon: Icon(Icons.close),
                                      labelStyle: TextStyle(),
                                      label: Text(
                                        '${e.qrCode} ${e.categoryName}${e.brandName.isNotEmpty ? ' ${e.brandName}' : ''} ${e.name}',
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),

                            //Invoice
                            InvoiceField(
                              invoiceFile: invoiceFile,
                              invoiceUrl: invoiceUrl,
                              onAddItem: (FileEntity newItem) {
                                setState(() {
                                  invoiceFile = newItem;
                                });
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
                      ),

                      //Buttons
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          if (true) {
                            // final userId = state.authEntity.user.id;
                            return Wrap(
                              spacing: 52,
                              runSpacing: 52,
                              alignment: WrapAlignment.center,

                              children: [
                                // //History
                                // if (widget.mode == AssetFormMode.edit)
                                //   CommonButton(
                                //     text: 'History',
                                //     style: ElevatedButton.styleFrom(
                                //       backgroundColor: Theme.of(
                                //         context,
                                //       ).colorScheme.tertiary,
                                //       foregroundColor: Theme.of(
                                //         context,
                                //       ).colorScheme.onPrimary,
                                //     ),
                                //     onPressed: () {},
                                //   ),
                                // //To template
                                if (widget.mode == AssetFormMode.edit)
                                  CommonButton(
                                    text: 'Jadikan template',
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue[400],
                                      foregroundColor: Theme.of(
                                        context,
                                      ).colorScheme.onPrimary,
                                    ),
                                    onPressed: () {
                                      final templateNameController =
                                          TextEditingController();
                                      showDialog(
                                        context: context,
                                        builder: (context) => Dialog(
                                          constraints: BoxConstraints(
                                            maxWidth: 500,
                                            maxHeight: 200,
                                          ),

                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(
                                              spacing: 32,
                                              children: [
                                                CommonTextFormField(
                                                  labelText: 'Nama template',
                                                  controller:
                                                      templateNameController,
                                                ),

                                                CommonButton(
                                                  text: 'Buat template',
                                                  onPressed: () {
                                                    if (templateNameController
                                                        .text
                                                        .isNotEmpty) {
                                                      final assetTemplateEntity = AssetTemplateEntity(
                                                        templateName:
                                                            templateNameController
                                                                .text,
                                                        assetId: id!,
                                                        name: oldData?.name,
                                                        brand: oldData?.brand,
                                                        category:
                                                            oldData?.category,
                                                        price: oldData?.price,
                                                        productionYear: oldData
                                                            ?.productionYear,
                                                        location:
                                                            oldData?.location,
                                                        status: oldData?.status,
                                                        vendor: oldData?.vendor,
                                                        purchaseYear: oldData
                                                            ?.purchaseYear,
                                                        warrantyEndYear: oldData
                                                            ?.warrantyEndYear,
                                                        serviceSchedules: oldData
                                                            ?.serviceSchedules,
                                                        assetParent: oldData
                                                            ?.assetParent,
                                                        notes: oldData?.notes,
                                                      );

                                                      context.read<AssetBloc>().add(
                                                        AddToTemplateEvent(
                                                          assetTemplateEntity:
                                                              assetTemplateEntity,
                                                        ),
                                                      );
                                                      context.pop();
                                                    }
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                //Edit
                                if (widget.mode == AssetFormMode.edit)
                                  CommonButton(
                                    text: 'Edit',
                                    onPressed: () {
                                      final newData = EditAssetEntity(
                                        id: id!,
                                        imageFile: imageFile,
                                        serialNumber:
                                            serialNumberController.text,
                                        name: nameController.text,
                                        brand: brand,
                                        category: category,
                                        price: int.parse(priceController.text),
                                        productionYear: int.parse(
                                          productionYearController.text,
                                        ),
                                        location: location,
                                        status: statusController.text,
                                        vendor: vendorController.text,
                                        purchaseYear: int.parse(
                                          purchaseYearController.text,
                                        ),
                                        warrantyEndYear: int.parse(
                                          warrantyEndYearController.text,
                                        ),
                                        serviceSchedules: serviceSchedules,
                                        assetParent: assetParent,
                                        assetChilds: assetChilds?.toList(),
                                        invoiceFile: invoiceFile,
                                        notes: notesController.text,
                                      );

                                      final compare = DeepCollectionEquality()
                                          .equals(oldData, newData);

                                      if (!compare ||
                                          imageFile != null ||
                                          invoiceFile != null) {
                                        context.read<AssetBloc>().add(
                                          EditAssetEvent(
                                            originalAssetEntity: oldData!,
                                            editAssetEntity: newData,
                                          ),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Tidak ada perubahan apapun!',
                                            ),
                                            backgroundColor: Colors.yellow[700],
                                          ),
                                        );
                                      }
                                      if (widget.mode == AssetFormMode.add) {}
                                    },
                                  ),

                                //add
                                if (widget.mode == AssetFormMode.add)
                                  CommonButton(
                                    text: 'Simpan',
                                    onPressed: () {
                                      final isValid = _formKey.currentState!
                                          .validate();
                                      if (isValid) {
                                        final newData = AddAssetEntity(
                                          ownerId:
                                              'ae1a0cfb-e02c-4583-93ed-26d2d59484cf',
                                          imageFile: imageFile!,
                                          serialNumber:
                                              serialNumberController.text,
                                          name: nameController.text,
                                          brandId: brand!.id,
                                          category: category!,
                                          price: int.parse(
                                            priceController.text,
                                          ),
                                          productionYear: int.parse(
                                            productionYearController.text
                                                .trim(),
                                          ),
                                          locationId: location!.id,
                                          status: statusController.text,
                                          vendor: vendorController.text,
                                          purchaseYear: int.parse(
                                            purchaseYearController.text,
                                          ),
                                          warrantyEndYear: int.tryParse(
                                            warrantyEndYearController.text,
                                          ),
                                          serviceSchedules: serviceSchedules,
                                          assetParent: assetParent?.id,
                                          assetChilds: assetChilds
                                              ?.map((e) => e.id)
                                              .toList(),
                                          invoiceFile: invoiceFile,
                                          notes: notesController.text,
                                        );
                                        context.read<AssetBloc>().add(
                                          AddAssetEvent(
                                            addAssetEntity: newData,
                                          ),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Ada bidang yang harus diisi!',
                                            ),
                                            backgroundColor: Theme.of(
                                              context,
                                            ).colorScheme.error,
                                          ),
                                        );
                                      }
                                    },
                                  ),
                              ],
                            );
                          }
                          return SizedBox();
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
