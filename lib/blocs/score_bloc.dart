import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ScoreEvent {}

class IncrementScore extends ScoreEvent {}

class ResetScore extends ScoreEvent {}

class ScoreBloc extends Bloc<ScoreEvent, int> {
  ScoreBloc() : super(0) {
    on<IncrementScore>(
      (event, emit) => emit(state + 1),
    );
    on<ResetScore>(
      (event, emit) => emit(0),
    );
  }
}
