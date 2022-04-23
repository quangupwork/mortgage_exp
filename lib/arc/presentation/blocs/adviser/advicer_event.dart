import '../../../../src/bloc/base.dart';

class AdvicerEvent extends IBaseEvent {}

class LoadPostEvent extends AdvicerEvent {}

class ChangeFilterEvent extends AdvicerEvent {
  int value;
  ChangeFilterEvent({required this.value});
}
