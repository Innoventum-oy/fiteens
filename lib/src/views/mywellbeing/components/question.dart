import 'dart:developer';

import 'package:core/core.dart' as core;
import 'package:flutter/material.dart';

class Question extends StatefulWidget {
  final core.FormElement element;

  final int? selectedOption; // default / original selected option
  final Function onChanged;
  final List<Widget>? buttons;
  final int index;
  final int pageCount;
  const Question(
      {super.key, required this.element, required this.onChanged, required this.index, required this.pageCount,this.selectedOption, this.buttons});

  @override
  RadioGroupWidget createState() => RadioGroupWidget();
}
class RadioGroupWidget extends State<Question> {
  // Default Radio Button Item
  int? selectedOptionValue;
  List<dynamic>? options;


  @override
  Widget build(BuildContext context) {
    options = widget.element.elements;
    log('Building Question ${widget.element.id} ${widget.element.title} with ${widget.element.elements?.length} options, selected: ${widget.selectedOption}');
    if (selectedOptionValue == null&& widget.selectedOption!=null) {
      selectedOptionValue = widget.selectedOption;
    }
    //  print('building radio group; group value is '+this.selectedOptionValue.toString());

    return Column(children: [
      Text(widget.element.title??'',style:const TextStyle(fontSize:18,fontWeight: FontWeight.bold)),
      if (widget.element.description != null)
        Text(widget.element.description??''),
      ...?options
          ?.map((data) => Card(child:RadioListTile<dynamic>(
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
      )))
          ,
      if(widget.buttons!=null)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: widget.buttons??[],),
    Center(child: Text("${widget.index} / ${widget.pageCount}",
    style: const TextStyle(fontSize: 14),),),
    ]);
  }
}