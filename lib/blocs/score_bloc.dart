import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ScoreEvent {}

class IncrementScore extends ScoreEvent {}

class ResetScore extends ScoreEvent {}

class ScoreState {
  final int score;
  ScoreState({
    required this.score,
  });

  @override
  bool operator ==(Object other) => other is ScoreState && score == other.score;

  @override
  int get hashCode => Object.hash(score, 0);
}

class ScoreBloc extends Bloc<ScoreEvent, ScoreState> {
  ScoreBloc()
      : super(
          ScoreState(score: 0),
        ) {
    on<IncrementScore>(
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
