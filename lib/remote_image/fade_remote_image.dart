import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'remote_image.dart';

class FadeRemoteImage extends StatefulWidget {
  FadeRemoteImage({
    super.key,
    required this.placeholder,
    required this.image,
    this.fadeInDuration = const Duration(milliseconds: 700),
    this.errorBuilder,
  });

  final ImageProvider placeholder;

  final ImageProvider image;

  final Duration fadeInDuration;

  final ImageErrorWidgetBuilder? errorBuilder;

  FadeRemoteImage.remote({
    super.key,
    required Uint8List placeholder,
    required String image,
    this.fadeInDuration = const Duration(milliseconds: 700),
    this.errorBuilder,
    int? placeholderCacheWidth,
    int? placeholderCacheHeight,
    int? imageCacheWidth,
    int? imageCacheHeight,
    double placeholderScale = 1.0,
    double imageScale = 1.0,
  })  : placeholder = ResizeImage.resizeIfNeeded(
            placeholderCacheWidth,
            placeholderCacheHeight,
            MemoryImage(placeholder, scale: placeholderScale)),
        image = ResizeImage.resizeIfNeeded(imageCacheWidth, imageCacheHeight,
            RemoteImage(image, scale: imageScale));
  @override
  State<FadeRemoteImage> createState() => _FadeRemoteImageState();
}

class _FadeRemoteImageState extends State<FadeRemoteImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool hasImageCache = false;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: widget.fadeInDuration, value: 0.0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    hasImageCache =
        PaintingBinding.instance.imageCache.containsKey(widget.image);
    Widget placeholder = _PlaceholderWidget(placeholder: widget.placeholder);
    return RImage(
      opacity: _controller,
      image: widget.image,
      frameBuilder: (ctx, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) {
          return child;
        }
        return frame == null ? placeholder : child;
      },
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) {
          if (hasImageCache) {
            _controller.animateTo(1.0, duration: Duration.zero);
            return child;
          }
          _controller.forward(from: 0.0);
          return FadeTransition(opacity: _controller, child: child);
        }
        return child;
      },
      errorBuilder: (ctx, o, s) {
        return widget.errorBuilder != null
            ? widget.errorBuilder!(ctx, o, s)
            : Placeholder();
      },
    );
  }
}

class _PlaceholderWidget extends StatelessWidget {
  const _PlaceholderWidget({
    required this.placeholder,
  });
  final ImageProvider placeholder;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        RImage(image: placeholder),
        CircularProgressIndicator(),
      ],
    );
  }
}
