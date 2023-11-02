import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ChildSize2 extends RenderObjectWidget {
  final Widget? child;
  final void Function(Size)? onChildSizeChanged;
  const ChildSize2({
    Key? key,
    this.child,
    this.onChildSizeChanged,
  }) : super(key: key);
  @override
  RenderObjectElement createElement() {
    return ChildSize2Element(this);
  }

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderChildSize2().._widget = this;
  }

  @override
  void updateRenderObject(BuildContext context, RenderChildSize2 renderObject) {
    renderObject.._widget = this;
  }
}

class ChildSize2Element extends RenderObjectElement {
  Element? _child;
  ChildSize2Element(super.widget);

  @override
  ChildSize2 get widget => super.widget as ChildSize2;

  @override
  RenderChildSize2 get renderObject => super.renderObject as RenderChildSize2;

  @override
  void insertRenderObjectChild(RenderBox child, covariant Object? slot) {
    renderObject.insertRenderObjectChild(child, slot);
  }

  @override
  void removeRenderObjectChild(
      covariant RenderBox child, covariant Object? slot) {
    renderObject.removeRenderObjectChild(child, slot);
  }

  @override
  void moveRenderObjectChild(covariant RenderBox child,
      covariant Object? oldSlot, covariant Object? newSlot) {
    renderObject.moveRenderObjectChild(child, oldSlot, newSlot);
  }

  @override
  void mount(Element? parent, Object? newSlot) {
    super.mount(parent, newSlot);
    _child = updateChild(_child, widget.child, null);
  }

  @override
  void update(covariant ChildSize2 newWidget) {
    super.update(newWidget);
    _child = updateChild(_child, widget.child, null);
  }

  @override
  void unmount() {
    super.unmount();
    _child = null;
  }

  @override
  void visitChildren(ElementVisitor visitor) {
    final child = _child;
    if (child != null) {
      visitor(child);
    }
    super.visitChildren(visitor);
  }

  @override
  void forgetChild(Element child) {
    _child = null;
    super.forgetChild(child);
  }
}

class RenderChildSize2 extends RenderBox {
  RenderBox? _child;
  var _lastSize = Size.zero;
  var _widget = ChildSize2();

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    _child?.attach(owner);
  }

  @override
  void detach() {
    super.detach();
    _child?.detach();
  }

  @override
  void visitChildren(RenderObjectVisitor visitor) {
    final child = _child;
    if (child != null) {
      visitor(child);
    }
    super.visitChildren(visitor);
  }

  @override
  void redepthChildren() {
    final child = _child;
    if (child != null) {
      redepthChild(child);
    }
    super.redepthChildren();
  }

  void insertRenderObjectChild(RenderBox child, covariant Object? slot) {
    _child = child;
    adoptChild(child);
  }

  void removeRenderObjectChild(RenderBox child, covariant Object? slot) {
    _child = null;
    dropChild(child);
  }

  void moveRenderObjectChild(
      RenderBox child, covariant Object? oldSlot, covariant Object? newSlot) {
    if (oldSlot != null) {
      _child = null;
    }
    if (newSlot != null) {
      _child = child;
    }
  }

  @override
  void performLayout() {
    final child = _child;
    if (child != null) {
      // parentUsesSize: child 布局信息 通知 父级.
      child.layout(constraints, parentUsesSize: true);
      size = child.size;
    } else {
      size = constraints.smallest;
    }
    if (_lastSize != size) {
      _lastSize = size;
      _widget.onChildSizeChanged?.call(size);
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final child = _child;
    if (child != null) {
      context.paintChild(child, offset);
    }
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    return _child?.hitTest(result, position: position) == true;
  }
}
