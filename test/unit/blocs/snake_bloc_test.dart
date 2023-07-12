import 'package:bloc_test/bloc_test.dart';
import 'package:flame/components.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:snake_game/blocs/snake_bloc.dart';
import 'package:snake_game/utils/direction_util.dart';

void main() {
  group('SnakeBloc', () {
    blocTest(
      'Default state',
      build: () => SnakeBloc(),
      verify: (bloc) {
        expect(bloc.state, const SnakeState(direction: Direction.right));
      },
    );

    group('DragScreenEvent', () {
      blocTest(
        'given Direction.right, keeps Direction.right if swipe to right or left',
        build: () => SnakeBloc(),
        seed: () => const SnakeState(direction: Direction.right),
        act: (bloc) {
          bloc.add(
            DragScreenEvent(
              dragStartPosition: Vector2(0, 0),
              dragLastPosition: Vector2(1, 0),
            ),
          );
          bloc.add(
            DragScreenEvent(
              dragStartPosition: Vector2(0, 0),
              dragLastPosition: Vector2(-1, 0),
            ),
          );
        },
        expect: () => [],
      );

      blocTest(
        'given Direction.right, update to Direction.down if swipe to bottom',
        build: () => SnakeBloc(),
        seed: () => const SnakeState(direction: Direction.right),
        act: (bloc) => bloc.add(
          DragScreenEvent(
            dragStartPosition: Vector2(0, 0),
            dragLastPosition: Vector2(0, 1),
          ),
        ),
        expect: () => [const SnakeState(direction: Direction.down)],
      );

      blocTest(
        'given Direction.right, update to Direction.up if swipe to top',
        build: () => SnakeBloc(),
        seed: () => const SnakeState(direction: Direction.right),
        act: (bloc) => bloc.add(
          DragScreenEvent(
            dragStartPosition: Vector2(0, 0),
            dragLastPosition: Vector2(0, -1),
          ),
        ),
        expect: () => [const SnakeState(direction: Direction.up)],
      );
    });

    group('UpdateDirectionEvent', () {
      blocTest(
        'given Direction.right, update to Direction.up if Direction.up requested',
        build: () => SnakeBloc(),
        seed: () => const SnakeState(direction: Direction.right),
        act: (bloc) =>
            bloc.add(UpdateDirectionEvent(directionRequested: Direction.up)),
        expect: () => [const SnakeState(direction: Direction.up)],
      );

      blocTest(
        'given Direction.right, update to Direction.down if Direction.down requested',
        build: () => SnakeBloc(),
        seed: () => const SnakeState(direction: Direction.right),
        act: (bloc) =>
            bloc.add(UpdateDirectionEvent(directionRequested: Direction.down)),
        expect: () => [const SnakeState(direction: Direction.down)],
      );

      blocTest(
        'given Direction.right, keeps Direction.right if right or left requested',
        build: () => SnakeBloc(),
        seed: () => const SnakeState(direction: Direction.right),
        act: (bloc) {
          bloc.add(UpdateDirectionEvent(directionRequested: Direction.right));
          bloc.add(UpdateDirectionEvent(directionRequested: Direction.left));
        },
        expect: () => [],
      );
    });

    blocTest(
      'ResetSnakeEvent',
      build: () => SnakeBloc(),
      seed: () => const SnakeState(direction: Direction.left),
      act: (bloc) => bloc.add(ResetSnakeEvent()),
      expect: () => [const SnakeState(direction: Direction.right)],
    );
  });
}
