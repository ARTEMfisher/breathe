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

  static const List<String> emoji = ['😮‍💨', '😤', '😌'];
  static const List<String> commands = ['Inhale', 'Hold breath', 'Exhale'];

  String _emoji = emoji[2];
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
          _emoji = emoji[0];
          _command = commands[0];
        } else if (_controller.value > 0.25 && _controller.value <= 0.5) {
          _emoji = emoji[2];
          _command = commands[1];
        } else if (_controller.value > 0.5 && _controller.value <= 0.75) {
          _emoji = emoji[1];
          _command = commands[2];
        } else {
          _emoji = emoji[2];
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
          _emoji = emoji[2];
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

  @override
  Widget build(BuildContext context) {
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
        Stack(
          alignment: Alignment.center,
          children: [
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return CustomPaint(
                  size: Size(300, 300),
                  painter: ProgressPainter(_animation.value),
                );
              },
            ),
            // Text(
            //   _emoji,
            //   style: TextStyle(
            //     fontSize: 150,
            //     color: Colors.white,
            //   ),
            // ),
          ],
        ),
        SizedBox(height: 80),
      ],
    );
  }
}
