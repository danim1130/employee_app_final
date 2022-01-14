import 'package:employee_app/data/user/user_data_source.dart';
import 'package:employee_app/di/inject.dart';
import 'package:employee_app/ui/user_details/user_details_bloc.dart';
import 'package:employee_app/ui/user_details/widgets/user_info_row.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:employee_app/domain/model/user_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class UserDetailsArguments {
  final int userId;
  final String? heroImageUrl;

  const UserDetailsArguments(this.userId, [this.heroImageUrl]);
}

class UserDetailsPage extends StatelessWidget {
  const UserDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var routeSettings = ModalRoute.of(context)!.settings;
    var args = routeSettings.arguments as UserDetailsArguments;
    return BlocProvider(
      create: (context) =>
          getIt<UserDetailsBloc>()..add(UserDetailsLoadEvent(args.userId)),
      child: UserDetailsContent(
        onUserDeleted: () => Navigator.pop(context),
        heroImageUrl: args.heroImageUrl,
        heroUserId: args.userId,
      ),
    );
  }
}

class UserDetailsContent extends StatefulWidget {
  final String? heroImageUrl;
  final int? heroUserId;
  final VoidCallback onUserDeleted;

  const UserDetailsContent(
      {Key? key,
      required this.onUserDeleted,
      this.heroImageUrl,
      this.heroUserId})
      : super(key: key);

  @override
  State<UserDetailsContent> createState() => _UserDetailsContentState();
}

class _UserDetailsContentState extends State<UserDetailsContent>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500),
        reverseDuration: const Duration(milliseconds: 1000));
    var curvedAnimation = CurvedAnimation(
        parent: _animationController, curve: Curves.bounceInOut);
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(-0.5, 0),
      end: const Offset(0.5, 0),
    ).animate(curvedAnimation);
    _animationController.value = 0.5;

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var localizations = AppLocalizations.of(context)!;
    return BlocBuilder<UserDetailsBloc, UserDetailsState>(
      builder: (context, state) {
        UserData? user;
        if (state is UserDetailsLoaded) {
          user = state.userData;
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(user?.name ?? ''),
            actions: [
              if (user != null)
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    var result = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(localizations.alertDialogTitle),
                        actions: [
                          TextButton(
                            child: Text(localizations.cancel),
                            onPressed: () {
                              Navigator.pop(context, false);
                            },
                          ),
                          TextButton(
                            child: Text(localizations.delete),
                            onPressed: () async {
                              Navigator.pop(context, true);
                            },
                          ),
                        ],
                      ),
                    );
                    if (result == true) {
                      if (user != null) {
                        BlocProvider.of<UserDetailsBloc>(context).add(
                          UserDetailsDeleteUser(user),
                        );
                        await Future.delayed(const Duration(milliseconds: 20));
                      }
                      widget.onUserDeleted();
                    }
                  },
                ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 24,
              horizontal: 22,
            ),
            child: Column(
              children: [
                if (user?.avatarUrl != null || widget.heroImageUrl != null)
                  SlideTransition(
                    position: _offsetAnimation,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(32),
                      child: Hero(
                        tag: 'avatar_${user?.id ?? widget.heroUserId}',
                        child: GestureDetector(
                          onTap: () {
                            if (_animationController.isAnimating) {
                              _animationController.stop();
                            } else {
                              _animationController.repeat(reverse: true);
                            }
                          },
                          child: Image(
                            image: NetworkImage(
                                user?.avatarUrl ?? widget.heroImageUrl!),
                          ),
                        ),
                        createRectTween: (begin, end) =>
                            RectTween(begin: begin, end: end),
                      ),
                    ),
                  ),
                const SizedBox(height: 44),
                if (user != null) ...[
                  UserInfoRow(icon: Icons.mail_outline, value: user.email),
                  UserInfoRow(icon: Icons.phone, value: user.phone),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
