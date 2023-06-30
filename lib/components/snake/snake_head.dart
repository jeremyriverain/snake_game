import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:snake_game/components/food.dart';
import 'package:snake_game/components/grid.dart';
import 'package:snake_game/game_config.dart';
import 'package:snake_game/snake_game.dart';

class SnakeHead extends SpriteComponent
    with HasGameRef<SnakeGame>, CollisionCallbacks {
  SnakeHead()
      : super(
          size: Vector2.all(
            GameConfig.sizeCell,
          ),
        );
  @override
  onLoad() async {
    sprite = await Sprite.load(
      'game_sprite.png',
      srcSize: Vector2(GameConfig.sizeAsset, GameConfig.sizeAsset),
      srcPosition: Vector2(GameConfig.sizeAsset * 2, 0),
    );

    add(RectangleHitbox());
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is Food) {
      game.gameManager.increaseScore();
    } else if (other is Grid) {
      game.gameOver();
    }
  }
}
