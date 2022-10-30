import 'package:flutter/material.dart';

class TmcTextField extends StatefulWidget {
  String? hintText;
  TextEditingController? controller;
  String? Function(String?)? validate;
  Widget? icon;
  bool isPassowrd;
  bool check;
  int? maxLines;
  final TextInputAction? inputAction;
  final FocusNode? focusNode;
  TmcTextField({super.key, 
    this.hintText,
    this.controller,
    this.validate,
    this.maxLines,
    this.icon,
    this.check = false,
    this.inputAction,
    this.focusNode,
    this.isPassowrd = false,
  });

  @override
  State<TmcTextField> createState() => _TmcTextFieldState();
}

class _TmcTextFieldState extends State<TmcTextField> {
  bool visible = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 17, vertical: 7),
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
        maxLines: widget.maxLines == 1 ? 1 : widget.maxLines,
        focusNode: widget.focusNode,
        textInputAction: widget.inputAction,
        controller: widget.controller,
        obscureText: widget.isPassowrd == false ? false : widget.isPassowrd,
        validator: widget.validate,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: widget.hintText ?? 'hint Text...',
          suffixIcon: widget.icon,
          contentPadding: const EdgeInsets.all(10),
        ),
      ),
    );
  }
}