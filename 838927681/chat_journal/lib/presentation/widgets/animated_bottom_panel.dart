import 'package:flutter/material.dart';

class RotateAnimation extends AnimatedWidget {
  final Widget _child;

  const RotateAnimation({
    required Widget child,
    required AnimationController controller,
  })  : _child = child,
        super(listenable: controller);

  Animation<double> get _progress => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: _progress.value * 6.28,
      child: _child,
    );
  }
}

class AnimatedIcon extends StatefulWidget {
  final Icon icon;

  const AnimatedIcon({Key? key, required this.icon}) : super(key: key);

  @override
  State<AnimatedIcon> createState() => _AnimatedIconState();
}

class _AnimatedIconState extends State<AnimatedIcon>
    with TickerProviderStateMixin {
  late final _controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 1))
        ..repeat();

  @override
  Widget build(BuildContext context) {
    return RotateAnimation(child: widget.icon, controller: _controller);
  }
}
