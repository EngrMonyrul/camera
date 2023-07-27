import 'package:camera/screens/mainScreen/mainScreen.dart';
import 'package:camera/screens/mainScreen/providers/cameraScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CameraScreenProvider()),
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Camera',
            theme: ThemeData(
              fontFamily: 'Times New Roman',
            ),
            home: const CameraScreen(),
          );
        },
      ),
    );
  }
}
