import 'dart:ui';

import 'package:flame/game.dart';
import 'package:snake_game/food.dart';

class SnakeGame extends FlameGame {
  @override
  Color backgroundColor() => const Color(0xFF578B33);

  @override
  onLoad() async {
    add(Food());
  }
}
