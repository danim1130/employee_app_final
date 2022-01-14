import 'package:employee_app/ui/employee_list/employee_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class SearchFieldDelegate extends SliverPersistentHeaderDelegate{
  const SearchFieldDelegate();

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: TextField(
        onChanged: (value){
          if (value.isEmpty){
            context.read<EmployeeListBloc>().add(const EmployeeListLoadListEvent());
          } else {
            context.read<EmployeeListBloc>().add(EmployeeListSearch(value));
          }
        },
        decoration: const InputDecoration(
          icon: Icon(Icons.search, color: Colors.black),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
        cursorColor: Colors.black,
      ),
    );
  }

  @override
  double get maxExtent => 60;

  @override
  double get minExtent => 60;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return this != oldDelegate;
  }
}