import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AppGridView extends StatefulWidget {
  final List data;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final int crossAxisCount;
  final double childAspectRatio;
  final Function renderItem;
  final Function onLoadMore;
  final Function onRefresh;

  const AppGridView({
    Key? key,
    required this.data,
    required this.renderItem,
    this.crossAxisSpacing = 12,
    this.mainAxisSpacing = 16,
    this.crossAxisCount = 2,
    this.childAspectRatio = 1 / 1.5,
    required this.onLoadMore,
    required this.onRefresh,
  }) : super(key: key);
  @override
  _AppGridViewState createState() => _AppGridViewState();
}

class _AppGridViewState extends State<AppGridView> {
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
        child: GridView.builder(
          controller: _scrollController,
          addAutomaticKeepAlives: false,
          addRepaintBoundaries: false,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: widget.crossAxisCount,
              childAspectRatio: widget.childAspectRatio),
          scrollDirection: Axis.vertical,
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
