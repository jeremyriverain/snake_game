import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';
import 'package:snake_game/components/food.dart';
import 'package:snake_game/components/ground.dart';
import 'package:snake_game/game_config.dart';
import 'package:snake_game/snake_game.dart';

class SnakeHead extends SpriteComponent
    with HasGameRef<SnakeGame>, CollisionCallbacks {
  SnakeHead()
      : super(
          size: Vector2.all(
            GameConfig.sizeCell,
          ),
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
      game.onEatFood();
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
      game.gameOver();
    }
  }
}
