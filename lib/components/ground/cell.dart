import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:snake_game/game_config.dart';

class Cell extends RectangleComponent {
  final Color color;
  final bool hasHitbox;
  Cell({
    required this.color,
    required Vector2 position,
    required this.hasHitbox,
  }) : super(
          size: Vector2.all(GameConfig.sizeCell),
          position: position,
        ) {
    setColor(color);
    if (hasHitbox) {
      add(
        RectangleHitbox(
          collisionType: CollisionType.passive,
        ),
      );
    }
  }
}
