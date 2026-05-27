import 'package:assetmanagement/core/common/widgets/text_form_field.dart';
import 'package:assetmanagement/features/asset/domain/entities/asset_template_entity.dart';
import 'package:assetmanagement/features/asset/presentation/bloc/asset_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

Future showTemplateDialog({
  required BuildContext context,
  required void Function(AssetTemplateEntity selectedBrand) onSelected,
}) async {
  TextEditingController searchController = TextEditingController();

  context.read<AssetBloc>().add(GetRecentBrandSelectionsEvent());

  return await showDialog(
    context: context,
    barrierColor: Colors.transparent,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setStateDialog) {
          return Dialog(
            backgroundColor: Colors.white,
            child: SizedBox(
              width: 300,
              height: 300,
              child: Center(
                child: Padding(
                  padding: EdgeInsetsGeometry.all(16),
                  child: Column(
                    spacing: 16,
                    children: [
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
                              GetTemplatesEvent(value: newValue),
                            );
                          }
                        },
                      ),

                      //search result
                      Expanded(
                        child: Column(
                          children: [
                            BlocBuilder<AssetBloc, AssetState>(
                              builder: (context, state) {
                                if (state is AssetLoadingState) {
                                  return CircularProgressIndicator();
                                }
                                if (state is GetTemplatesSuccsessState) {
                                  final alltemplates =
                                      state.assetTemplateEntity;
                                  return Expanded(
                                    child: ListView.builder(
                                      itemCount: alltemplates.length,
                                      itemBuilder: (context, index) {
                                        final template = alltemplates[index];
                                        return ListTile(
                                          title: Text(template.templateName),
                                          tileColor: Theme.of(
                                            context,
                                          ).colorScheme.surface,
                                          onTap: () {
                                            onSelected(template);
                                            context.pop();
                                          },
                                          onLongPress: () => showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: Text(
                                                'Apakah kamu ingin menghapus template?',
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    context.pop();
                                                  },
                                                  child: Text('Tidak'),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    if (template.id != null) {
                                                      context
                                                          .read<AssetBloc>()
                                                          .add(
                                                            DeleteTemplateEvent(
                                                              id: template.id!,
                                                            ),
                                                          );
                                                      context.pop();
                                                    }
                                                  },
                                                  child: Text('Iya'),
                                                ),
                                              ],
                                            ),
                                          ),
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
