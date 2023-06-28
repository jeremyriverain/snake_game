import 'dart:async';

import 'package:flame/components.dart';
import 'package:snake_game/components/snake/snake_body.dart';
import 'package:snake_game/components/snake/snake_head.dart';
import 'package:snake_game/components/snake/snake_tail.dart';
import 'package:snake_game/constants.dart';

class Snake extends Component {
  @override
  FutureOr<void> onLoad() {
    final headPosition = Vector2(200, 200);
    add(
      SnakeHead()..position = headPosition,
    );

    add(
      SnakeBody()..position = headPosition - Vector2(sizeCell, 0),
    );

    add(
      SnakeTail()..position = headPosition - Vector2(sizeCell * 2, 0),
    );
  }
}
