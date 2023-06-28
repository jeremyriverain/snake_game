import 'package:flame/components.dart';
import 'package:snake_game/game_config.dart';
import 'package:snake_game/snake_game.dart';
import 'package:snake_game/components/food.dart';

class ScoreDisplay extends PositionComponent with HasGameRef<SnakeGame> {
  @override
  onLoad() {
    final food = Food();
    add(food);

    add(
      TextComponent(anchor: Anchor.centerLeft)
        ..position =
            Vector2(food.x + GameConfig.sizeCell + 5, GameConfig.sizeCell - 14)
        ..text = 'x ${gameRef.gameManager.score.value.toString()}',
    );
  }
}
