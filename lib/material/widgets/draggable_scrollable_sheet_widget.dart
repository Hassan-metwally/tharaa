import 'package:flutter/material.dart';

class DraggableScrollableSheetWidget extends StatefulWidget {
  const DraggableScrollableSheetWidget({super.key, required this.child, required this.children, required this.childrenHeight});

  final Widget Function(ScrollController scrollController) child;
  final List<Widget> children;
  final double? childrenHeight;

  @override
  State<DraggableScrollableSheetWidget> createState() => _DraggableScrollableSheetWidgetState();
}

class _DraggableScrollableSheetWidgetState extends State<DraggableScrollableSheetWidget> {
  final DraggableScrollableController controller = DraggableScrollableController();
  final _childrenKey = GlobalKey();
  double? _heightRatio;

  void _getChildrenHeight() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox? renderBox = _childrenKey.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox != null) {
        final screenHeight = MediaQuery.of(context).size.height;
        final widgetHeight = renderBox.size.flipped.height;
        final childrenHeightRatio = (widget.childrenHeight ?? widgetHeight) / screenHeight;
        setState(() {
          _heightRatio = (1 - (childrenHeightRatio)).clamp(.25, 1);
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _getChildrenHeight();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(key: _childrenKey, mainAxisSize: MainAxisSize.min, children: widget.children),
        ),
        if (_heightRatio != null)
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1),
            duration: Durations.long1,
            child: SizedBox.expand(
              child: DraggableScrollableSheet(
                snap: true,
                initialChildSize: (_heightRatio ?? .5).clamp(.5, 1),
                minChildSize: (_heightRatio ?? .5).clamp(.5, 1),
                controller: controller,
                builder: (BuildContext context, ScrollController scrollController) {
                  return widget.child(scrollController);
                },
              ),
            ),
            builder: (context, value, child) {
              return Opacity(opacity: value, child: child);
            },
          ),
      ],
    );
  }
}
