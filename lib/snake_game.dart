import 'dart:ui';

import 'package:flame/game.dart';
import 'package:snake_game/components/food.dart';
import 'package:snake_game/components/snake/snake.dart';

class SnakeGame extends FlameGame {
  @override
  Color backgroundColor() => const Color(0xFF578B33);

  @override
  onLoad() async {
    addAll([Food(), Snake()]);
  }
}
