import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:movieapp/resources/AppColors.dart';
import 'package:movieapp/ui/screens/favourite/bloc/bloc.dart';
import 'package:movieapp/ui/screens/favourite/favorite_screen.dart';
import 'package:movieapp/ui/screens/home/bloc/movie_block.dart';
import 'package:movieapp/ui/screens/home/home_screen.dart';
import 'package:movieapp/ui/screens/maps/maps_screen.dart';
import 'package:movieapp/utils/Locale.dart';
import 'package:movieapp/utils/di.dart' as di;
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:movieapp/utils/alert_dialog_widget.dart';
import 'package:movieapp/ui/screens/splash_screen.dart';

import 'data/network/NetworkService.dart';
//// debendency injection ----get it
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPreference = await SharedPreferences.getInstance();
  if (sharedPreference.containsKey(di.FIRST_TIME) == false) {
    di.getIt.registerSingleton(Locale('en', 'US'), instanceName: di.LANG_NAME);
    sharedPreference.setBool(di.FIRST_TIME, false);
  } else {
    di.getIt.registerSingleton(
        Locale(sharedPreference.getString('codeL'),
            sharedPreference.getString('codeC')),
        instanceName: di.LANG_NAME);
  }
  await di.initApp();

  runApp(EasyLocalization(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    appLocale = AppLocale(context);
    return EasyLocalizationProvider(
      data: appLocale.data,
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,

            //app-specific localization
            EasylocaLizationDelegate(
                locale: EasyLocalizationProvider.of(context).data.locale,
                path: 'langs'),
          ],
          supportedLocales: [Locale('en', 'US'), Locale('ar', 'EG')],
          locale: EasyLocalizationProvider.of(context).data.savedLocale,
          theme: ThemeData(
            primarySwatch: AppColors.COLOR_PRIMARY,
          ),
          home: SplashScreen()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _selectedIndex = 0;

  Widget getScreen(int index) {
    if (index == 0) {
      return HomeScreen();
    } else if (index == 1) {
      return FavoriteScreen();
    } else if (index == 2) {
      return MapsScreen();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    appLocale = AppLocale(context);
    return EasyLocalizationProvider(
      data: appLocale.data,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<MovieBloc>(
            create: (BuildContext context) => di.getIt<MovieBloc>(),
          ),
          BlocProvider<FavoriteBloc>(
            create: (BuildContext context) => di.getIt<FavoriteBloc>(),
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            title: Text(appLocale.tr('Title')),
            actions: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return SettingModalSheetWidget();
                      },
                    );
                  })
            ],
          ),
          body: getScreen(_selectedIndex),
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    color: Colors.green,
                  ),
                  title: Text(appLocale.tr('Home_Tab_title'))),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite, color: Colors.green),
                  title: Text(appLocale.tr('Favorite_Tab_title'))),
              BottomNavigationBarItem(
                  icon: Icon(Icons.map, color: Colors.green),
                  title: Text(appLocale.tr('Cinema_Tab_title'))),
            ],
            backgroundColor: Colors.blueGrey,
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.lightGreenAccent,
            unselectedItemColor: Colors.white,
            onTap: (index) => setState(() {
              _selectedIndex = index;
            }),
          ),
        ),
      ),
    );
  }
}

class SettingModalSheetWidget extends StatefulWidget {
  @override
  _SettingModalSheetWidgetState createState() =>
      _SettingModalSheetWidgetState();
}

class _SettingModalSheetWidgetState extends State<SettingModalSheetWidget> {
  int selectedValue = -1;

  setValue(int value) {
    setState(() {
      selectedValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (selectedValue == -1) {
      selectedValue =
          (EasyLocalizationProvider.of(context).data.savedLocale.languageCode ==
                  'en')
              ? 1
              : 2;
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            AutoSizeText(
              appLocale.tr('Modal_sheet_title'),
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
              minFontSize: 15,
              maxFontSize: 20,
            ),
            Divider(
              color: Colors.grey[400],
              height: 10,
            ),
            SizedBox(
              height: 50,
              child: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    AutoSizeText(
                      appLocale.tr('Lang_Settings_label'),
                      minFontSize: 15,
                      maxFontSize: 20,
                      style: TextStyle(color: Colors.black),
                    ),
                    Flexible(
                      fit: FlexFit.loose,
                      child: RadioListTile(
                        dense: true,
                        title: AutoSizeText(
                          'English',
                          minFontSize: 12,
                          maxFontSize: 15,
                          style: TextStyle(color: Colors.black),
                        ),
                        value: 1,
                        groupValue: selectedValue,
                        onChanged: setValue,
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.loose,
                      child: RadioListTile(
                        title: AutoSizeText(
                          'عربي',
                          minFontSize: 12,
                          maxFontSize: 15,
                          style: TextStyle(color: Colors.black),
                        ),
                        value: 2,
                        groupValue: selectedValue,
                        onChanged: setValue,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              height: 10,
              color: Colors.grey[400],
            ),
            RaisedButton(
              color: Colors.orange,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialogWidget(() {
                      if (this.selectedValue == 1) {
                        appLocale.data.changeLocale(Locale("en", "US"));
                        di.getIt.registerSingleton(Locale("en", "US"),
                            instanceName: di.LANG_NAME);
                        di.getIt<NetworkService>().resetDio();

                        print(Localizations.localeOf(context).languageCode);
                      } else if (this.selectedValue == 2) {
                        appLocale.data.changeLocale(Locale("ar", "EG"));
                        di.getIt.registerSingleton(Locale("ar", "EG"),
                            instanceName: di.LANG_NAME);
                        di.getIt<NetworkService>().resetDio();
                        print(Localizations.localeOf(context).languageCode);
                      }

                      Navigator.pop(context);
                      Navigator.pop(context);
                    });
                  },
                );
              },
              child: AutoSizeText(
                appLocale.tr('Save_btn'),
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            )
          ]),
    );
  }
}
