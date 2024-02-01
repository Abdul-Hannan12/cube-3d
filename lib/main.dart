import 'dart:math' show pi;

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '3D Cube',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _xController;
  late AnimationController _yController;
  late AnimationController _zController;

  late Tween<double> _animation;

  @override
  void initState() {
    super.initState();
    _xController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    );
    _yController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    );
    _zController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 40),
    );
    _animation = Tween<double>(begin: 0, end: pi * 2);
  }

  @override
  void dispose() {
    super.dispose();
    _xController.dispose();
    _yController.dispose();
    _zController.dispose();
  }

  double size = 100;
  @override
  Widget build(BuildContext context) {
    _xController
      ..reset()
      ..repeat();
    _yController
      ..reset()
      ..repeat();
    _zController
      ..reset()
      ..repeat();

    return Scaffold(
      backgroundColor: const Color(0xFF294D4A),
      body: Center(
        child: AnimatedBuilder(
          animation: Listenable.merge(
            [
              _xController,
              _yController,
              _zController,
            ],
          ),
          builder: (context, child) {
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..rotateX(_animation.evaluate(_xController))
                ..rotateY(_animation.evaluate(_yController))
                ..rotateZ(_animation.evaluate(_zController)),
              child: Stack(
                children: [
                  // back
                  Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..translate(
                        Vector3(0, 0, -size),
                      ),
                    child: Container(
                      width: size,
                      height: size,
                      color: Colors.purple,
                    ),
                  ),
                  // left
                  Transform(
                    alignment: Alignment.centerLeft,
                    transform: Matrix4.identity()..rotateY(pi / 2),
                    child: Container(
                      width: size,
                      height: size,
                      color: Colors.red,
                    ),
                  ),
                  // right
                  Transform(
                    alignment: Alignment.centerRight,
                    transform: Matrix4.identity()..rotateY(-pi / 2),
                    child: Container(
                      width: size,
                      height: size,
                      color: Colors.blue,
                    ),
                  ),
                  // front
                  Container(
                    width: size,
                    height: size,
                    color: Colors.green,
                  ),
                  // top
                  Transform(
                    alignment: Alignment.topCenter,
                    transform: Matrix4.identity()..rotateX(-pi / 2),
                    child: Container(
                      width: size,
                      height: size,
                      color: Colors.orange,
                    ),
                  ),
                  // bottom
                  Transform(
                    alignment: Alignment.bottomCenter,
                    transform: Matrix4.identity()..rotateX(pi / 2),
                    child: Container(
                      width: size,
                      height: size,
                      color: Colors.brown,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
