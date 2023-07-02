import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';
import 'package:snake_game/components/food.dart';
import 'package:snake_game/components/ground/ground.dart';
import 'package:snake_game/game_config.dart';

class SnakeHead extends SpriteComponent with CollisionCallbacks {
  final void Function() whenEatFood;
  final void Function() whenDead;

  SnakeHead({
    required this.whenEatFood,
    required this.whenDead,
  }) : super(
          size: Vector2.all(
            GameConfig.sizeCell,
          ),
          anchor: Anchor.topRight,
        );
  @override
  onLoad() async {
    sprite = await Sprite.load(
      'game_sprite.png',
      srcSize: Vector2(GameConfig.sizeCellAsset, GameConfig.sizeCellAsset),
      srcPosition: Vector2(GameConfig.sizeCellAsset * 2, 0),
    );

    add(RectangleHitbox());
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);
    if (other is Food) {
      whenEatFood();
    }
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is Ground) {
      add(
        ParticleSystemComponent(
          position: Vector2(GameConfig.sizeCell, GameConfig.sizeCell / 2),
          particle: CircleParticle(
            radius: GameConfig.sizeCell,
            paint: Paint()..color = Colors.red.withOpacity(.5),
          ),
        ),
      );
      whenDead();
    }
  }
}
