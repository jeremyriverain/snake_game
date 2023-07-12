import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:snake_game/blocs/game_flow_bloc.dart';

void main() {
  group('GameFlowBloc', () {
    blocTest(
      'Default state',
      build: () => GameFlowBloc(),
      verify: (bloc) {
        expect(bloc.state, GameState.intro);
      },
    );

    blocTest(
      'PlayEvent',
      build: () => GameFlowBloc(),
      act: (bloc) => bloc.add(PlayEvent()),
      expect: () => [GameState.playing],
    );

    blocTest(
      'LoseEvent',
      build: () => GameFlowBloc(),
      seed: () => GameState.playing,
      act: (bloc) => bloc.add(LoseEvent()),
      expect: () => [GameState.gameOver],
    );

    blocTest(
      'LoseEvent throws error if not playing',
      build: () => GameFlowBloc(),
      act: (bloc) => bloc.add(LoseEvent()),
      errors: () => [isA<StateError>()],
    );
  });
}
