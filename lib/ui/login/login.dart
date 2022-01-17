import 'package:employee_app/di/inject.dart';
import 'package:employee_app/ui/login/login_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LoginBloc>(),
      child: const LoginContent(),
    );
  }
}

class LoginContent extends StatelessWidget {
  const LoginContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginFinished) {
            if (state.successfullyFinished) {
              Navigator.pushReplacementNamed(context, '/userList');
            } else if (state.error != null) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(AppLocalizations.of(context)!.loginError)));
            }
          }
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              top: 82,
              left: 0,
              right: 0,
              child: Text(
                AppLocalizations.of(context)!.loginTitle,
                textAlign: TextAlign.center,
                style: GoogleFonts.catamaran(
                  fontSize: 48,
                  color: Colors.black,
                ),
              ),
            ),
            Positioned.fill(
              child: _buildForm(),
            ),
          ],
        ),
      ),
    );
  }

  FormBuilder _buildForm() {
    return FormBuilder(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FormBuilderTextField(
                  name: 'email',
                  enabled: state is! LoginLoading,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromRGBO(38, 47, 77, 0.2),
                    prefixIcon: const Icon(Icons.email),
                    hintText:
                    AppLocalizations.of(context)!.addEmployeeEmailLabel,
                    border: const UnderlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                FormBuilderTextField(
                  name: 'password',
                  enabled: state is! LoginLoading,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromRGBO(38, 47, 77, 0.2),
                    prefixIcon: const Icon(Icons.lock),
                    hintText: AppLocalizations.of(context)!.passwordLabel,
                    border: const UnderlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                FormBuilderCheckbox(
                  name: 'auto_login',
                  title: Text(AppLocalizations.of(context)!.automaticSignIn),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromRGBO(63, 61, 148, 1),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        child: Text(
                          AppLocalizations.of(context)!
                              .loginButton
                              .toUpperCase(),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 4),
                      ),
                      if (state is LoginLoading)
                        const Positioned.fill(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  onPressed: state is LoginLoading
                      ? null
                      : () {
                    var form = FormBuilder.of(context)!;
                    if (form.saveAndValidate()) {
                      var email = form.value['email'] ?? '';
                      var password = form.value['password'] ?? '';
                      var isAutoLogin = form.value['auto_login'] ?? false;
                      context.read<LoginBloc>().add(
                        LoginStartLogin(
                          email,
                          password,
                          isAutoLogin,
                        ),
                      );
                    }
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
