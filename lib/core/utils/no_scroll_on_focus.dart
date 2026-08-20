import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class NoScrollOnFocus extends SingleChildRenderObjectWidget {
  const NoScrollOnFocus({super.key, required Widget child}) : super(child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _NoScrollOnFocusRenderObject();
  }
}

class _NoScrollOnFocusRenderObject extends RenderProxyBox {
  @override
  void showOnScreen({RenderObject? descendant, Rect? rect, Duration duration = Duration.zero, Curve curve = Curves.ease}) {
    // Override default behavior: DO NOTHING
  }
}
