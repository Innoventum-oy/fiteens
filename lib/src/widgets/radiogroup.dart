import 'package:core/core.dart' as core;
import 'package:flutter/material.dart';

class RadioGroup extends StatefulWidget {
  final core.FormElement element;
  final List<dynamic> options;
  final int? selectedOption; // default / original selected option
  final Function onChanged;
  const RadioGroup(
      {super.key, required this.element, required this.options, required this.onChanged,this.selectedOption});

  @override
  RadioGroupWidget createState() => RadioGroupWidget();
}
class RadioGroupWidget extends State<RadioGroup> {
  // Default Radio Button Item
  int? selectedOptionValue;

  @override
  Widget build(BuildContext context) {
    if (selectedOptionValue == null&& widget.selectedOption!=null) {
      selectedOptionValue = widget.selectedOption;
    }
    //  print('building radio group; group value is '+this.selectedOptionValue.toString());

    return Column(children: [
      if (widget.element.description != null)
        Text(widget.element.description ?? ''),
      ...widget.options
          .map((data) => RadioListTile<dynamic>(
        title: Text("${data.value}"),
        groupValue: selectedOptionValue,
        value: data.id,
        onChanged: (val) {
          setState(() {
            //   print('selecting: '+data.value.toString()+' ('+data.id.toString()+')');
            selectedOptionValue = data.id;

            widget.onChanged(data.id);
          });
        },
      ))
          ,
    ]);
  }
}