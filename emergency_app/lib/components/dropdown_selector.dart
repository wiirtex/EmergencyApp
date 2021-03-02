import 'package:flutter/material.dart';
import 'package:emergency_app/card_gen/card_generator.dart';

class DropdownSelector extends StatefulWidget {
  final String hintText;
  final List<String> items;
  final String currentItem;

  final TextFieldKey fieldKey;
  final String additionalText;
  final double width;

  const DropdownSelector(
      {Key key, @required this.items, String hintText, this.currentItem,
        this.fieldKey, this.additionalText,this.width})

      : assert(items != null),
        this.hintText = hintText != null ? hintText : "Не выбрано",
        super(key: key);

  @override
  _DropdownSelectorState createState() => _DropdownSelectorState(currentItem);
}

class _DropdownSelectorState extends State<DropdownSelector> {
  String currentItem;
  List<DropdownMenuItem<String>> dropDownItems = [];

  _DropdownSelectorState(this.currentItem);

  @override
  void initState() {
    super.initState();
    for (String item in widget.items) {
      dropDownItems.add(
        DropdownMenuItem(


          child: Text(
            item,
            overflow: TextOverflow.ellipsis,
          ),
          value: item,
        ),
      );
    }
  }

  @override
  void didUpdateWidget(DropdownSelector oldWidget) {
    if (this.currentItem != widget.currentItem) {
      setState(() {
        this.currentItem = widget.currentItem;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    CardGenerator generator =  CardGenerator();
    return Container(

      padding: EdgeInsets.symmetric(
        horizontal: 12.0,
      ),

      decoration: BoxDecoration(

        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        color: Color(0xFFF2F2F2),
      ),
      child: DropdownButtonHideUnderline(


        child: Container(

          width: widget.width,
          height: 60,
          child:DropdownButton<String>(


          value: currentItem,
          icon: Icon(Icons.keyboard_arrow_down),
          iconEnabledColor: Color(0xFFEB5757),
          iconDisabledColor: Color(0xFFEB5757),
          items: dropDownItems,

          hint: Text(widget.hintText),

          //isExpanded: true,
          onChanged: (value) {
            setState(() {
              currentItem = value;
            });
            generator.setTextValue(widget.fieldKey, widget.additionalText);
          },
        ),
      )
      ),
    );
  }
}
