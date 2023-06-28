import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:snake_game/components/food.dart';
import 'package:snake_game/components/snake/snake.dart';
import 'package:snake_game/score_banner.dart';

class SnakeGame extends FlameGame {
  @override
  Color backgroundColor() => const Color(0xFF578B33);

  @override
  onLoad() async {
    addAll([Food()..position = Vector2(10, 500), Snake()]);
    add(TextComponent(text: 'Hello, Flame')..y = 0);

    add(ScoreBanner());
  }
}
