import 'dart:ui';
import 'package:flame/components.dart';
import 'package:snake_game/components/food.dart';
import 'package:snake_game/constants.dart';

class ScoreBanner extends Component with HasGameRef {
  @override
  onLoad() {
    const double heightBanner = 55;
    const double padding = 15;
    add(RectangleComponent(
      position: Vector2.all(0),
      size: Vector2(gameRef.size.x, heightBanner),
      paint: Paint()..color = const Color(0xFF4A762C),
    ));

    add(
      Food()..position = Vector2(padding, (heightBanner - sizeCell) / 2),
    );

    add(
      TextComponent(anchor: Anchor.centerLeft)
        ..position = Vector2(padding + sizeCell + 5, heightBanner / 2)
        ..text = '0',
    );
  }
}
