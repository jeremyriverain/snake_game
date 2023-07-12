import 'package:flutter_bloc/flutter_bloc.dart';

abstract class GameFlowEvent {}

class PlayEvent extends GameFlowEvent {}

class LoseEvent extends GameFlowEvent {}

class GameFlowBloc extends Bloc<GameFlowEvent, GameState> {
  GameFlowBloc() : super(GameState.intro) {
    on<PlayEvent>(
      (event, emit) => emit(
        GameState.playing,
      ),
    );
    on<LoseEvent>((event, emit) {
      if (state != GameState.playing) {
        throw StateError('you cannot lose if you are not playing');
      }
      emit(
        GameState.gameOver,
      );
    });
  }
}

enum GameState { intro, playing, gameOver }
