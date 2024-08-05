import 'package:flutter/material.dart';
import 'package:vaktijaba_fl/data/constants.dart';

class GlowWidget extends StatefulWidget {
  final double? size;
  final Color? color;

  const GlowWidget({
    super.key,
    this.size,
    this.color,
  });

  @override
  State<GlowWidget> createState() => _GlowWidgetState();
}

class _GlowWidgetState extends State<GlowWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double size = widget.size ?? defPadding * 2;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _controller.value,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: widget.color ?? Theme.of(context).iconTheme.color,
              borderRadius: BorderRadius.circular(size),
            ),
          ),
        );
      },
    );
  }
}