import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AppStaggeredGridView extends StatefulWidget {
  final List data;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final int crossAxisCount;
  final Function renderItem;
  final Function onLoadMore;
  final Function onRefresh;
  final Axis scrollDirection;

  const AppStaggeredGridView({
    Key? key,
    required this.data,
    required this.renderItem,
    this.crossAxisSpacing = 4.0,
    this.mainAxisSpacing = 4.0,
    this.crossAxisCount = 2,
    this.scrollDirection = Axis.vertical,
    required this.onLoadMore,
    required this.onRefresh,
  }) : super(key: key);
  @override
  _AppStaggeredGridViewState createState() => _AppStaggeredGridViewState();
}

class _AppStaggeredGridViewState extends State<AppStaggeredGridView> {
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
        controller: _refreshController,
        header: const WaterDropMaterialHeader(),
        onRefresh: () {
          Future.delayed(const Duration(milliseconds: 1000), () {
            _refreshController.refreshCompleted();
            widget.onRefresh();
          });
        },
        child: StaggeredGridView.countBuilder(
          controller: _scrollController,
          addAutomaticKeepAlives: false,
          addRepaintBoundaries: false,
          mainAxisSpacing: widget.mainAxisSpacing,
          crossAxisSpacing: widget.crossAxisSpacing,
          crossAxisCount: widget.crossAxisCount,
          staggeredTileBuilder: (int index) => const StaggeredTile.count(1, 1),
          scrollDirection: widget.scrollDirection,
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
