import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/main.dart';
import 'package:movieapp/resources/AppColors.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MyHomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return EasyLocalizationProvider(
      data: EasyLocalizationProvider.of(context).data,
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/background.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            color: Colors.black.withOpacity(0.6),
            width: double.infinity,
            height: double.infinity,
            child: Center(
              child: AutoSizeText(
                AppLocalizations.of(context).tr('Title'),
                minFontSize: 25,
                maxFontSize: 30,
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.TEXT_COLOR),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
