import 'package:flutter/material.dart';
import 'package:travel_go/constant/app_spacing.dart';
import 'package:travel_go/constant/app_url.dart';
import 'package:travel_go/util/ui_helper.dart';
import 'package:travel_go/widget/loading_helper.dart';

import '../constant/app_color.dart';
import '../constant/app_size.dart';

class PaginationWidgetHandler extends StatefulWidget {
  final Future<void> Function()? dataLoader;
  final int itemCount;
  final IndexedWidgetBuilder itemWidget;
  final bool hasMoreData;
  final EdgeInsetsGeometry? padding;
  final String? receiverImgUrl;
  final String? receiverUsername;
  final bool isReverse;
  final Widget? emptyWidget;
  final Widget Function(BuildContext context, int index) separatorBuilder;
  const PaginationWidgetHandler(
      {super.key,
      this.dataLoader,
      required this.hasMoreData,
      required this.separatorBuilder,
      required this.itemCount,
      required this.itemWidget,
      this.padding,
      this.receiverImgUrl,
      this.receiverUsername,
      required this.isReverse,
      this.emptyWidget});

  @override
  State<PaginationWidgetHandler> createState() =>
      _PaginationWidgetHandlerState();
}

class _PaginationWidgetHandlerState extends State<PaginationWidgetHandler> {
  ScrollController? scrollController;
  int loadingState = 0;
  void scrollListener(ScrollController? controller) {
    if (controller == null) return;
    if (widget.isReverse == true) {
      if (controller.offset >= controller.position.maxScrollExtent * 0.9) {
        loadingState += 1;
        onLoadingMoreData();
      }
    } else {
      if (controller.offset >= controller.position.maxScrollExtent) {
        loadingState += 1;
        onLoadingMoreData();
      }
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        reverse: widget.isReverse,
        controller: scrollController,
        padding: widget.padding ?? AppGap.mediumGap,
        itemBuilder: (context, index) {
          if (widget.itemCount == 0) {
            return const LoadingHelper();
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
      return widget.emptyWidget ??
          SizedBox(
            height: widget.itemCount <= 10
                ? MediaQuery.of(context).size.height * 0.6
                : MediaQuery.of(context).size.height * 0.2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                UIHelper.imageAvatarHelper(
                    "${widget.receiverImgUrl}?token=${AppUrl.senderToken}",
                    size: 80),
                VerticalSpacing.medium,
                UIHelper.textHelper(
                    text: widget.receiverUsername ?? "",
                    fontSize: FontSize.fontSizeBig,
                    fontWeight: FontWeight.bold),
                VerticalSpacing.regular,
                if (widget.itemCount > 0) ...[
                  const SizedBox.shrink()
                ] else ...[
                  Container(
                    padding: AppGap.smallGap,
                    decoration: BoxDecoration(
                        borderRadius: AppRadius.regular,
                        color: AppColors.primary.withOpacity(0.2)),
                    child: UIHelper.textHelper(text: "Visit Profile"),
                  ),
                ]
              ],
            ),
          );
    }
  }
}
