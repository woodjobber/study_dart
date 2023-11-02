import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:study_dart/child_size/demo_widget.dart';

import 'child_size.dart';

class ChildSizeDemoA extends StatefulWidget implements DemoWidget {
  @override
  DemoWidgetState createState() {
    return _ChildSizeDemoAState();
  }

  @override
  String get title => 'ChildSize';
}

class _ChildSizeDemoAState extends DemoWidgetState {
  var _fraction = 1.0;
  var _size = Size.zero;

  @override
  Widget buildContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 100),
        Slider(
            value: _fraction,
            onChanged: (value) => setState(() => _fraction = value)),
        Text(_size.toString()),
        Center(child: _buildContent()),
      ],
    );
  }

  Widget _buildContent() {
    return ChildSize(
      child: _buildImage(),
      onChildSizeChanged: (size) => scheduleMicrotask(() {
        setState(() => _size = size);
      }),
    );
  }

  Widget _buildImage() {
    return LayoutBuilder(builder: (_, constraints) {
      return ColoredBox(
        color: Colors.red,
        child: Icon(
          Icons.imagesearch_roller_rounded,
          color: Colors.yellow,
          size: min(constraints.maxWidth, constraints.maxHeight) * _fraction,
        ),
      );
    });
  }
}
