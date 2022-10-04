import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Repainting POC',
      home: SimpleHomePage(),
    );
  }
}

class SimpleHomePage extends StatelessWidget {
  const SimpleHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: DelayedSizeOpacityAnimation(
            toShow: false,
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}

class DelayedSizeOpacityAnimation extends StatefulWidget {
  const DelayedSizeOpacityAnimation({
    Key? key,
    required this.child,
    this.toShow = false,
  }) : super(key: key);

  final Widget child;
  final bool toShow;

  @override
  State<DelayedSizeOpacityAnimation> createState() =>
      _DelayedSizeOpacityAnimationState();
}

class _DelayedSizeOpacityAnimationState
    extends State<DelayedSizeOpacityAnimation> with TickerProviderStateMixin {
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.ease,
  );

  late final AnimationController _controller;

  @override
  void didUpdateWidget(covariant DelayedSizeOpacityAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.toShow != oldWidget.toShow) {
      if (widget.toShow) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
  }

  @override
  Widget build(BuildContext context) => SizeTransition(
        sizeFactor: _animation,
        child: widget.child,
      );
}
