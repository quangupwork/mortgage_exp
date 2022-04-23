import '../../../../src/bloc/base.dart';
import '../../../data/models/models.dart';

class AdvicerState extends IBaseState {}

class LoadedPoststate extends AdvicerState {
  List<PostModel>? postModel;
  LoadedPoststate({this.postModel});
}

class ChangeFilterState extends AdvicerState {
  int filter;
  ChangeFilterState({required this.filter});
}

class LoadingPostState extends AdvicerState {}

class ErrorPoststate extends AdvicerState {}
