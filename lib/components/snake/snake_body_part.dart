import 'package:flame/components.dart';
import 'package:snake_game/game_config.dart';

class SnakeBodyPart extends SpriteComponent {
  SnakeBodyPart()
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
      srcPosition: Vector2(GameConfig.sizeAsset * 1, 0),
    );
  }
}
