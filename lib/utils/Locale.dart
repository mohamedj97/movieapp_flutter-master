import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:easy_localization/easy_localization_provider.dart';
import 'package:flutter/cupertino.dart';

class AppLocale {
  BuildContext _context;
  AppLocalizations _strings;

  AppLocale(BuildContext context) {
    this._context = context;
    _strings = AppLocalizations.of(_context);
  }

  get data => EasyLocalizationProvider.of(_context).data;

  String tr(String key, {List<String> args}) {
    return _strings.tr(key, args: args);
  }
}

AppLocale appLocale;
