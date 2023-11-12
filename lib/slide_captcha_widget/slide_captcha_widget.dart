import 'package:flutter/material.dart';

class SlideCaptchaWidget extends StatefulWidget {
  final String imageUrl;
  final Function(bool) onCaptchaVerified;

  SlideCaptchaWidget({required this.imageUrl, required this.onCaptchaVerified});

  @override
  _SlideCaptchaWidgetState createState() => _SlideCaptchaWidgetState();
}

class _SlideCaptchaWidgetState extends State<SlideCaptchaWidget> {
  double _sliderPosition = 0.0;
  bool _isCaptchaVerified = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 显示验证码图片
        Image.network(
          widget.imageUrl,
          width: 200,
          height: 100,
        ),
        SizedBox(height: 16),
        // 显示滑块和滑动条
        Stack(
          alignment: Alignment.centerLeft,
          children: [
            Container(
              width: 300,
              height: 50,
              color: Colors.grey[300],
            ),
            Positioned(
              left: _sliderPosition,
              child: GestureDetector(
                onHorizontalDragUpdate: (details) {
                  setState(() {
                    // 更新滑块位置
                    _sliderPosition += details.delta.dx;
                  });
                },
                onHorizontalDragEnd: (details) {
                  if (_sliderPosition >= 250) {
                    // 滑动距离达到阈值，验证通过
                    setState(() {
                      _isCaptchaVerified = true;
                    });
                    widget.onCaptchaVerified(true);
                  } else {
                    // 滑动距离未达到阈值，重置滑块位置
                    setState(() {
                      _sliderPosition = 0.0;
                    });
                  }
                },
                child: Container(
                  width: 50,
                  height: 50,
                  color: Colors.blue,
                  child: Icon(Icons.arrow_forward, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        // 显示验证结果
        Text(
          _isCaptchaVerified ? '验证通过' : '请按住滑块拖动',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: _isCaptchaVerified ? Colors.green : Colors.red,
          ),
        ),
      ],
    );
  }
}
