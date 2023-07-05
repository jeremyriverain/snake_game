import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:snake_game/blocs/score_bloc.dart';

void main() {
  group('ScoreBloc', () {
    blocTest(
      'Default state',
      build: () => ScoreBloc(),
      verify: (bloc) {
        expect(bloc.state.score, 0);
      },
    );

    blocTest(
      'IncrementStore',
      build: () => ScoreBloc(),
      act: (bloc) => bloc.add(IncrementStore()),
      expect: () => [ScoreState(score: 1)],
    );

    blocTest(
      'ResetStore',
      build: () => ScoreBloc(),
      seed: () => ScoreState(score: 5),
      act: (bloc) => bloc.add(ResetScore()),
      expect: () => [ScoreState(score: 0)],
    );
  });
}
