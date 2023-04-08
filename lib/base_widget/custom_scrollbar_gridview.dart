import 'package:flutter/material.dart';
import 'package:fooding_project/helper/izi_dimensions.dart';

class CustomScrollbar extends StatefulWidget {
  const CustomScrollbar({
    Key? key,
    required this.child,
    this.strokeWidth = 6,
    this.strokeHeight = 100,
    this.backgroundColor = Colors.black12,
    this.thumbColor = Colors.white,
    this.alignment = Alignment.topRight,
    this.padding = EdgeInsets.zero,
    this.scrollbarMargin = const EdgeInsets.all(8.0),
    this.itemCount,
  }) : super(key: key);

  final Widget Function(int index) child;
  final double strokeWidth;
  final double strokeHeight;
  final Color thumbColor;
  final Color backgroundColor;
  final AlignmentGeometry alignment;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry scrollbarMargin;
  final int? itemCount;

  @override
  _CustomScrollbarState createState() => _CustomScrollbarState();
}

class _CustomScrollbarState extends State<CustomScrollbar> {
  late ScrollController _controller;
  late double _thumbHeight;
  late double _strokeHeight;

  double _thumbPosition = 0;

  @override
  void initState() {
    super.initState();
    _thumbHeight = IZIDimensions.ONE_UNIT_SIZE * 14;
    _strokeHeight = IZIDimensions.ONE_UNIT_SIZE * 6;
    _controller = ScrollController()..addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_controller.hasClients) {
      final double maxScrollSize = _controller.position.maxScrollExtent;
      final double currentPosition = _controller.position.pixels;
      final scrollPosition = ((widget.strokeWidth - _thumbHeight) /
              (maxScrollSize / currentPosition)) /
          (IZIDimensions.iziSize.width * 0.0086);

      setState(() {
        _thumbPosition =
            scrollPosition.clamp(0, IZIDimensions.iziSize.width / 1.5);
      });
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_scrollListener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
            width: IZIDimensions.iziSize.width,
            height: IZIDimensions.iziSize.height * .305,
            child: _child),
        _scrollbar,
      ],
    );
  }

  Widget get _child {
    return GridView.builder(
        itemCount: widget.itemCount??20,
        padding: widget.padding,
        controller: _controller,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: IZIDimensions.iziSize.width * 0.36,
            childAspectRatio:
                (IZIDimensions.iziSize.width / 2.9).ceilToDouble() /
                    (IZIDimensions.iziSize.width * 0.246).ceilToDouble(),
            crossAxisSpacing:
                (IZIDimensions.iziSize.width * .037).round().toDouble(),
            mainAxisSpacing:
                (IZIDimensions.iziSize.width * .037).round().toDouble()),
        itemBuilder: (cxt, index) => widget.child(index));
  }

  Widget get _scrollbar {
    final width = widget.strokeWidth;

    return Align(
      alignment: widget.alignment,
      child: Container(
        margin: widget.scrollbarMargin,
        child: Stack(
          children: [
            Container(
              width: IZIDimensions.iziSize.width * .15,
              height: 5,
              decoration: BoxDecoration(
                  color: widget.backgroundColor,
                  borderRadius:
                      BorderRadius.circular(IZIDimensions.BORDER_RADIUS_3X)),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 100),
              left: _thumbPosition,
              child: Container(
                width: width / 3,
                height: 5,
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [Color(0xffFF8B38), Color(0xffF3664B)]),
                    borderRadius:
                        BorderRadius.circular(IZIDimensions.BORDER_RADIUS_3X)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
