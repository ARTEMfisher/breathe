import 'package:flutter/material.dart';
import 'dart:math';
import 'progressPainter.dart';




class ProgressBar extends StatefulWidget {
  final ValueNotifier<bool> isRunningNotifier;

  const ProgressBar({Key? key, required this.isRunningNotifier}) : super(key: key);

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> with SingleTickerProviderStateMixin {
  final Duration duration = Duration(seconds: 20);
  late AnimationController _controller;
  late Animation<double> _animation;

  static const List<String> commands = ['Inhale', 'Hold', 'Exhale'];

  String _command = 'Press on button';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: duration,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.addListener(() {
      setState(() {
        if (_controller.value <= 0.25) {
          _command = commands[0];
        } else if (_controller.value > 0.25 && _controller.value <= 0.5) {
          _command = commands[1];
        } else if (_controller.value > 0.5 && _controller.value <= 0.75) {
          _command = commands[2];
        } else {
          _command = commands[1];
        }
      });
    });

    widget.isRunningNotifier.addListener(() {
      if (!widget.isRunningNotifier.value) {
        _controller
          ..stop()
          ..reset();
        setState(() {
          _command = 'Press on button';
        });
      } else {
        _controller.repeat();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Size getProgressBarSize(double y){
    double height = y/3;
    return Size(height,height);
  }

  @override
  Widget build(BuildContext context) {
    double y = MediaQuery.of(context).size.height;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          _command,
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'YandexSans'
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 40),
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return CustomPaint(
              size: getProgressBarSize(y),
              painter: ProgressPainter(_animation.value),
            );
          },
        ),
        SizedBox(height: 80),
      ],
    );
  }
}
