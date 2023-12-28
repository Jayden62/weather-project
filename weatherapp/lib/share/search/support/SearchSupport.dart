import 'package:flutter/material.dart';

class SearchSupport {
  /// Hint text
  String? hintText;

  /// Show or hide read only
  bool isReadOnly = false;

  /// Controller
  TextEditingController? controller;

  /// Color
  Color color = Color(0xFFFAFAFA);

  /// Focus node
  FocusNode? focusNode;

  /// Set margin bottom
  double marginBottom = 0;

  /// Font size
  double fontSize = 14;
}
