import 'package:employee_app/di/inject.dart';
import 'package:employee_app/ui/add_user/add_user.dart';
import 'package:employee_app/ui/add_user/add_user_bloc.dart';
import 'package:employee_app/ui/employee_list/employee_list_bloc.dart';
import 'package:employee_app/ui/home/responsive_home.dart';
import 'package:employee_app/ui/login/login.dart';
import 'package:employee_app/ui/login/login_bloc.dart';
import 'package:employee_app/ui/user_details/user_details.dart';
import 'package:employee_app/ui/user_details/user_details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

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
          textTheme: GoogleFonts.catamaranTextTheme(),
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
      title: 'Flutter Demo',
      home: const LoginPage(),
      routes: {
        '/addUser': (context) => const AddUserPage(),
        '/userList': (context) => const ResponsiveHomePage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name?.startsWith('/user/') ?? false) {
          if (settings.arguments == null){
            var userId = int.parse(settings.name!.split('/')[2]);
            settings = settings.copyWith(arguments: UserDetailsArguments(userId));
          }
          return MaterialPageRoute(
            builder: (_) => const UserDetailsPage(),
            settings: settings,
          );
        }
      },
    );
  }
}
