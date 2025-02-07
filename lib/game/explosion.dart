import 'package:flame/components.dart';
import 'package:game/game/level1.dart';

class ExplosionEffect extends SpriteComponent with HasGameRef<Level1> {
  ExplosionEffect(Vector2 position)
      : super(
          size: Vector2(50, 50),
          position: position,
        );

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('explosion.png');
    await Future.delayed(Duration(milliseconds: 500));
    removeFromParent();
  }
}