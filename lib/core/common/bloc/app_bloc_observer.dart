import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  int _counter = 0;

  @override
  void onEvent(Bloc bloc, Object? event) {
    _counter++;
    debugPrint('🔵 EVENT $_counter | ${bloc.runtimeType} → $event');
    super.onEvent(bloc, event);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    _counter++;
    debugPrint(
      '🟢 STATE $_counter | ${bloc.runtimeType}\n'
      '   FROM: ${change.currentState}\n'
      '   TO  : ${change.nextState}',
    );
    super.onChange(bloc, change);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    debugPrint('🔴 ERROR | ${bloc.runtimeType} → $error');
    super.onError(bloc, error, stackTrace);
  }
}
