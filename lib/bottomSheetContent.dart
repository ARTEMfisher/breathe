import 'package:flutter/material.dart';

class BottomSheetContent extends StatefulWidget {
  final ValueNotifier<bool> isRunningNotifier;
  final ScrollController controller;

  const BottomSheetContent({Key? key, required this.isRunningNotifier, required this.controller}) : super(key: key);

  @override
  _BottomSheetContentState createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<BottomSheetContent> {
  void toggleRunning() {
    widget.isRunningNotifier.value = !widget.isRunningNotifier.value;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleRunning,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.limeAccent,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: ListView(
          controller: widget.controller,
          children: [
            Center(
              child: ValueListenableBuilder<bool>(
                valueListenable: widget.isRunningNotifier,
                builder: (context, isRunning, child) {
                  return Text(
                    isRunning ? 'Stop' : 'Start',
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'YandexSans',
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
