import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class InfinityScrollListener extends StatelessWidget {
  const InfinityScrollListener({
    super.key,
    required this.child,
    required this.onListener,
    this.threshold = 20,
  });

  final Widget child;
  final VoidCallback onListener;
  final int threshold;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<UserScrollNotification>(
      onNotification: (notification) {
        final forwardScroll =
            notification.metrics.axisDirection == AxisDirection.down &&
                notification.direction == ScrollDirection.forward;
        if (forwardScroll) {
          return true;
        }
        final isScrollEnd =
            notification.metrics.maxScrollExtent - notification.metrics.pixels <
                threshold;
        if (isScrollEnd) {
          onListener();
        }
        return true;
      },
      child: child,
    );
  }
}
