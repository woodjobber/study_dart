import 'package:flutter/material.dart';

class AlwaysScrollableWithKeepPositionScrollPhysics extends ScrollPhysics {
  final double? Function(double)? _onGetScrollPosition;

  const AlwaysScrollableWithKeepPositionScrollPhysics(
      {ScrollPhysics? parent, double? Function(double)? onGetScrollPosition})
      : _onGetScrollPosition = onGetScrollPosition,
        super(parent: parent);

  @override
  AlwaysScrollableWithKeepPositionScrollPhysics applyTo(
      ScrollPhysics? ancestor) {
    return AlwaysScrollableWithKeepPositionScrollPhysics(
        parent: buildParent(ancestor),
        onGetScrollPosition: _onGetScrollPosition);
  }

  @override
  double adjustPositionForNewDimensions({
    required ScrollMetrics oldPosition,
    required ScrollMetrics newPosition,
    required bool isScrolling,
    required double velocity,
  }) {
    final position = _onGetScrollPosition?.call(newPosition.maxScrollExtent);
    if (position != null) {
      return position;
    }

    return super.adjustPositionForNewDimensions(
      oldPosition: oldPosition,
      newPosition: newPosition,
      isScrolling: isScrolling,
      velocity: velocity,
    );
  }

  @override
  bool shouldAcceptUserOffset(ScrollMetrics position) => true;
}
