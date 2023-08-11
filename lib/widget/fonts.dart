// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class text extends StatelessWidget {
  const text(param0,
      {super.key,
      required this.data,
      required this.color,
      required this.size,
      this.Bold});
  final String data;
  final Color color;
  final double size;
  final Bold;
  @override
  Widget build(BuildContext context) {
    return Text(data,
        style: GoogleFonts.bitter(
          color: color,
          fontSize: size,
          fontWeight: Bold,
        ));
  }
}
