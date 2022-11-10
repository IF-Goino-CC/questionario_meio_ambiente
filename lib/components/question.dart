import 'package:flutter/material.dart';

// mapa ubanistico
// identificacao pessoal
// infra da cidade


class Question extends StatefulWidget {
  final Function onUpdate;
  final String id;
  final String name;
  final String description;
  final bool isMulti;
  final List<String> options;
  const Question({Key? key, 
  required this.id,
  required this.name, 
  this.description = '',
  required this.options,
  required this.onUpdate,
  this.isMulti = false}) : super(key: key);

  @override
  State<Question> createState() => QuestionState();
}



class QuestionState extends State<Question> {
  late Map<int, bool> values = { for (var v in [for (var i = 0; i < widget.options.length; i++) i]) v:  false };
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(widget.name),
        Text(widget.description),
        ListView.builder(
          // physics: NeverScrollableScrollPhysics(),
        // scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount:  values.keys.length-1,
        itemBuilder: (context, index) {
          return Row(
            children: [
              Checkbox(
                tristate: true,
                value: values[index]?? false, 
              onChanged: (bool? value) => handleChange(index, value??false)),
              Text(widget.options[index])
            ],
          );
        }
        ),
        const Divider(
          height: 2,
          color: Color.fromARGB(255, 85, 85, 85),
        )
      ],
    );
  }

  handleChange(int key , bool val){
    if(! widget.isMulti){
      for (var k in values.keys) { 
        setState(() {
          values[k] = false;
        });
      }
    }
    setState(() {
      values[key] = val;
    });
    var indices = values.keys.where((e) => values[e] == true );
    print(indices);
    var newVal = indices.map((i) =>  widget.options[i]).toList();
    widget.onUpdate( widget.id,newVal);
  }
}