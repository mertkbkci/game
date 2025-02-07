
// import 'package:flame/game.dart';
// import 'package:flame/events.dart';
// import 'package:flame/input.dart';
// import 'package:flame_audio/flame_audio.dart';

// import 'package:flame/components.dart';
// import 'package:flutter/material.dart';
// import 'player.dart';
// import 'enemy.dart';
// import 'score_text.dart';

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
//     // 🌆 Arka plan
//     background = SpriteComponent()
//       ..sprite = await loadSprite('background.avif')
//       ..size = size;
//     add(background);

//     // 🎮 Oyuncu ekle
//     player = Player();
//     add(player);
//     add(ScoreText());

//     // 💀 Düşmanları ekle
//     for (int i = 0; i < 3; i++) {
//       final enemy = Enemy();
//       enemies.add(enemy);
//       add(enemy);
//     }

//     // 🎮 Joystick (Sol alt köşe)
//     joystick = JoystickComponent(
//       knob: CircleComponent(radius: 25, paint: Paint()..color = Colors.blue),
//       background: CircleComponent(radius: 40, paint: Paint()..color = Colors.black.withOpacity(0.5)),
//       margin: const EdgeInsets.only(left: 20, bottom: 20),
//     );
//     add(joystick);

//     // 🆙 Zıplama Butonu (Sağ alt köşe)
//     jumpButton = ButtonComponent(
//       button: CircleComponent(radius: 30, paint: Paint()..color = Colors.red),
//       position: Vector2(size.x - 70, size.y - 70),
//       onPressed: () => player.jump(),
//     );
//     add(jumpButton);

//     // 🔊 Sesleri yükle ve müziği başlat
//     await FlameAudio.audioCache.loadAll(['jump.mp3', 'hit.mp3', 'background.mp3']);
//     FlameAudio.bgm.play('background.mp3', volume: 1.0, );
//   }

//   @override
//   void update(double dt) {
//     super.update(dt);
//     if (isGameOver) return;

//     gameSpeed += dt * 5;
//     score += (dt * 10).toInt(); // ✅ Skor artıyor!

//     for (var enemy in enemies) {
//       enemy.moveDown(dt * gameSpeed);
//     }

//     if (joystick.delta.x != 0) {
//       player.move(joystick.relativeDelta.x * dt * 300);
//     }
//   }

//   // ✅ **Skor artırma fonksiyonu**
//   void increaseScore(int points) {
//     score += points;
//   }

//   @override
//   void onTapDown(TapDownInfo info) {
//     if (isGameOver) restartGame();
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

//     FlameAudio.bgm.play('background.mp3', volume: 1.0, );
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


