import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:snake_game/main.dart';
import 'package:snake_game/snake_game.dart';

class GameManager extends Component with HasGameRef<SnakeGame> {
  GameManager();

  ValueNotifier<int> score = ValueNotifier(0);
  GameState state = GameState.intro;

  bool get isPlaying => state == GameState.playing;
  bool get isGameOver => state == GameState.gameOver;
  bool get isIntro => state == GameState.intro;

  void reset() {
    score.value = 0;
    state = GameState.intro;
  }

  void increaseScore() {
    score.value++;
  }
}

enum GameState { intro, playing, gameOver }
