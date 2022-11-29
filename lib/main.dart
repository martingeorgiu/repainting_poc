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
  }) : super(key: key);

  final Widget child;

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
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) => SizeTransition(
        sizeFactor: _animation,
        child: widget.child,
      );
}
