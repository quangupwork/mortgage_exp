import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../src/utilities/logger.dart';
import '../../injector.dart';
import '../../src/bloc/base.dart';

abstract class IStateful<TBloc extends IBaseBloc, TPage extends StatefulWidget>
    extends State<TPage> with AutomaticKeepAliveClientMixin {
  late TBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = AppDependencies.injector.get<TBloc>();
    LoggerUtils.d(bloc.runtimeType);
  }

  @mustCallSuper
  @override
  void dispose() {
    bloc.close();

    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider<TBloc>(
      create: (_) => bloc,
      child: BlocConsumer<TBloc, IBaseState>(
        listenWhen: listenerWhen,
        listener: listener,
        buildWhen: buildWhen,
        builder: (context, state) => buildContent(context, state: state),
      ),
    );
  }

  Widget buildContent(BuildContext context, {IBaseState? state}) =>
      const SizedBox();

  bool buildWhen(IBaseState oldState, IBaseState newState) =>
      oldState != newState;

  @mustCallSuper
  void listener(BuildContext context, IBaseState state) {
    if (state is BaseLoadingState) {
      EasyLoading.show();
    } else {
      EasyLoading.dismiss();
    }
  }

  bool listenerWhen(IBaseState oldState, IBaseState newState) => true;
}
