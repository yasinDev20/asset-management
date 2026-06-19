import 'package:assetmanagement/core/common/widgets/button.dart';
import 'package:assetmanagement/core/common/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';

class EditFieldPage extends StatefulWidget {
  final void Function({
    required String id,
    required String name,
    required String? code,
  })
  onEdit;
  final void Function() onDeleted;
  final String title;
  final String id;
  final String name;
  final String? code;
  const EditFieldPage({
    super.key,
    required this.id,
    required this.name,
    this.code,
    required this.onEdit,
    required this.title,
    required this.onDeleted,
  });

  @override
  State<EditFieldPage> createState() => _EditFieldPageState();
}

class _EditFieldPageState extends State<EditFieldPage> {
  final _formKey = GlobalKey<FormState>();
  late String name;
  late String? code;

  @override
  void initState() {
    super.initState();
    name = widget.name;
    code = widget.code;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        context.pop(true);
      },
      child: Scaffold(
        appBar: AppBar(title: Text('Edit ${widget.title}')),
        body: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 500),
            child: Padding(
              padding: EdgeInsetsGeometry.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 16,
                  children: [
                    if (widget.code != null)
                      CommonTextFormField(
                        labelText: 'Kode',
                        initialValue: widget.code,
                        textCapitalization: TextCapitalization.characters,
                        validator: FormBuilderValidators.uppercase(),
                        inputFormatters: [
                          TextInputFormatter.withFunction(
                            (oldValue, newValue) => newValue.copyWith(
                              text: newValue.text.toUpperCase(),
                            ),
                          ),
                        ],
                        onChanged: (value) => code = value,
                      ),
                    CommonTextFormField(
                      labelText:
                          widget.title[0].toUpperCase() +
                          widget.title.substring(1),
                      initialValue: widget.name,
                      validator: FormBuilderValidators.required(),
                      inputFormatters: [
                        TextInputFormatter.withFunction(
                          (oldValue, newValue) => newValue.copyWith(
                            text:
                                newValue.text[0].toUpperCase() +
                                newValue.text.substring(1),
                          ),
                        ),
                      ],
                      onChanged: (value) => name = value,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            widget.onDeleted();
                          },
                          child: Text(
                            'Hapus',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        CommonButton(
                          text: 'Edit',
                          onPressed: () {
                            if (_formKey.currentState?.validate() == true) {
                              widget.onEdit(
                                id: widget.id,
                                name: name,
                                code: code,
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
