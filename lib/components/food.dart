import 'package:flame/components.dart';
import 'package:snake_game/constants.dart';

class Food extends SpriteComponent {
  @override
  onLoad() async {
    sprite = await Sprite.load('game_sprite.png',
        srcSize: Vector2(sizeItemSprite, sizeItemSprite),
        srcPosition: Vector2(sizeItemSprite * 3, 0));
    size = Vector2.all(sizeCell);
    position = Vector2(10, 500);
  }
}
