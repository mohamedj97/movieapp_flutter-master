import 'package:flutter/services.dart';
import 'dart:convert';

class Secret {
  static Future<String> getTMDBKey() async {
    Map<String, dynamic> json =
        jsonDecode(await rootBundle.loadString('assets/keys.json'));
    return json['TMDB_KEY'];
  }
}
