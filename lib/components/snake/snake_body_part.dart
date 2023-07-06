import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:snake_game/game_config.dart';

class SnakeBodyPart extends SpriteComponent {
  final bool hasHitbox;
  SnakeBodyPart({this.hasHitbox = true})
      : super(
          size: Vector2.all(
            GameConfig.sizeCell,
          ),
          anchor: Anchor.center,
        );

  @override
  onLoad() async {
    sprite = await Sprite.load(
      'game_sprite.png',
      srcSize: Vector2(GameConfig.sizeCellAsset, GameConfig.sizeCellAsset),
      srcPosition: Vector2(GameConfig.sizeCellAsset * 1, 0),
    );

    if (hasHitbox) {
      add(RectangleHitbox(
          collisionType: CollisionType.passive,
          size: Vector2.all(GameConfig.sizeCell - 5),
          position: size / 2,
          anchor: Anchor.center)
        ..renderShape = true);
    }
  }
}
