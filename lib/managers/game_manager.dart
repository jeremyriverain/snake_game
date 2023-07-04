import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:snake_game/blocs/score_bloc.dart';
import 'package:snake_game/snake_game.dart';

class GameManager extends Component
    with HasGameRef<SnakeGame>, FlameBlocReader<ScoreBloc, ScoreState> {
  GameManager();

  GameState state = GameState.intro;

  bool get isPlaying => state == GameState.playing;
  bool get isGameOver => state == GameState.gameOver;
  bool get isIntro => state == GameState.intro;

  void reset() {
    bloc.add(ResetScore());
    state = GameState.intro;
  }

  void increaseScore() {
    bloc.add(IncrementSore());
  }
}

enum GameState { intro, playing, gameOver }
