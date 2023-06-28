import 'dart:ui';

import 'package:flame/game.dart';
import 'package:snake_game/constants.dart';
import 'package:snake_game/food.dart';
import 'package:snake_game/snake/background.dart';
import 'package:snake_game/snake/snake.dart';
import 'package:snake_game/score_banner.dart';

class SnakeGame extends FlameGame {
  @override
  Color backgroundColor() => const Color(0xFF578B33);

  @override
  onLoad() async {
    final maxWidthBackground = size.x - globalPadding * 2;
    final maxHeightBackground = size.y - heightScoreBanner - globalPadding * 2;
    final backgroundParams = (
      rows: maxWidthBackground ~/ sizeCell,
      columns: maxHeightBackground ~/ sizeCell,
    );

    final background = Background(
      numColumns: backgroundParams.columns,
      numRows: backgroundParams.rows,
    )..position = Vector2(
        (size.x - backgroundParams.rows * sizeCell) / 2,
        (heightScoreBanner + size.y - backgroundParams.columns * sizeCell) / 2,
      );

    addAll([
      background,
      Food()..position = background.position + Vector2(sizeCell, sizeCell),
      Snake()
        ..position = background.position + Vector2(sizeCell * 4, sizeCell * 4),
      ScoreBanner(),
    ]);
  }
}
