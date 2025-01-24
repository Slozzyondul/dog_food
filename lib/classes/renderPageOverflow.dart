import 'package:flutter/rendering.dart';
import 'dart:math' as math;

class RenderPageOverflow extends RenderAligningShiftedBox {
  RenderPageOverflow({
    double? width,
    double? height,
    required super.alignment,
    required TextDirection super.textDirection,
    super.child,
  })  : _width = width,
        _height = height;

  double? _width;

  double? get width => _width;

  set width(double? value) {
    if (value != _width) {
      _width = value;
      markNeedsLayout();
    }
  }

  double? _height;

  double? get height => _height;

  set height(double? value) {
    if (value != _height) {
      _height = value;
      markNeedsLayout();
    }
  }

  @override
  void performLayout() {
    final width = _width ?? constraints.maxWidth;
    final height = _height ?? constraints.maxHeight;
    final childConstraints = constraints //
        .copyWith(minWidth: width, minHeight: height)
        .normalize();
    child!.layout(childConstraints, parentUsesSize: true);
    size = Size(
      constraints.maxWidth,
      math.max(height, child!.size.height),
    );
    alignChild();
  }
}