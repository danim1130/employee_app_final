import 'package:employee_app/domain/model/user_data.dart';
import 'package:employee_app/ui/employee_list/employee_list_bloc.dart';
import 'package:employee_app/ui/employee_list/widgets/employee_search_sliver_delegate.dart';
import 'package:employee_app/ui/employee_list/widgets/user_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class EmployeeListPage extends StatelessWidget {
  final void Function(UserData) onUserTapped;

  const EmployeeListPage({Key? key, required this.onUserTapped})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var localizations = AppLocalizations.of(context)!;
    return Scaffold(
      body: BlocBuilder<EmployeeListBloc, EmployeeListState>(
        builder: (context, state) => CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 160,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  'https://images.unsplash.com/photo-1504384308090-c894fdcc538d?fit=crop&w=600&q=80',
                  fit: BoxFit.cover,
                ),
                title: Text(localizations.employeeListTitle),
              ),
            ),
            const SliverPersistentHeader(
              pinned: true,
              delegate: SearchFieldDelegate(),
            ),
            if (state is EmployeeListSearchResult)
              _buildUserList(
                  state.users, AppLocalizations.of(context)!.searchResults)
            else if (state is EmployeeListLoaded) ...[
              _buildUserList(
                state.users
                    .where((element) => element.status == UserStatus.manager),
                localizations.employeeStatusManager,
              ),
              _buildUserList(
                state.users
                    .where((element) => element.status == UserStatus.worker),
                localizations.employeeStatusWorker,
              )
            ] else
              const SliverFillRemaining(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.pushNamed(context, '/addUser');
          context.read<EmployeeListBloc>().add(const EmployeeListLoadListEvent());
        },
      ),
    );
  }

  Widget _buildUserList(Iterable<UserData> users, String header) {
    var userList = users.toList();
    return SliverStickyHeader(
      header: Container(
        height: 48,
        color: const Color.fromRGBO(171, 177, 197, 1),
        child: Text(
          header,
          style: const TextStyle(fontSize: 24),
        ),
        alignment: Alignment.center,
      ),
      sliver: SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
        sliver: SliverList(
          delegate: sliverSeparatedBuilder(
              itemBuilder: (context, index) {
                var user = userList[index];
                return UserItem(
                  id: user.id,
                  image: NetworkImage(user.avatarUrl),
                  name: user.name,
                  email: user.email,
                  onTap: () {
                    onUserTapped(user);
                  },
                );
              },
              separatorBuilder: (context, index) =>
                  const Divider(color: Colors.transparent),
              childCount: userList.length),
        ),
      ),
    );
  }

  SliverChildDelegate sliverSeparatedBuilder({
    required IndexedWidgetBuilder itemBuilder,
    required IndexedWidgetBuilder separatorBuilder,
    required int childCount,
  }) {
    return SliverChildBuilderDelegate(
      (context, index) {
        var positionalIndex = index ~/ 2;
        if (index.isEven) {
          return itemBuilder(context, positionalIndex);
        } else {
          return separatorBuilder(context, positionalIndex);
        }
      },
      childCount: childCount * 2 - 1,
    );
  }
}
