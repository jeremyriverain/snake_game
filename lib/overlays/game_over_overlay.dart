import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:snake_game/snake_game.dart';

class GameOverOverlay extends StatelessWidget {
  const GameOverOverlay(this.game, {super.key});

  final Game game;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        'Game Over',
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall
                            ?.copyWith(color: Colors.black),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        (game as SnakeGame).resetGame();
                      },
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(
                          const Size(150, 60),
                        ),
                        textStyle: MaterialStateProperty.all(
                            Theme.of(context).textTheme.titleLarge),
                      ),
                      child: const Text('Play Again'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
