import 'package:elbaraa/main.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart'; 

void showGlobalSnackBar(String message) {
  Future.microtask(() {
    final context = navigatorKey.currentContext;
    if (context != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message.i18n()),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 4),
        ),
      );
    } else {
      debugPrint('⚠️ Could not show snackbar: context is null');
    }
  });
}