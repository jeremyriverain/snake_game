import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:snake_game/overlays/score_overlay.dart';
import 'package:snake_game/snake_game.dart';
import 'package:snake_game/overlays/game_over_overlay.dart';
import 'package:snake_game/overlays/instructions_overlay.dart';

void main() {
  runApp(const MyApp());
}

final Game game = SnakeGame();

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  static const instructionsOverlay = 'instructionsOverlay';
  static const scoreOverlay = 'scoreOverlay';
  static const gameOverOverlay = 'gameOverOverlay';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'PressStart2P',
      ),
      home: GameWidget(
        game: game,
        overlayBuilderMap: <String, Widget Function(BuildContext, Game)>{
          instructionsOverlay: (context, game) => InstructionsOverlay(game),
          gameOverOverlay: (context, game) => GameOverOverlay(game),
          scoreOverlay: (context, game) => ScoreOverlay(game),
        },
        initialActiveOverlays: const [
          scoreOverlay,
        ],
      ),
    );
  }
}
