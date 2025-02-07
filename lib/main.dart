


// import 'dart:math';
// import 'package:flame/collisions.dart';
// import 'package:flame/events.dart';
// import 'package:flame/game.dart';
// import 'package:flame/components.dart';
// import 'package:flame/input.dart';
// import 'package:flame_audio/flame_audio.dart';
// import 'package:flutter/material.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: GameWidget(game: MyGame()),
//     );
//   }
// }

// class MyGame extends FlameGame with HasCollisionDetection, TapDetector {
//   late Player player;
//   late JoystickComponent joystick;
//   late ButtonComponent jumpButton;
//   late SpriteComponent background;
//   final List<Enemy> enemies = [];
//   double gameSpeed = 100;
//   int score = 0;
//   bool isGameOver = false;

//   @override
//   Future<void> onLoad() async {
//     // 🌆 **Arka plan ekleyelim**
//     background = SpriteComponent()
//       ..sprite = await loadSprite('background.avif')
//       ..size = size;
//     add(background);

//     // 🎮 **Oyuncuyu ekle**
//     player = Player();
//     add(player);
//     add(ScoreText());

//     // 💀 **Düşmanları ekle**
//     for (int i = 0; i < 3; i++) {
//       final enemy = Enemy();
//       enemies.add(enemy);
//       add(enemy);
//     }

//     // 🎮 **Joystick ekle (Sol alt köşe)**
//     joystick = JoystickComponent(
//       knob: CircleComponent(radius: 25, paint: Paint()..color = Colors.blue),
//       background: CircleComponent(radius: 40, paint: Paint()..color = Colors.black.withOpacity(0.5)),
//       margin: const EdgeInsets.only(left: 20, bottom: 20),
//     );
//     add(joystick);

//     // 🆙 **Zıplama Butonu (Sağ alt köşe)**
//     jumpButton = ButtonComponent(
//       button: CircleComponent(radius: 30, paint: Paint()..color = Colors.red),
//       position: Vector2(size.x - 70, size.y - 70),
//       onPressed: () => player.jump(),
//     );
//     add(jumpButton);

//     // 🔊 **Sesleri yükle ve müziği başlat**
//     await FlameAudio.audioCache.loadAll(['jump.mp3', 'hit.mp3', 'background.mp3']);
//     FlameAudio.bgm.play('background.mp3', volume: 1.0, );
//   }

//   @override
//   void update(double dt) {
//     super.update(dt);
//     if (isGameOver) return;

//     gameSpeed += dt * 5;
//     score += (dt * 10).toInt();

//     for (var enemy in enemies) {
//       enemy.moveDown(dt * gameSpeed);
//     }

//     // 🎮 Joystick hareket kontrolü
//     if (joystick.delta.x != 0) {
//       player.move(joystick.relativeDelta.x * dt * 300);
//     }
//   }

//   // ✅ **Oyunu yeniden başlatma**
//   @override
//   void onTapDown(TapDownInfo info) {
//     if (isGameOver) {
//       restartGame();
//     }
//   }

//   void gameOver() {
//     if (isGameOver) return;
//     isGameOver = true;
//     add(GameOverText());
//     FlameAudio.play('hit.mp3');
//     FlameAudio.bgm.stop();
//   }

//   void restartGame() {
//     isGameOver = false;
//     score = 0;
//     gameSpeed = 100;
//     removeWhere((component) => component is GameOverText);
//     player.position = Vector2(size.x / 2, size.y - 80);

//     for (var enemy in enemies) {
//       enemy.resetPosition();
//     }

//     // 🎵 **Müziği tekrar başlat**
//     FlameAudio.bgm.play('background.mp3', volume: 1.0, );
//   }
// }

// class Player extends SpriteComponent with HasGameRef<MyGame>, CollisionCallbacks {
//   double gravity = 300;
//   double jumpPower = -250;
//   double velocityY = 0;
//   bool isOnGround = true;

//   Player() : super(size: Vector2(50, 50));

//   @override
//   Future<void> onLoad() async {
//     sprite = await gameRef.loadSprite('player.png');
//     position = Vector2(gameRef.size.x / 2, gameRef.size.y - 80);
//     add(RectangleHitbox());
//   }

//   void move(double delta) {
//     position.x += delta;
    
//     // ✅ **Ekran dışına çıkmayı engelle**
//     if (position.x < 0) position.x = 0;
//     if (position.x > gameRef.size.x - size.x) position.x = gameRef.size.x - size.x;
//   }

//   void jump() {
//     if (isOnGround) {
//       velocityY = jumpPower;
//       isOnGround = false;
//       FlameAudio.play('jump.mp3');
//     }
//   }

//   @override
//   void update(double dt) {
//     super.update(dt);
//     velocityY += gravity * dt;
//     position.y += velocityY * dt;

//     if (position.y > gameRef.size.y - 80) {
//       position.y = gameRef.size.y - 80;
//       velocityY = 0;
//       isOnGround = true;
//     }
//   }

//   @mustCallSuper
//   void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
//     if (other is Enemy) {
//       gameRef.gameOver();
//       gameRef.add(ExplosionEffect(position + Vector2(10, 10))); // 💥 **Patlama efekti**
//     }
//   }
// }

// class Enemy extends SpriteComponent with HasGameRef<MyGame>, CollisionCallbacks {
//   double speed = 100;

//   Enemy() : super(size: Vector2(50, 50));

//   @override
//   Future<void> onLoad() async {
//     sprite = await gameRef.loadSprite('enemy.png');
//     resetPosition();
//     add(RectangleHitbox());
//   }

//   void moveDown(double amount) {
//     if (!gameRef.isGameOver) {
//       position.y += amount;
//     }

//     if (position.y > gameRef.size.y) {
//       resetPosition();
//     }
//   }

//   void resetPosition() {
//     position = Vector2(Random().nextDouble() * gameRef.size.x, -50);
//     speed = 100 + Random().nextDouble() * 50;
//   }
// }

// class ScoreText extends TextComponent with HasGameRef<MyGame> {
//   ScoreText()
//       : super(
//           text: "Score: 0",
//           position: Vector2(10, 10),
//           anchor: Anchor.topLeft,
//           textRenderer: TextPaint(style: TextStyle(color: Colors.white, fontSize: 24)),
//         );

//   @override
//   void update(double dt) {
//     super.update(dt);
//     text = "Score: ${gameRef.score}";
//   }
// }

// class GameOverText extends TextComponent with HasGameRef<MyGame> {
//   GameOverText()
//       : super(
//           text: "GAME OVER\nTap to Restart",
//           position: Vector2(200, 300),
//           anchor: Anchor.center,
//           textRenderer: TextPaint(style: TextStyle(color: Colors.red, fontSize: 32)),
//         );
// }

// // 💥 **Patlama Efekti**
// class ExplosionEffect extends SpriteComponent with HasGameRef<MyGame> {
//   ExplosionEffect(Vector2 position)
//       : super(
//           size: Vector2(50, 50),
//           position: position,
//         );

//   @override
//   Future<void> onLoad() async {
//     sprite = await gameRef.loadSprite('explosion.png');
//     await Future.delayed(Duration(milliseconds: 500));
//     removeFromParent();
//   }
// }



import 'package:flame/game.dart';

import 'package:flutter/material.dart';
import 'package:game/game/level1.dart';
import 'package:game/game/level2.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
  final game = Level1();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  GameWidget(
      game: game,
      overlayBuilderMap: {
        'Level1': (context, game) => const SizedBox.shrink(), // Level1 açık
        'Level2': (context, game) => GameWidget(game: Level2()), // Level2 geçiş
      },
    ),
    );
  }
}




