import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../modules/login/login_screen.dart';
import '../network/local/cache_helper.dart';


void signOut(BuildContext context) {
  CacheHelper.removeData(key: 'token').then(
    (value) => Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    ),
  );
  myToken = '';
}

String myToken =
    '';
