import 'dart:ui';

import 'package:flame/game.dart';
import 'package:snake_game/food.dart';
import 'package:snake_game/snake/background.dart';
import 'package:snake_game/snake/snake.dart';
import 'package:snake_game/score_banner.dart';

class SnakeGame extends FlameGame {
  @override
  Color backgroundColor() => const Color(0xFF578B33);

  @override
  onLoad() async {
    addAll([
      Background(),
      Food()..position = Vector2(10, 500),
      Snake(),
      ScoreBanner(),
    ]);
  }
}
