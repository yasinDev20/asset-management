import 'package:assetmanagement/core/common/widgets/text_form_field.dart';
import 'package:assetmanagement/features/asset/domain/entities/category_entity.dart';
import 'package:assetmanagement/features/asset/presentation/bloc/asset_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

Future showCategoryDialog({
  required BuildContext context,
  required CategoryEntity? initialValue,
  required void Function(CategoryEntity selectedCategory) onSelected,
  required TextEditingController categoryController,
}) async {
  TextEditingController searchController = TextEditingController();
  TextEditingController newCategoryController = TextEditingController();
  TextEditingController newCodeController = TextEditingController();

  context.read<AssetBloc>().add(GetRecentCategorySelectionsEvent());

  bool isAddnewClicked = false;


  return await showDialog(
    context: context,
    barrierColor: Colors.transparent,
    builder: (context) {
      return StatefulBuilder(
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
                              textCapitalization: TextCapitalization.characters,
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
                                  context.read<AssetBloc>().add(
                                    AddCategoryEvent(
                                      name: newCategoryController.text,
                                      code: newCodeController.text,
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
                            context.read<AssetBloc>().add(
                              GetCategoriesEvent(newValue),
                            );
                          }
                        },
                      ),

                      //search result
                      BlocBuilder<AssetBloc, AssetState>(
                        builder: (context, state) {
                          if (state is AssetLoadingState) {
                            return CircularProgressIndicator();
                          }
                          if (state is GetCategoriesSuccsessState) {
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
                                      onSelected(
                                       category
                                      );
                                      categoryController.text =
                                          '${category.name} (${category.code})';

                                      context.read<AssetBloc>().add(
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
                          return SizedBox();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    },
  );
}
