import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:snake_game/game_config.dart';
import 'package:snake_game/snake_game.dart';

class Food extends SpriteComponent with HasGameRef<SnakeGame> {
  Food()
      : super(
            size: Vector2.all(
              GameConfig.sizeCell,
            ),
            anchor: Anchor.center);

  final hitbox = RectangleHitbox(
    collisionType: CollisionType.passive,
  );

  @override
  onLoad() async {
    sprite = await Sprite.load(
      'game_sprite.png',
      srcSize: Vector2(GameConfig.sizeAsset, GameConfig.sizeAsset),
      srcPosition: Vector2(GameConfig.sizeAsset * 3, 0),
    );

    size = Vector2.zero();

    add(hitbox);
  }

  @override
  void onMount() {
    super.onMount();
    add(SizeEffect.to(
        Vector2.all(GameConfig.sizeCell), EffectController(duration: .1)));
  }
}
