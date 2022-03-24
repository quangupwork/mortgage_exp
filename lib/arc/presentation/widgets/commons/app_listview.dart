import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:mortgage_exp/src/styles/style.dart';

class AppListView extends StatefulWidget {
  final List data;
  final Function onLoadMore;
  final Function onRefresh;
  final Axis scrollDirection;
  final Function renderItem;

  const AppListView(
      {Key? key,
      required this.data,
      required this.onLoadMore,
      required this.onRefresh,
      this.scrollDirection = Axis.vertical,
      required this.renderItem})
      : super(key: key);
  @override
  _AppListViewState createState() => _AppListViewState();
}

class _AppListViewState extends State<AppListView> {
  final _refreshController = RefreshController();
  final _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scroll) {
        if (scroll is ScrollEndNotification &&
            _scrollController.position.extentAfter == 0) {
          widget.onLoadMore();
        }
        if (scroll.metrics.pixels < scroll.metrics.maxScrollExtent) {}
        return true;
      },
      child: SmartRefresher(
        physics: const BouncingScrollPhysics(),
        controller: _refreshController,
        header: const WaterDropMaterialHeader(),
        onRefresh: () {
          Future.delayed(const Duration(milliseconds: 1000), () {
            _refreshController.refreshCompleted();
            widget.onRefresh();
          });
        },
        child: ListView.separated(
          controller: _scrollController,
          scrollDirection: widget.scrollDirection,
          addAutomaticKeepAlives: false,
          addRepaintBoundaries: false,
          padding: const EdgeInsets.symmetric(vertical: Dimens.size25),
          separatorBuilder: (context, index) {
            return const SizedBox(height: Dimens.size10);
          },
          itemBuilder: (context, index) {
            if (index == widget.data.length) {
              return const CircularProgressIndicator();
            }
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 375),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: widget.renderItem(widget.data[index]),
                ),
              ),
            );
          },
          itemCount: widget.data.length,
        ),
      ),
    );
  }
}
