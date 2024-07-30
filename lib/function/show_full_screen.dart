import 'package:flutter/material.dart';

void showFullscreen({required BuildContext context, required Widget child, double? bgOpacity, bool? dismissible}) async {
  //var screenSize = MediaQuery.of(context).size;
  return await showDialog(
    barrierDismissible: dismissible ?? true,
    barrierColor: Colors.black.withOpacity(bgOpacity ?? 0.6),
    //transitionDuration: Duration(milliseconds: 300),
    context: context,
    builder: (BuildContext context) {
      return GestureDetector(
          onTap: dismissible ?? true ? () {
            Navigator.pop(context);
          } : null,
          child: _FullScreenAnimationChild(child: child));
    },
  );
}

class _FullScreenAnimationChild extends StatefulWidget {
  final Widget child;

  const _FullScreenAnimationChild({Key? key, required this.child})
      : super(key: key);

  @override
  State<_FullScreenAnimationChild> createState() =>
      _FullScreenAnimationChildState();
}

class _FullScreenAnimationChildState extends State<_FullScreenAnimationChild>
    with TickerProviderStateMixin {
  AnimationController? animationController;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 480));
    WidgetsBinding.instance.addPostFrameCallback((_) => _startAnimation());
    super.initState();
  }

  void _startAnimation() {
    animationController!.forward();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return ScaleTransition(
          scale: CurvedAnimation(
            parent: animationController!,
            curve: const Interval(
              0.0,
              1.0,
              curve: Curves.easeOutBack,
            ),
          ),
          child: widget.child,
          // Dialog(
          //   clipBehavior: Clip.none,
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(0),
          //   ),
          //   elevation: 0.0,
          //   backgroundColor: Colors.transparent,
          //   child: widget.child,
          // ),
        );
      },
    );
  }
}
