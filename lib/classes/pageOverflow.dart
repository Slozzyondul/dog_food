import 'package:dog_food/classes/renderPageOverflow.dart';
import 'package:flutter/material.dart';

class PageOverflow extends SingleChildRenderObjectWidget {
  const PageOverflow({
    super.key,
    this.width,
    this.height,
    this.alignment = Alignment.topLeft,
    required super.child,
  });

  final double? width;
  final double? height;
  final AlignmentGeometry alignment;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderPageOverflow(
      width: width,
      height: height,
      alignment: alignment,
      textDirection: Directionality.of(context),
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, RenderPageOverflow renderObject) {
    renderObject
      ..width = width
      ..height = height
      ..alignment = alignment
      ..textDirection = Directionality.of(context);
  }
}
