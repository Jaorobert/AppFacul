import 'dart:io';

import 'package:app_facul/src/data/services/socket-service.dart';
import 'package:app_facul/src/pages/home_page/home_page.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: const LoginPage(),
    );
  }
}
