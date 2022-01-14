import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

class MainAppTest extends StatelessWidget{
  final Widget testingWidget;

  const MainAppTest({Key? key, required this.testingWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        AppLocalizations.delegate,
      ],
      locale: const Locale('en'),
      supportedLocales: const [
        Locale('en', ''),
        Locale('hu', ''),
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: AppBarTheme(
            backgroundColor: const Color.fromRGBO(123, 129, 151, 1),
            foregroundColor: Colors.white,
            titleTextStyle:
            GoogleFonts.catamaran(fontSize: 24, color: Colors.white),
          ),
          scaffoldBackgroundColor: const Color.fromRGBO(199, 204, 219, 1),
          iconTheme: const IconThemeData(
            color: Color.fromRGBO(42, 50, 75, 1),
          )),
      title: 'Flutter Test Demo',
      home: testingWidget,
    );
  }
}

void main(){}