import 'package:flutter/material.dart';

class ScaleAnimatedDialog extends StatefulWidget {
  final Widget child;

  const ScaleAnimatedDialog({Key? key, required this.child}) : super(key: key);

  @override
  _ScaleAnimatedDialogState createState() => _ScaleAnimatedDialogState();
}

class _ScaleAnimatedDialogState extends State<ScaleAnimatedDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _scaleAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: widget.child,
    );
  }
}
