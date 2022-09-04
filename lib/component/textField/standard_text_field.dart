import 'package:flutter/material.dart';
import '../theme/colors.dart';

class StandardTextField extends StatelessWidget {
  const StandardTextField({
    Key? key,
    required this.hintText,
    required this.onChange,
  }) : super(key: key);

  final String hintText;
  final Function onChange;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) => onChange(value),
      cursorColor: Colors.indigoAccent,
      style: Theme.of(context).textTheme.bodyText1!.copyWith(color: white200),
      decoration: InputDecoration(
          filled: true,
          fillColor: zinc500,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(color: Colors.indigoAccent, width: 2),
          ),
          hintText: hintText,
          hintStyle:
              Theme.of(context).textTheme.caption!.copyWith(color: white400)),
    );
  }
}
