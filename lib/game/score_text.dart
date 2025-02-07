import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:game/game/level1.dart';

class ScoreText extends TextComponent with HasGameRef<Level1> {
  ScoreText()
      : super(
          text: "Score: 0",
          position: Vector2(10, 10),
          anchor: Anchor.topLeft,
          textRenderer: TextPaint(
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        );

  @override
  void update(double dt) {
    super.update(dt);
    text = "Score: ${gameRef.score}";
  }
}
