part of core;

class FadeTransitionRoute<T> extends PageRoute<T> {
  FadeTransitionRoute({required this.child, this.duration, super.settings, super.allowSnapshotting = true});

  @override
  Color get barrierColor => Colors.grey;

  @override
  String? get barrierLabel => null;

  final WidgetBuilder child;
  final Duration? duration;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return FadeTransition(opacity: animation, child: child(context));
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => duration ?? const Duration(milliseconds: 250);
}

class SlideTransitionRoute<T> extends PageRoute<T> {
  SlideTransitionRoute(this.child, {this.currentTapOffset});

  final Offset? currentTapOffset;

  @override
  Color get barrierColor => Colors.transparent;

  @override
  String? get barrierLabel => null;

  final Widget child;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    const begin = Offset(.5, 1);
    const end = Offset.zero;
    const curve = Curves.ease;

    final tween = Tween(begin: currentTapOffset ?? begin, end: end).chain(CurveTween(curve: curve));
    return SlideTransition(position: animation.drive(tween), child: child);
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 350);
}
