import 'package:flutter/material.dart';
import 'package:mortgage_exp/arc/presentation/blocs/blocs.dart';
import 'package:mortgage_exp/arc/presentation/screens/find_adviser/widgets/item_post.dart';
import 'package:mortgage_exp/arc/presentation/widgets/commons/common.dart';
import 'package:mortgage_exp/src/config/route_keys.dart';
import 'package:mortgage_exp/src/constants.dart';
import 'package:mortgage_exp/src/extensions/extension.dart';
import 'package:mortgage_exp/src/utilities/utilities.dart';

import '../../../../injector.dart';
import '../../../../src/base_widget_state/base_widget_state.dart';
import '../../../../src/bloc/base.dart';
import '../../../../src/helper/filter_conver.dart';
import '../../../../src/styles/style.dart';
import '../../../../src/utilities/navigator_service.dart';
import '../../../data/models/models.dart';

class FindAdvicerScreen extends StatefulWidget {
  const FindAdvicerScreen({Key? key}) : super(key: key);

  @override
  State<FindAdvicerScreen> createState() => _FindAdvicerScreenState();
}

class _FindAdvicerScreenState extends IStateful<PostBloc, FindAdvicerScreen> {
  final navigator = AppDependencies.injector.get<NavigationService>();
  late List<PostModel>? postModel = [];
  late List<PostModel>? filterPost = [];
  List<String> result = [];
  List<int> listFilter = Constants.categoryIDS;
  int selected = 3883698826;
  String filter = '';
  @override
  void initState() {
    super.initState();
    bloc.add(LoadPostEvent());
    bloc.add(ChangeFilterEvent(value: listFilter[0]));
  }

  @override
  void listener(BuildContext context, IBaseState state) async {
    super.listener(context, state);
    if (state is LoadedPoststate) {
      postModel = state.postModel;
    }
    if (state is ChangeFilterState) {
      selected = state.filter;

      if (selected != listFilter[0]) {
        filterPost?.clear();
        postModel?.forEach((e) {
          if (e.topicIds?.contains(selected) == true) {
            filterPost?.add(e);
          }
        });
      }
    }
  }

  @override
  Widget buildContent(BuildContext context, {IBaseState? state}) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 350 ? true : false;
    return Scaffold(
      backgroundColor: theme.primaryColor,
      appBar: CustomAppBar.withLeading(title: "Find an Adviser"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: Dimens.size10),
          Flexible(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimens.size40),
              child: Row(
                children: [
                  Text('Showing advisers in',
                      style: theme.textTheme
                          .s16w700black()
                          .copyWith(fontWeight: FontWeight.w700)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        final result = await navigator.pushNamed(
                            RouteKey.filterAdvicer,
                            arguments: selected);
                        if (result != null) {
                          bloc.add(ChangeFilterEvent(
                              value: int.parse(result.toString())));
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Dimens.size10, vertical: Dimens.size4),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: const Color(0xffd8d7d5))),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 5,
                              child: Text(
                                  FilterConverter.filterConvert(selected),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: theme.textTheme.s16w700grey()),
                            ),
                            Flexible(
                              child: Image.asset(ImageAssetPath.icFilter,
                                  color: theme.backgroundColor,
                                  height: 30,
                                  width: 30),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: Dimens.size10),
          if (state is LoadingPostState)
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimens.size40, vertical: Dimens.size10),
              child: Text('We fetching the list of brokers, please wait',
                  style: theme.textTheme.bodyMedium),
            ),
          if (selected == listFilter[0])
            Expanded(
              flex: 20,
              child: ListView.separated(
                padding: EdgeInsets.symmetric(
                    horizontal: isSmall ? Dimens.size20 : Dimens.size40,
                    vertical: Dimens.size10),
                itemCount: postModel?.length ?? 0,
                itemBuilder: (context, index) =>
                    ItemPost(postModel: postModel![index]),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
              ),
            ),
          if (selected != listFilter[0])
            Expanded(
              flex: 20,
              child: ListView.separated(
                padding: EdgeInsets.symmetric(
                    horizontal: isSmall ? Dimens.size20 : Dimens.size40,
                    vertical: Dimens.size10),
                itemCount: filterPost?.length ?? 0,
                itemBuilder: (context, index) =>
                    ItemPost(postModel: filterPost![index]),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
              ),
            )
        ],
      ),
    );
  }
}
