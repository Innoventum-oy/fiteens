import 'package:core/core.dart' as core;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../util/utils.dart';

class TextFieldItem extends StatefulWidget {
  final core.FormElement element;
  final String value;
  final Map<String, dynamic>? params;
  final Function onChanged;

  TextFieldItem({required this.element, required this.value, required this.onChanged, this.params});

  @override
  _TextFieldItemState createState() => _TextFieldItemState();
}

class _TextFieldItemState extends State<TextFieldItem> {
  late String selectedValue;
  final _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    _textEditingController.addListener(updateTextFieldValue);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    _textEditingController.dispose();
    super.dispose();
  }

  void updateTextFieldValue() {
    String? value = _textEditingController.text;
    setState(() {
      this.selectedValue = value;
      widget.onChanged(value);
      //DisplayForm.of(context)!.formData[widget.element.id!] = value;
    });
  }

  Widget build(BuildContext context) {
    this.selectedValue = widget.value;
    return TextField(
      controller: _textEditingController,
      //textDirection: TextDirection
      maxLines: widget.params!['maxlines'] ?? 10,

      decoration: InputDecoration(
          hintText: widget.element.description ??
              AppLocalizations.of(context)!.writeAnswerHere,
          //+': '+widget.element.title.toString(),
          fillColor: createMaterialColor('#FFEDE30E')),
    );
  }
}
