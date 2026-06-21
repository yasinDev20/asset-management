import 'package:assetmanagement/core/common/injection/injection.dart';
import 'package:assetmanagement/core/common/widgets/show_feedback.dart';
import 'package:assetmanagement/core/common/widgets/text_form_field.dart';
import 'package:assetmanagement/features/asset_category/domain/entities/add_category_entity.dart';
import 'package:assetmanagement/features/asset_category/domain/entities/category_detail_entity.dart';
import 'package:assetmanagement/features/asset_category/presentation/bloc/asset_category_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

Future showCategoryDialog({
  required BuildContext context,
  required void Function(CategoryDetailEntity selectedCategory) onSelected,
  TextEditingController? categoryController,
}) async {
  TextEditingController searchController = TextEditingController();
  TextEditingController newCategoryController = TextEditingController();
  TextEditingController newCodeController = TextEditingController();

  bool isAddnewClicked = false;

  return await showDialog(
    context: context,
    barrierColor: Colors.transparent,
    builder: (context) {
      return BlocProvider(
        create: (context) =>
            myInjection<AssetCategoryBloc>()
              ..add(GetRecentCategorySelectionsEvent()),
        child: StatefulBuilder(
          builder: (context, setStateDialog) {
            return Dialog(
              backgroundColor: Colors.white,
              child: SizedBox(
                width: 400,
                height: 400,
                child: Center(
                  child: Padding(
                    padding: EdgeInsetsGeometry.all(16),
                    child: Column(
                      spacing: 16,
                      children: [
                        //add new category and code
                        TextButton(
                          onPressed: () => setStateDialog(
                            () => isAddnewClicked = !isAddnewClicked,
                          ),
                          child: Text('Tambahkan kategori baru'),
                        ),
                        if (isAddnewClicked == true)
                          Column(
                            spacing: 16,
                            children: [
                              //new category
                              CommonTextFormField(
                                labelText: 'Kategori baru',
                                controller: newCategoryController,
                                textCapitalization:
                                    TextCapitalization.characters,
                                inputFormatters: [
                                  TextInputFormatter.withFunction(
                                    (oldValue, newValue) => TextEditingValue(
                                      text:
                                          newValue.text[0].toUpperCase() +
                                          newValue.text.substring(1),
                                      selection: newValue.selection,
                                    ),
                                  ),
                                ],
                              ),
                              //new code
                              CommonTextFormField(
                                labelText: 'Kode',
                                controller: newCodeController,
                                inputFormatters: [
                                  TextInputFormatter.withFunction(
                                    (oldValue, newValue) => TextEditingValue(
                                      text: newValue.text.toUpperCase(),
                                      selection: newValue.selection,
                                    ),
                                  ),
                                ],
                              ),

                              //add button
                              IconButton.filled(
                                color: Theme.of(context).colorScheme.primary,
                                icon: Icon(Icons.add, color: Colors.white),
                                onPressed: () {
                                  if (newCategoryController.text.isNotEmpty &&
                                      newCodeController.text.isNotEmpty) {
                                    context.read<AssetCategoryBloc>().add(
                                      AddCategoryEvent(
                                        categoryEntity: AddCategoryEntity(
                                          name: newCategoryController.text,
                                          code: newCodeController.text,
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),

                        //Search
                        CommonTextFormField(
                          labelText: 'Cari',
                          controller: searchController,
                          prefixIcon: Icon(Icons.search),
                          //close
                          suffixIcon: IconButton(
                            onPressed: () {
                              searchController.clear();
                            },
                            icon: Icon(Icons.close),
                          ),

                          onFieldSubmitted: (newValue) {
                            if (newValue.isNotEmpty) {
                              context.read<AssetCategoryBloc>().add(
                                SearchCategoriesEvent(newValue),
                              );
                            }
                          },
                        ),

                        //search result
                        BlocConsumer<AssetCategoryBloc, AssetCategoryState>(
                          listener: (context, state) {
                            if (state.status == CategoryStatus.failure) {
                              ShowFeedback.showSnackbar(
                                context: context,
                                isFailure: true,
                                text: state.failure?.message,
                              );
                            }
                          },
                          builder: (context, state) {
                            if (state.status == CategoryStatus.loading) {
                              return CircularProgressIndicator();
                            }
                            if (state.categoriesEntity.isNotEmpty) {
                              final allCategory = state.categoriesEntity;
                              return Expanded(
                                child: ListView.builder(
                                  itemCount: allCategory.length,
                                  itemBuilder: (context, index) {
                                    final category = allCategory[index];
                                    return ListTile(
                                      title: Text(
                                        '${category.name} (${category.code})',
                                      ),
                                      tileColor: Theme.of(
                                        context,
                                      ).colorScheme.surface,
                                      onTap: () {
                                        onSelected(category);
                                        categoryController?.text =
                                            '${category.name} (${category.code})';

                                        context.read<AssetCategoryBloc>().add(
                                          AddRecentCategorySelectionEvent(
                                            categoryEntity: category,
                                          ),
                                        );
                                        context.pop();
                                      },
                                    );
                                  },
                                ),
                              );
                            }
                            return Center(
                              child: Text('Kategori tidak ditemukan'),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    },
  );
}
