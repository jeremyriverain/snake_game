import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:snake_game/game_config.dart';
import 'package:snake_game/snake_game.dart';

class Food extends SpriteComponent
    with HasGameRef<SnakeGame>, CollisionCallbacks {
  Food()
      : super(
          anchor: Anchor.center,
          size: Vector2.all(
            GameConfig.sizeCell,
          ),
        );

  final hitbox = RectangleHitbox(
    collisionType: CollisionType.passive,
  );

  final scaleEffect = ScaleEffect.to(
    Vector2.all(0.9),
    InfiniteEffectController(
      EffectController(
        duration: 0.5,
        alternate: true,
      ),
    ),
  );

  @override
  onLoad() async {
    sprite = await Sprite.load(
      'game_sprite.png',
      srcSize: Vector2(GameConfig.sizeAsset, GameConfig.sizeAsset),
      srcPosition: Vector2(GameConfig.sizeAsset * 3, 0),
    );

    add(scaleEffect);

    add(hitbox);
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    remove(hitbox);
  }
}
