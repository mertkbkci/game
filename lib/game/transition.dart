import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

class TransitionText extends TextComponent with HasGameRef {
  final String message;
  final VoidCallback onPressed;

  TransitionText(this.message, {required this.onPressed})
      : super(
          text: message,
          textRenderer: TextPaint(
            style: TextStyle(
              fontSize: 32,
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
          anchor: Anchor.center,
          position: Vector2(200, 300),
        );

  @override
  Future<void> onLoad() async {
    add(
      ButtonComponent(
        button: CircleComponent(radius: 50, paint: Paint()..color = Colors.blue),
        position: Vector2(gameRef.size.x / 2 - 50, gameRef.size.y / 2 + 100),
        onPressed: onPressed,
      ),
    );
  }
}
