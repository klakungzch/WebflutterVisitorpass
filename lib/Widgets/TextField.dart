import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget textField(BuildContext context, TextEditingController controller, Icon icon, String label, bool hideText) {
  return Container(
    child: TextField(
      obscureText: hideText,
      controller: controller,
      keyboardType: TextInputType.name,
      textAlign: TextAlign.left,
      style: TextStyle(fontSize: 16),
      inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.singleLineFormatter
      ],
      maxLength: 15,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: icon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(
            color: Colors.amber,
            style: BorderStyle.solid,
          ),
        ),
      ),
    ),
  );
}

Widget textFieldnews(BuildContext context, TextEditingController controller, Icon icon, String label, bool hideText) {
  return Container(
    child: TextField(
      obscureText: hideText,
      controller: controller,
      keyboardType: TextInputType.name,
      textAlign: TextAlign.left,
      style: TextStyle(fontSize: 16),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.deny(RegExp(r'^\s'))
      ],
      maxLength: 255,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: icon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(
            color: Colors.amber,
            style: BorderStyle.solid,
          ),
        ),
      ),
    ),
  );
}
Widget textFieldnewsDetail(BuildContext context, TextEditingController controller, Icon icon, String label, bool hideText) {
  return Container(
    child: TextField(
      obscureText: hideText,
      controller: controller,
      keyboardType: TextInputType.multiline,
      textAlign: TextAlign.left,
      style: TextStyle(fontSize: 16),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.singleLineFormatter
      ],
      maxLength: 1000,
      maxLines: 4,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: icon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(
            color: Colors.amber,
            style: BorderStyle.solid,
          ),
        ),
      ),
    ),
  );
}
Widget textFieldSearch(TextEditingController controller, String label, double width, double height) {
  return Container(
    constraints: BoxConstraints(maxWidth: width, maxHeight: height),
    child: TextField(
      controller: controller,
      enabled: false,
      textAlign: TextAlign.left,
      style: TextStyle(fontSize: 16),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(
            color: Colors.amber,
            style: BorderStyle.solid,
          ),
        ),
      ),
    ),
  );
}
Widget textFieldSearchTrue(TextEditingController controller, String label, double width, double height) {
  return Container(
    constraints: BoxConstraints(maxWidth: width, maxHeight: height),
    child: TextField(
      controller: controller,
      textAlign: TextAlign.left,
      style: TextStyle(fontSize: 16),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(
            color: Colors.amber,
            style: BorderStyle.solid,
          ),
        ),
      ),
    ),
  );
}