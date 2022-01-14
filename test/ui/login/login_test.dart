import 'package:bloc_test/bloc_test.dart';
import 'package:employee_app/ui/login/login.dart';
import 'package:employee_app/ui/login/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../main_app_test.dart';

class LoginBlocMock extends MockBloc<LoginEvent, LoginState>
    implements LoginBloc {}

void main() {
  group('LoginContent functionality', () {
    testWidgets('LoginContent sign in', (WidgetTester tester) async {
      var loginBloc = LoginBlocMock();
      whenListen(loginBloc, const Stream<LoginState>.empty(),
          initialState: const LoginInput());
      await tester.pumpWidget(
        MainAppTest(
          testingWidget: BlocProvider<LoginBloc>.value(
            value: loginBloc,
            child: const LoginContent(),
          ),
        ),
      );
      await tester.enterText(
          find.byType(FormBuilderTextField).first, 'dani@example.com');
      await tester.enterText(find.byType(FormBuilderTextField).last, '12');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();
      verify(() =>
          loginBloc.add(LoginStartLogin('dani@example.com', '12', false)));
      await expectLater(find.byType(MaterialApp), matchesGoldenFile('login_page.png'));
    });
    testWidgets('LoginContent progress indicator', (WidgetTester tester) async {
      var loginBloc = LoginBlocMock();
      whenListen(loginBloc, const Stream<LoginState>.empty(),
          initialState: const LoginLoading());
      await tester.pumpWidget(
        MainAppTest(
          testingWidget: BlocProvider<LoginBloc>.value(
            value: loginBloc,
            child: const LoginContent(),
          ),
        ),
      );
      await tester.pump(Duration(days: 5000));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.descendant(of: find.byType(ElevatedButton), matching: find.byType(CircularProgressIndicator)), findsOneWidget);
      await expectLater(find.byType(MaterialApp), matchesGoldenFile('login_page_loading.png'));
    });
  });
}
