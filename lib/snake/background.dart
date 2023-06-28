import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:snake_game/constants.dart';

class Background extends Component with HasGameRef {
  @override
  FutureOr<void> onLoad() {
    add(RectangleComponent(
      position: Vector2(globalPadding, globalPadding + heightScoreBanner),
      size: Vector2(
        gameRef.size.x - globalPadding * 2,
        gameRef.size.y - heightScoreBanner - globalPadding * 2,
      ),
      paint: Paint()..color = const Color(0xFFA3D148),
    ));
  }
}
