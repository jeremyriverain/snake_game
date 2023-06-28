import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:snake_game/snake_game.dart';

void main() {
  runApp(
    SafeArea(
      child: GameWidget(
        game: SnakeGame(),
      ),
    ),
  );
}
