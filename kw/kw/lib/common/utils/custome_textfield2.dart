//import 'package:flutter/material.dart';

//class CustomeTextfield2 extends StatelessWidget {
//  final Key? formFieldKey;
//  final TextEditingController? controller;
//  final String hintText;
//  final String validatorText;
//  final TextInputType keyboardType;

//  const CustomeTextfield2({
//    super.key,
//    this.formFieldKey,
//    this.controller,
//    required this.hintText,
//    required this.validatorText,
//    this.keyboardType = TextInputType.text,
//  });

//  @override
//  Widget build(BuildContext context) {
//    return TextFormField(
//      key: formFieldKey,
//      controller: controller,
//      decoration: InputDecoration(
//        hintText: hintText,
//      ),
//      keyboardType: keyboardType,
//      validator: (value) {
//        if (value == null || value.isEmpty) {
//          return validatorText;
//        }
//        return null;
//      },
//    );
//  }
//}
