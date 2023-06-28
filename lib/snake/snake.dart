import 'dart:async';

import 'package:flame/components.dart';
import 'package:snake_game/snake/snake_body.dart';
import 'package:snake_game/snake/snake_head.dart';
import 'package:snake_game/snake/snake_tail.dart';
import 'package:snake_game/constants.dart';

class Snake extends PositionComponent {
  @override
  FutureOr<void> onLoad() {
    add(
      SnakeHead(),
    );

    add(
      SnakeBody()..position = -Vector2(sizeCell, 0),
    );

    add(
      SnakeTail()..position = -Vector2(sizeCell * 2, 0),
    );
  }
}
