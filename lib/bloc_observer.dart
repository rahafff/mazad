import 'package:colorful_print/colorful_print.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    if (kDebugMode) {
      printColor('onCreate -- ${bloc.runtimeType}',
          textColor: TextColor.orange);
    }
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);

    if (kDebugMode) {
      print('onEvent -- ${bloc.runtimeType}, $event');
    }
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (kDebugMode) {
      printColor('onChange -- ${bloc.runtimeType}, ${change.toString()}',
          textColor: TextColor.yellow);
    }
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    if (kDebugMode) {
      print('onTransition -- ${bloc.runtimeType}, $transition');
    }
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    if (kDebugMode) {
      printColor('onError -- ${bloc.runtimeType}, $error',
          textColor: TextColor.red);
    }
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    if (kDebugMode) {
      printColor('onClose -- ${bloc.runtimeType}', textColor: TextColor.black);
    }
  }
}
