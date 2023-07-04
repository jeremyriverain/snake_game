import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ScoreEvent {}

class IncrementSore extends ScoreEvent {}

class ResetScore extends ScoreEvent {}

class ScoreState {
  final int score;
  ScoreState({
    required this.score,
  });
}

class ScoreBloc extends Bloc<ScoreEvent, ScoreState> {
  ScoreBloc()
      : super(
          ScoreState(score: 0),
        ) {
    on<IncrementSore>(
      (event, emit) => emit(
        ScoreState(score: state.score + 1),
      ),
    );
    on<ResetScore>(
      (event, emit) => emit(
        ScoreState(score: 0),
      ),
    );
  }
}
