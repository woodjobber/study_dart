import 'package:flutter/material.dart';
import 'package:study_dart/child_size/demo_widget.dart';
import 'package:study_dart/child_size/size_offset_wrapper.dart';

class SizeOffsetDemo extends StatefulWidget implements DemoWidget {
  const SizeOffsetDemo({super.key});

  @override
  DemoWidgetState createState() => _SizeOffsetDemoState();

  @override
  // TODO: implement title
  String get title => '';
}

class _SizeOffsetDemoState extends DemoWidgetState {
  double _size = 250;

  @override
  Widget buildContent() {
    print('sizeOffset...');
    return Stack(
      children: [
        Center(
          child: SizeOffsetWrapper(
            onWidgetSizeChange: (size) {
              print('Size: ${size.width}, ${size.height}');
            },
            child: AnimatedContainer(
              duration: const Duration(seconds: 3),
              width: _size,
              height: _size,
              color: Colors.cyan,
            ),
          ),
        ),
        Positioned(
          bottom: 100,
          left: 70,
          right: 70,
          child: InkWell(
            onTap: () {
              setState(() {
                _size = _size == 250 ? 50 : 250;
              });
            },
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25), color: Colors.black),
              child: Text(
                'Change size',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
