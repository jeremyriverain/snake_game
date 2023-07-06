import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';
import 'package:snake_game/components/food.dart';
import 'package:snake_game/components/ground/ground.dart';
import 'package:snake_game/components/snake/snake_body_part.dart';
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
          anchor: Anchor.center,
        );
  @override
  onLoad() async {
    super.onLoad();
    sprite = await Sprite.load(
      'game_sprite.png',
      srcSize: Vector2(GameConfig.sizeCellAsset, GameConfig.sizeCellAsset),
      srcPosition: Vector2(GameConfig.sizeCellAsset * 2, 0),
    );

    final Vector2 sizeHitbox =
        Vector2(GameConfig.sizeCell - 5, GameConfig.sizeCell - 14);
    add(RectangleHitbox(
      size: sizeHitbox,
      position: Vector2(
        2,
        (GameConfig.sizeCell - sizeHitbox.y) / 2,
      ),
    ));
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
    if (other is Ground || other is SnakeBodyPart) {
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
