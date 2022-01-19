import 'dart:math';

import 'package:carwash/screens/Drawer/selectLanguage/selectLanguage.dart';
import 'package:carwash/screens/Auth/signin/ui/signin_ui.dart';
import 'package:carwash/style/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'language/languageCubit.dart';
import 'language/locale.dart';
import 'package:carwash/user_preferences.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'map_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MapUtils.getMarkerPic();
  MobileAds.instance.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Future<int> getLogginData() => UserPreferences.getToken();

  @override
  Widget build(BuildContext context) {
    {
      return BlocProvider<LanguageCubit>(
        create: (context) => LanguageCubit(),
        child: BlocBuilder<LanguageCubit, Locale>(
          builder: (_, locale) {
            return MaterialApp(
              builder: EasyLoading.init(),
              localizationsDelegates: [
                const AppLocalizationsDelegate(),
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: [
                const Locale('en'),
                const Locale('ar'),
                const Locale('pt'),
                const Locale('fr'),
                const Locale('id'),
                const Locale('es'),
                const Locale('tr'),
                const Locale('it'),
                const Locale('sw'),
              ],
              locale: locale,
              theme: uiTheme(),
              home: Signin(),
              debugShowCheckedModeBanner: false,
            );
          },
        ),
      );
    }
  }
}
