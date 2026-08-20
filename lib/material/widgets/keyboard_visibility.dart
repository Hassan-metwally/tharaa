library keyboard_visibility_pro;

import 'package:flutter/material.dart';

class KeyboardVisibility extends StatefulWidget {
  final Widget child;
  final void Function(bool isVisible)? onChanged;
  final Widget Function(BuildContext context, Widget child, bool isVisible)? builder;
  const KeyboardVisibility({super.key, required this.child, this.onChanged, this.builder});

  @override
  State<KeyboardVisibility> createState() => _KeyboardVisibilityState();
}

class _KeyboardVisibilityState extends State<KeyboardVisibility> with WidgetsBindingObserver {
  bool _isVisible = false;
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    // ignore: deprecated_member_use
    if (WidgetsBinding.instance.window.viewInsets.bottom > 0.0) {
      if (_isVisible != true) {
        _isVisible = true;
        setState(() {});
        build(context);
        if (widget.onChanged != null) {
          widget.onChanged?.call(_isVisible);
        }
      }
    } else {
      if (_isVisible != false) {
        _isVisible = false;
        setState(() {});
        widget.onChanged?.call(_isVisible);
      }
    }
    super.didChangeMetrics();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.builder != null) {
      return AnimatedSwitcher(
        duration: Durations.medium4,
        reverseDuration: Durations.medium4,
        child: SizedBox(key: ValueKey(_isVisible), child: widget.builder!(context, widget.child, _isVisible)),
      );
    }
    return widget.child;
  }
}
