import 'package:easy_localization/easy_localization.dart';
import 'package:elite_auction/core/resources/strings_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';

import '../resources/color_manager.dart';

class CustomPaginationWidget extends StatefulWidget {
  final VoidCallback? onRefresh;
  final VoidCallback? onLoading;
  final Widget listTobePaginated;
  final String endOfScrollingMessage;
  final bool enablePullDown;
  final bool enablePullUp;
  final int itemCount;
  final RefreshController refreshController;
  final ScrollController scrollController;
  @override
  State<CustomPaginationWidget> createState() => _CustomPaginationWidgetState();

  const CustomPaginationWidget({
    Key? key,
    this.onRefresh,
    this.onLoading,
    required this.listTobePaginated,
    required this.endOfScrollingMessage,
    required this.enablePullDown,
    required this.enablePullUp,
    required this.itemCount,
    required this.refreshController,
    required this.scrollController,
  }) : super(key: key);
}

class _CustomPaginationWidgetState extends State<CustomPaginationWidget> {
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      thickness: 2.w,
      thumbVisibility: true,
      trackVisibility: true,
      interactive: true,
      radius: Radius.circular(2.0.w),
      child: SmartRefresher(
        controller: widget.refreshController,
        enablePullDown: widget.enablePullDown,
        enablePullUp: widget.enablePullUp,
        header: const WaterDropHeader(
          waterDropColor: ColorManager.kGreen,
        ),
        onRefresh: widget.onRefresh,
        onLoading: widget.onLoading,
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus? mode) {
            Widget body;
            if (mode == LoadStatus.idle)
            {
              body = Text(widget.endOfScrollingMessage.tr());
            } else if (mode == LoadStatus.loading)
            {
              body = const CupertinoActivityIndicator();
            } else if (mode == LoadStatus.failed)
            {
              body = Text(AppStrings.loadFailed.tr());
            } else if (mode == LoadStatus.canLoading)
            {
              body = Text(AppStrings.releaseToLoadMore.tr());
            } else if (widget.itemCount < 8)
            {
              //when the item count is less than 8 the endOfScrollingMessageWontAppeared
              body = const Text("");
            } else
            {
              body = Text(widget.endOfScrollingMessage.tr());
            }
            return SizedBox(
              height: 55.0,
              child: Center(child: body),
            );
          },
        ),
        child: widget.listTobePaginated,
      ),
    );
  }
}
