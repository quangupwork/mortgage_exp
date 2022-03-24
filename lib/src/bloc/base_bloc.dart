import 'package:flutter_bloc/flutter_bloc.dart';
import '../../src/bloc/base.dart';

abstract class IBaseState {}

abstract class IBaseEvent {}

typedef EventAction<TEvent extends IBaseEvent> = Stream<IBaseState> Function(
    TEvent event);

abstract class IBaseBloc extends Bloc<IBaseEvent, IBaseState> {
  BaseLoadedState? get latestLoadedState {
    if (state is BaseLoadedState) {
      return state as BaseLoadedState;
    }
    return null;
  }

  final Map<Type, EventAction> dictEvent = <Type, EventAction>{};

  IBaseBloc.init(IBaseState initState) : super(initState) {
    registerEvents();
  }

  IBaseBloc() : super(BaseInitialState()) {
    registerEvents();
  }

  void registerEvents();

  void registerEvent<TEvent extends IBaseEvent>(EventAction action) {
    dictEvent[TEvent] = action;
  }

  @override
  Stream<IBaseState> mapEventToState(IBaseEvent event) async* {
    if (dictEvent.containsKey(event.runtimeType)) {
      var func = dictEvent[event.runtimeType];
      yield* func!(event);
    }
  }
}

class BaseInitialState extends IBaseState {}

class BaseErrorState extends IBaseState {
  final String? message;
  final Failure? failure;

  BaseErrorState({
    this.message,
    this.failure,
  });
}

class BaseNoDataState extends IBaseState {
  final String message;

  BaseNoDataState(this.message);
}

class BaseLoadedState extends IBaseState {}

class BaseLoadingState extends IBaseState {}
