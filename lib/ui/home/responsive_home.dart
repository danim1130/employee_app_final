import 'package:employee_app/di/inject.dart';
import 'package:employee_app/ui/employee_list/employee_list.dart';
import 'package:employee_app/ui/employee_list/employee_list_bloc.dart';
import 'package:employee_app/ui/user_details/user_details.dart';
import 'package:employee_app/ui/user_details/user_details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResponsiveHomePage extends StatelessWidget{
  const ResponsiveHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      getIt<EmployeeListBloc>()..add(const EmployeeListLoadListEvent()),
      child: const ResponsiveHomeContent(),
    );
  }

}

class ResponsiveHomeContent extends StatelessWidget {
  const ResponsiveHomeContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        var isWideLayout = constraints.maxWidth > 700;
        if (!isWideLayout) {
          return EmployeeListPage(
            onUserTapped: (user) async {
              await Navigator.pushNamed(
                context,
                '/user/${user.id}',
                arguments: UserDetailsArguments(user.id, user.avatarUrl),
              );
            },
          );
        } else {
          return Row(
            children: [
              SizedBox(
                width: 300,
                child: Builder(
                  builder: (context) =>
                      EmployeeListPage(
                        onUserTapped: (user) {
                          context
                              .read<EmployeeListBloc>()
                              .add(EmployeeListUserSelected(user));
                        },
                      ),
                ),
              ),
              const VerticalDivider(
                color: Color.fromRGBO(165, 172, 180, 1),
                thickness: 2,
                width: 2,
              ),
              Expanded(
                child: BlocBuilder<EmployeeListBloc, EmployeeListState>(
                  buildWhen: (prevState, newState) =>
                  newState is EmployeeListLoaded,
                  builder: (context, state) {
                    var userState = state as EmployeeListLoaded;
                    var selectedUser = userState.selectedUser;
                    return BlocProvider<UserDetailsBloc>(
                        key: ValueKey(selectedUser?.id),
                        create: (context) {
                          var bloc = getIt<UserDetailsBloc>();
                          if (selectedUser != null){
                            bloc.add(UserDetailsLoadEvent(selectedUser.id));
                          }
                          return bloc;
                        },
                        child: UserDetailsContent(
                          onUserDeleted: () {
                            context.read<EmployeeListBloc>()
                              .add(const EmployeeListUserSelected(null));
                          },
                        ),
                      );
                  },
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
