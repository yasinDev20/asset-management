import 'package:assetmanagement/config/routes/route_names.dart';
import 'package:assetmanagement/features/asset_category/presentation/bloc/asset_category_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  @override
  void initState() {
    context.read<AssetCategoryBloc>().add(SearchCategoriesEvent(''));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Senarai kategori')),
      body: Center(
        child: Column(
          spacing: 32,
          children: [
            SearchBar(
              hintText: 'Cari kategori',
              onSubmitted: (value) {
                context.read<AssetCategoryBloc>().add(
                  SearchCategoriesEvent(value),
                );
              },
            ),
            Expanded(
              child: BlocBuilder<AssetCategoryBloc, AssetCategoryState>(
                builder: (context, state) {
                  if (state.status == CategoryStatus.loading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (state.status == CategoryStatus.getSuccess) {
                    final categories = state.categoriesEntity;

                    return ListView.builder(
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        return ListTile(
                            onTap: () async {
                              final result = await context.pushNamed(
                                RouteNames.editcategory,
                                pathParameters: {
                                  'id': category.id,
                                  'code': category.code,
                                  'name': category.name,
                                },
                              );

                              if (result == true && mounted) {
                              this.context.read<AssetCategoryBloc>().add(
                                  SearchCategoriesEvent(''),
                                );
                              }
                            },
                          title: Row(
                            spacing: 16,
                            children: [
                              Text((index + 1).toString()),
                              Flexible(child: Text(category.name)),
                              Flexible(child: Text('(${category.code})')),
                              Icon(Icons.edit),
                            ],
                          ),
                        );
                      },
                    );
                  }
                  return Center(
                    child: TextButton(
                      child: Text('Coba lagi'),
                      onPressed: () => context.read<AssetCategoryBloc>().add(
                        GetCategoriesEvent(''),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
