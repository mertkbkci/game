import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:game/game/level1.dart';
import 'enemy.dart';
import 'explosion.dart';

class Player extends SpriteComponent with HasGameRef<Level1>, CollisionCallbacks {
  double gravity = 300;
  double jumpPower = -250;
  double velocityY = 0;
  bool isOnGround = true;

  Player() : super(size: Vector2(50, 50));

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('player.png');
    position = Vector2(gameRef.size.x / 2, gameRef.size.y - 80);
  
     final hitbox = RectangleHitbox.relative(
      Vector2(0.7, 0.7), 
      parentSize: size,
    )..collisionType = CollisionType.active; 
    add(hitbox);
  }

  void move(double delta) {
    position.x += delta;
    if (position.x < 0) position.x = 0;
    if (position.x > gameRef.size.x - size.x) position.x = gameRef.size.x - size.x;
  }

  void jump() {
    if (isOnGround) {
      velocityY = jumpPower;
      isOnGround = false;
      FlameAudio.play('jump.mp3');
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    velocityY += gravity * dt;
    position.y += velocityY * dt;

    if (position.y > gameRef.size.y - 80) {
      position.y = gameRef.size.y - 80;
      velocityY = 0;
      isOnGround = true;
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Enemy) {
      gameRef.gameOver();
      gameRef.add(ExplosionEffect(position));
    }
  }
}


