import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class IZISmartRefresher extends StatelessWidget {
  const IZISmartRefresher({
    Key? key,
    required this.child,
    required this.onRefresh,
    required this.refreshController,
    required this.enablePullDown,
    required this.onLoading,
    this.primary,
    this.enablePullUp,
  }) : super(key: key);

  final Function() onRefresh;
  final Function() onLoading;
  final bool enablePullDown;
  final Widget child;
  final bool? primary;
  final RefreshController? refreshController;
  final bool? enablePullUp;

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      primary: primary ?? false,
      onRefresh: onRefresh,
      onLoading: onLoading,
      controller: refreshController!,
      enablePullUp: enablePullUp ?? false,
      enablePullDown: enablePullDown,
      header: const ClassicHeader(
        idleText: "Cuộn xuống để làm mới",
        releaseText: "Kéo xuống để làm mới dữ liệu",
        completeText: "Dữ liệu làm mới thành công",
        refreshingText: "Làm mới dữ liệu",
        failedText: "Làm mới dữ liệu bị lỗi",
        canTwoLevelText: "Kéo xuống để làm mới",
      ),
      footer: const ClassicFooter(
        loadingText: "Đang tải...",
        noDataText: "Không có dữ liệu",
        canLoadingText: "Cuộn lên để tải thêm dữ liệu",
        failedText: "Tải thêm lỗi dữ liệu",
        idleText: "Cuộn lên để tải thêm dữ liệu",
      ),
      child: child,
    );
  }
}
