import 'package:flutter_bloc/flutter_bloc.dart';

abstract class GameFlowEvent {}

class PlayEvent extends GameFlowEvent {}

class LoseEvent extends GameFlowEvent {}

class GameFlowState {
  final GameState gameState;
  GameFlowState({
    required this.gameState,
  });

  static bool isRestartingGame(
          GameFlowState previousState, GameFlowState newState) =>
      previousState.gameState == GameState.gameOver &&
      newState.gameState == GameState.playing;
}

final initialState = GameFlowState(gameState: GameState.intro);

class GameFlowBloc extends Bloc<GameFlowEvent, GameFlowState> {
  GameFlowBloc() : super(initialState) {
    on<PlayEvent>(
      (event, emit) => emit(
        GameFlowState(
          gameState: GameState.playing,
        ),
      ),
    );
    on<LoseEvent>(
      (event, emit) => emit(
        GameFlowState(
          gameState: GameState.gameOver,
        ),
      ),
    );
  }
}

enum GameState { intro, playing, gameOver }
