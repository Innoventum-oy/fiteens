import 'package:core/core.dart' as core;
import 'package:flutter/material.dart';

class RadioGroup extends StatefulWidget {
  final core.FormElement element;
  final List<dynamic> options;
  final int? selectedOption; // default / original selected option
  final Function onChanged;
  RadioGroup(
      {required this.element, required this.options, required this.onChanged,this.selectedOption});

  @override
  RadioGroupWidget createState() => RadioGroupWidget();
}
class RadioGroupWidget extends State<RadioGroup> {
  // Default Radio Button Item
  int? selectedOptionValue;

  Widget build(BuildContext context) {
    if (this.selectedOptionValue == null&& widget.selectedOption!=null)
      this.selectedOptionValue = widget.selectedOption;
    //  print('building radio group; group value is '+this.selectedOptionValue.toString());

    return Container(
      //height: 350.0,
      child: Column(children: [
        if (widget.element.description != null)
          Text(widget.element.description ?? ''),
        ...widget.options
            .map((data) => RadioListTile<dynamic>(
          title: Text("${data.value}"),
          groupValue: this.selectedOptionValue,
          value: data.id,
          onChanged: (val) {
            setState(() {
              //   print('selecting: '+data.value.toString()+' ('+data.id.toString()+')');
              this.selectedOptionValue = data.id;

              widget.onChanged(data.id);
            });
          },
        ))
            .toList(),
      ]),
    );
  }
}