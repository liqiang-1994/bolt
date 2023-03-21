import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchTextFieldWidget extends StatelessWidget {
  ValueChanged<String>? onSubmitted;
  final VoidCallback onTab;
  final String hintText;
  final EdgeInsetsGeometry margin;

  SearchTextFieldWidget({Key? key,  this.onSubmitted, required this.hintText, required this.onTab, required this.margin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: MediaQuery.of(context).size.width,
      alignment: AlignmentDirectional.center,
      height: 40.0,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 237, 236, 237),
        borderRadius: BorderRadius.circular(40.0)
      ),
      child: TextField(
        onSubmitted: onSubmitted,
        onTap: onTab,
        cursorColor: const Color.fromARGB(255, 0, 189, 96),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 3.0),
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 20,
            color: Color.fromARGB(255, 192, 191, 191),
          ),
          prefixIcon: const Icon(
            Icons.search,
            size: 35,
            color: Color.fromARGB(255, 128, 128, 128),
          )
        ),
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}