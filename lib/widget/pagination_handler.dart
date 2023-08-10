import 'package:flutter/material.dart';
import 'package:travel_go/constant/app_spacing.dart';
import 'package:travel_go/util/ui_helper.dart';

import '../constant/app_color.dart';

class PaginationWidgetHandler extends StatefulWidget {
  final Future<void> Function()? dataLoader;
  final int itemCount;
  final IndexedWidgetBuilder itemWidget;
  final bool hasMoreData;
  final EdgeInsetsGeometry? padding;
  final Widget Function(BuildContext context, int index) separatorBuilder;
  const PaginationWidgetHandler(
      {super.key,
      this.dataLoader,
      required this.hasMoreData,
      required this.separatorBuilder,
      required this.itemCount,
      required this.itemWidget,
      this.padding});

  @override
  State<PaginationWidgetHandler> createState() =>
      _PaginationWidgetHandlerState();
}

class _PaginationWidgetHandlerState extends State<PaginationWidgetHandler> {
  ScrollController? scrollController;
  bool isInit = false;
  int loadingState = 0;
  void scrollListener(ScrollController? controller) {
    if (controller == null) return;
    if (controller.offset >= controller.position.maxScrollExtent * 0.9) {
      loadingState += 1;
      onLoadingMoreData();
    }
  }

  void onLoadingMoreData() async {
    if (loadingState > 1) return;
    if (widget.hasMoreData) {
      await widget.dataLoader?.call();
      if (mounted) {
        loadingState = 0;
      }
    }
  }

  void initController() {
    scrollController = ScrollController();
    scrollController?.addListener(() => scrollListener(scrollController));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initController();
  }

  @override
  void dispose() {
    scrollController?.dispose();
    isInit = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        reverse: true,
        controller: scrollController,
        padding: widget.padding ?? AppGap.mediumGap,
        itemBuilder: (context, index) {
          if (widget.itemCount == 0) {
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: loaderWidget(),
            );
          }
          if (index == widget.itemCount) {
            return loaderWidget();
          } else {
            return widget.itemWidget(context, index);
          }
        },
        separatorBuilder: widget.separatorBuilder,
        itemCount: widget.itemCount + 1);
  }

  Widget loaderWidget() {
    if (widget.hasMoreData) {
      return const Center(
        child: SizedBox(
          height: 12,
          width: 12,
          child: CircularProgressIndicator.adaptive(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
            strokeWidth: 1,
          ),
        ),
      );
    } else {
      return UIHelper.textHelper(text: "No more Item");
    }
  }
}
