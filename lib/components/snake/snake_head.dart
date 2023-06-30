import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:snake_game/game_config.dart';

class SnakeHead extends SpriteComponent with CollisionCallbacks {
  @override
  onLoad() async {
    sprite = await Sprite.load(
      'game_sprite.png',
      srcSize: Vector2(GameConfig.sizeAsset, GameConfig.sizeAsset),
      srcPosition: Vector2(GameConfig.sizeAsset * 2, 0),
    );
    size = Vector2.all(GameConfig.sizeCell);

    add(RectangleHitbox());
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    print('test');
    super.onCollision(intersectionPoints, other);
  }
}
