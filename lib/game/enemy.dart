// import 'dart:math';

// import 'package:flame/components.dart';
// import 'package:flame/collisions.dart';
// import 'my_game.dart';

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
//     if (!gameRef.isGameOver) position.y += amount;
//     if (position.y > gameRef.size.y) resetPosition();
//   }

//   void resetPosition() {
//     position = Vector2(gameRef.size.x * (0.2 + Random().nextDouble() * 0.6), -50);
//     speed = 100 + Random().nextDouble() * 50;
//   }
// }

// import 'dart:math';
// import 'package:flame/components.dart';
// import 'package:flame/collisions.dart';
// import 'my_game.dart';

// class Enemy extends SpriteComponent with HasGameRef<MyGame>, CollisionCallbacks {
//   double speed = 100;
//   bool counted = false; 

//   Enemy() : super(size: Vector2(50, 50));

//   @override
//   Future<void> onLoad() async {
//     sprite = await gameRef.loadSprite('enemy.png');
//     resetPosition();
   

//        final hitbox = RectangleHitbox.relative(
//       Vector2(0.6, 0.6),
//       parentSize: size,
//     )..collisionType = CollisionType.passive; 
//     add(hitbox);
//   }

//   void moveDown(double amount) {
//     if (!gameRef.isGameOver) {
//       position.y += amount;
//     }

    
//     if (position.y > gameRef.size.y) {
//       if (!counted) {
//         gameRef.increaseScore(1); 
//         counted = true; 
//       }
//       resetPosition();
//     }
//   }

//   void resetPosition() {
//     position = Vector2(gameRef.size.x * (0.2 + Random().nextDouble() * 0.6), -50);
//     speed = 100 + Random().nextDouble() * 50;
//     counted = false; 
//   }
// }

import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:game/game/level1.dart';

class Enemy extends SpriteComponent with HasGameRef<Level1>, CollisionCallbacks {
  double speed = 100;
  bool counted = false; 

  Enemy() : super(size: Vector2(50, 50));

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('enemy.png');
    resetPosition();

 
    final hitbox = RectangleHitbox.relative(
      Vector2(0.6, 0.6), 
      parentSize: size,
    )..collisionType = CollisionType.passive;
    add(hitbox);
  }

  void moveDown(double amount) {
    if (!gameRef.isGameOver) {
      position.y += amount * speed; 
    }

    
    if (position.y > gameRef.size.y) {
      if (!counted) {
        gameRef.increaseScore(1); 
        counted = true;
      }
      resetPosition();
    }
  }

  void resetPosition() {
   
    position = Vector2(
      gameRef.size.x * (0.2 + Random().nextDouble() * 0.6),
      -50,
    );
    speed = 0.5 + Random().nextDouble(); 
    counted = false; 
  }
}


