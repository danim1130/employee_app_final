

import 'package:employee_app/ui/employee_list/employee_list_bloc.dart';
import 'package:employee_app/widgets/border_transition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserItem extends StatelessWidget {
  final int id;
  final ImageProvider image;
  final String name;
  final String email;
  final VoidCallback onTap;

  const UserItem({
    Key? key,
    required this.image,
    required this.name,
    required this.email,
    required this.onTap,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeeListBloc, EmployeeListState>(
      builder: (context, state) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(4)),
            color: (state is EmployeeListLoaded ? state : null)?.selectedUser?.id == id
                ? const Color.fromRGBO(154, 158, 173, 1)
                : const Color.fromRGBO(223, 220, 221, 1),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.25),
                offset: Offset(2, 2),
                blurRadius: 10,
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          height: 70,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              splashColor: const Color.fromRGBO(133, 152, 223, 1),
              child: Row(
                children: [
                  Hero(
                    tag: 'avatar_$id',
                    child: Image(image: image),
                    flightShuttleBuilder: (flightContext,
                        animation,
                        direction,
                        fromHeroContext,
                        toHeroContext,) {
                      var toHero = toHeroContext.widget as Hero;
                      var borderRadiusAnimation = animation.drive(
                          BorderRadiusTween(
                            begin: const BorderRadius.horizontal(
                                left: Radius.circular(4)),
                            end: BorderRadius.circular(32),
                          ));
                      return BorderRadiusTransition(
                        animation: borderRadiusAnimation,
                        child: toHero.child,
                      );
                    },
                    createRectTween: (begin, end) =>
                        RectTween(begin: begin, end: end),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Text(
                          name,
                          style: const TextStyle(fontSize: 18),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Text(
                          email,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 14),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}