import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: BlocObserver)
class MyBlocObserver extends BlocObserver{
  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('Bloc: ${bloc.runtimeType}, error: $error');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print('Bloc: ${bloc.runtimeType}, transition: ${transition}');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    print('Bloc: ${bloc.runtimeType}, event: ${event.runtimeType}');
  }
}