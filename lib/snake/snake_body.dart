import 'package:flame/components.dart';
import 'package:snake_game/constants.dart';

class SnakeBody extends SpriteComponent {
  @override
  onLoad() async {
    sprite = await Sprite.load(
      'game_sprite.png',
      srcSize: Vector2(sizeItemSprite, sizeItemSprite),
      srcPosition: Vector2(sizeItemSprite * 1, 0),
    );
    size = Vector2.all(sizeCell);
  }
}
