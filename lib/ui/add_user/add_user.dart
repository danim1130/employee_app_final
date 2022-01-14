import 'dart:math';

import 'package:cross_file/cross_file.dart';
import 'package:employee_app/data/user/user_data_source.dart';
import 'package:employee_app/di/inject.dart';
import 'package:employee_app/main.dart';
import 'package:employee_app/ui/add_user/add_user_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:employee_app/domain/model/user_data.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class AddUserPage extends StatelessWidget {
  const AddUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AddUserBloc>(),
      child: const AddUserContent(),
    );
  }

}

class AddUserContent extends StatelessWidget {
  const AddUserContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var localizations = AppLocalizations.of(context)!;
    return WillPopScope(
      onWillPop: () async {
        var result = await showDialog(
          context: context,
          builder: (context) =>
              AlertDialog(
                title: Text(localizations.alertDialogTitle),
                actions: [
                  TextButton(
                    child: Text(localizations.cancel),
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                  ),
                  TextButton(
                    child: Text(localizations.leave),
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                  ),
                ],
              ),
        );
        return result;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(localizations.addEmployeeTitle),
        ),
        body: BlocListener<AddUserBloc, AddUserState>(
          listener: (context, newState) {
            if (newState is AddUserSuccess) {
              Navigator.of(context).pop();
            } else if (newState is AddUserError) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(localizations.generalError)));
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: FormBuilder(
              child: Column(
                children: [
                  FormBuilderTextField(
                    name: 'name',
                    decoration: InputDecoration(
                        icon: Icon(Icons.person),
                        labelText: localizations.addEmployeeNameLabel,
                        hintText: localizations.addEmployeeNameHint,
                        border: OutlineInputBorder()),
                    keyboardType: TextInputType.name,
                  ),
                  const SizedBox(height: 16),
                  FormBuilderTextField(
                    name: 'email',
                    decoration: InputDecoration(
                        icon: Icon(Icons.mail),
                        labelText: localizations.addEmployeeEmailLabel,
                        border: OutlineInputBorder()),
                    keyboardType: TextInputType.emailAddress,
                    validator: EmailValidator(
                        errorText: localizations.errorEmailFormat),
                  ),
                  const SizedBox(height: 16),
                  FormBuilderTextField(
                    name: 'phone',
                    decoration: InputDecoration(
                        icon: Icon(Icons.phone),
                        labelText: localizations.addEmployeePhoneLabel,
                        border: OutlineInputBorder()),
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 16),
                  FormBuilderDropdown<UserStatus>(
                    name: 'status',
                    decoration: InputDecoration(
                        labelText: localizations.addEmployeeStatusLabel,
                        border: OutlineInputBorder()),
                    initialValue: UserStatus.worker,
                    items: [
                      DropdownMenuItem(
                          child: Text(localizations.employeeStatusManager),
                          value: UserStatus.manager),
                      DropdownMenuItem(
                          child: Text(localizations.employeeStatusWorker),
                          value: UserStatus.worker),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Builder(builder: (context) {
                      return BlocBuilder<AddUserBloc, AddUserState>(
                        builder: (context, state) {
                          return ElevatedButton(
                            child: Text(localizations.addEmployeeCreateLabel),
                            onPressed: state is AddUserLoading ? null : () {
                              var form = FormBuilder.of(context)!;
                              if (form.saveAndValidate()) {
                                var user = UserData(
                                  Random().nextInt(1 << 31),
                                  form.value['name']!,
                                  form.value['email']!,
                                  form.value['phone']!,
                                  form.value['status']!,
                                  'https://randomuser.me/api/portraits/men/${Random()
                                      .nextInt(100)}.jpg',
                                );
                                context
                                    .read<AddUserBloc>()
                                    .add(AddUserRegisterEvent(user));
                              }
                            },
                          );
                        },
                      );
                    }),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
