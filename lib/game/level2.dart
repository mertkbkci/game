

import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flame/events.dart';

class Level2 extends FlameGame with HasCollisionDetection, TapDetector {
  late SpriteComponent background;
  late Player2 player;
  final List<Obstacle> obstacles = [];
  bool isGameOver = false;
  int score = 0;

  late double groundHeight; 
  double obstacleSpeed = 300;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

   
    background = SpriteComponent()
      ..sprite = await loadSprite('background2.jpg')
      ..size = size
      ..position = Vector2.zero();
    add(background);

   
    groundHeight = size.y - 100;

 
    player = Player2(groundHeight: groundHeight);
    add(player);


    add(ScoreText2());

 
    add(ScreenHitbox());

   
    await SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);

    Future.delayed(const Duration(seconds: 1), () {
      spawnObstacle();
      Future.doWhile(() async {
        if (!isGameOver) {
          await Future.delayed(const Duration(seconds: 2));
          spawnObstacle();
        }
        return !isGameOver;
      });
    });
  }

  @override
  void onMount() {
    super.onMount();
    

    player.setPositionToGround(groundHeight);
  }

  @override
  void onGameResize(Vector2 canvasSize) {
    super.onGameResize(canvasSize);

    if (isLoaded) {
      background.size = canvasSize;
      background.position = Vector2.zero();
      groundHeight = canvasSize.y - 100;

     
      player.setPositionToGround(groundHeight);
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (isGameOver) return;

   
    for (var obstacle in obstacles) {
      obstacle.moveLeft(dt * obstacleSpeed);
    }


    obstacles.removeWhere((obstacle) {
      if (obstacle.position.x < -obstacle.size.x && !obstacle.counted) {
        score++;
        obstacle.counted = true;
        return true;
      }
      return false;
    });


    obstacleSpeed += dt * 5;
  }

  void spawnObstacle() {
    final obstacle = Obstacle(groundHeight: groundHeight)
      ..position = Vector2(size.x, groundHeight - 50);
    add(obstacle);
    obstacles.add(obstacle);
  }

  @override
  void onTapDown(TapDownInfo info) {
    if (!isGameOver) {
      player.jump();
    }
  }

  void gameOver() {
    if (isGameOver) return;
    isGameOver = true;
    player.isActive = false;
    add(GameOverText2());
  }
}

// 🎮 Oyuncu
class Player2 extends SpriteComponent with HasGameRef<Level2>, CollisionCallbacks {
  final double gravity = 500;
  final double jumpPower = -300;
  double velocityY = 0;
  bool isOnGround = true;
  bool isActive = true;
  double groundHeight;

  Player2({required this.groundHeight}) : super(size: Vector2(50, 75));

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('player.png');
    add(RectangleHitbox());
  }

  void setPositionToGround(double newGroundHeight) {
    groundHeight = newGroundHeight;
    position = Vector2(50, groundHeight - size.y);
    velocityY = 0;
    isOnGround = true;
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (!isActive) return;

    velocityY += gravity * dt;
    position.y += velocityY * dt;

    // Oyuncuyu zeminde tut
    if (position.y > groundHeight - size.y) {
      position.y = groundHeight - size.y;
      velocityY = 0;
      isOnGround = true;
    }
  }

  void jump() {
    if (isOnGround) {
      velocityY = jumpPower;
      isOnGround = false;
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Obstacle) {
      gameRef.gameOver();
    }
  }
}

// 🧱 Engeller
class Obstacle extends SpriteComponent with HasGameRef<Level2>, CollisionCallbacks {
  final double groundHeight;
  bool counted = false;

  Obstacle({required this.groundHeight}) : super(size: Vector2(50, 50));

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('obstacle.png');
    position = Vector2(position.x, groundHeight - size.y);
    add(RectangleHitbox());
  }

  void moveLeft(double amount) {
    position.x -= amount;
  }
}

// 📝 Skor Metni
class ScoreText2 extends TextComponent with HasGameRef<Level2> {
  ScoreText2()
      : super(
          text: "Score: 0",
          position: Vector2(10, 10),
          anchor: Anchor.topLeft,
          textRenderer: TextPaint(
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        );

  @override
  void update(double dt) {
    super.update(dt);
    text = "Score: ${gameRef.score}";
  }
}

// 🔴 Game Over Metni
class GameOverText2 extends TextComponent with HasGameRef<Level2> {
  GameOverText2()
      : super(
          text: "GAME OVER\nTap to Restart",
          position: Vector2(200, 300),
          anchor: Anchor.center,
          textRenderer: TextPaint(style: TextStyle(color: Colors.red, fontSize: 32)),
        );
}
