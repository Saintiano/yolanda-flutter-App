import 'package:flutter/material.dart';

class CustomStatefulBody extends StatefulWidget {
  const CustomStatefulBody({super.key, required this.body});
  final Widget body;

  @override
  State<CustomStatefulBody> createState() => _CustomStatefulBodyState();
}

class _CustomStatefulBodyState extends State<CustomStatefulBody> {
  @override
  Widget build(BuildContext context) {
    return widget.body;
  }
}
