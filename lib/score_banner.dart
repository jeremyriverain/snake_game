import 'dart:ui';
import 'package:flame/components.dart';
import 'package:snake_game/food.dart';
import 'package:snake_game/constants.dart';

class ScoreBanner extends Component with HasGameRef {
  @override
  onLoad() {
    add(RectangleComponent(
      position: Vector2.all(0),
      size: Vector2(gameRef.size.x, heightScoreBanner),
      paint: Paint()..color = const Color(0xFF4A762C),
    ));

    final food = Food()
      ..position = Vector2(globalPadding, (heightScoreBanner - sizeCell) / 2);
    add(food);

    add(
      TextComponent(anchor: Anchor.centerLeft)
        ..position = Vector2(food.x + sizeCell + 5, heightScoreBanner / 2)
        ..text = '0',
    );
  }
}
