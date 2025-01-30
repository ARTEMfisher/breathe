import 'package:flutter/material.dart';
import 'progressBar.dart';
import 'bottomSheetContent.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ValueNotifier<bool> isRunningNotifier = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        textTheme: ThemeData.dark().textTheme.apply(
          fontFamily: 'YandexSans',
        ),
      ),

      home: Scaffold(
        body: Stack(
          children: [Center(
            child: ProgressBar(isRunningNotifier: isRunningNotifier),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.2,
              minChildSize: 0.15,
              maxChildSize: 0.25,
              builder: (BuildContext context, ScrollController controller) => BottomSheetContent(isRunningNotifier: isRunningNotifier,controller: controller,)
          )
          ]
        ),
      ),
    );
  }
}
