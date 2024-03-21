import 'package:core/core.dart' as core;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../util/utils.dart';

class TextFormFieldItem extends StatefulWidget {
  final core.FormElement element;
  final String value;
  final Map<String, dynamic> params;
  final Function onChanged;

  const TextFormFieldItem({super.key, required this.element, required this.value, required this.onChanged,required this.params});

  @override
  TextFormFieldItemState createState() => TextFormFieldItemState();
}

class TextFormFieldItemState extends State<TextFormFieldItem> {
  late String selectedValue;
  final _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // print('textformfield initialValue in initState: '+widget.value);
    // Start listening to changes.
    _textEditingController.text = widget.value;
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
    //  print('running updateTextFieldValue, value: '+value);
    setState(() {
      selectedValue = value;
      widget.onChanged(value);
      //DisplayForm.of(context)!.formData[widget.element.id!] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    //  print('building textformfield '+widget.element.id.toString()+', initialValue: '+widget.value);
    selectedValue = widget.value;
    return TextFormField(
        autovalidateMode: AutovalidateMode.always,
        controller: _textEditingController,
        // initialValue: widget.value,
        maxLines: widget.params['maxlines'] ?? 1,
        decoration: InputDecoration(
            hintText: widget.element.description ??
                AppLocalizations.of(context)!.writeAnswerHere,
            //+': '+widget.element.title.toString(),
            fillColor: createMaterialColor('#FFEDE30E')),
        validator: (String? value) {
          if (widget.element.required == false) {
            //   print('element is not required!');
            return null;
          }
          return value != null
              ? null
              : AppLocalizations.of(context)!.fieldCannotBeEmpty;
        });
  }
}
