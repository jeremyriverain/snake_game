import 'package:flame/game.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snake_game/game_config.dart';
import 'package:snake_game/utils/direction_util.dart';

abstract class SnakeEvent {}

class DragScreenEvent extends SnakeEvent {
  final Vector2 dragStartPosition;
  final Vector2 dragLastPosition;
  DragScreenEvent({
    required this.dragStartPosition,
    required this.dragLastPosition,
  });
}

class TapArrowKeyEvent extends SnakeEvent {
  final Direction directionRequested;
  TapArrowKeyEvent({
    required this.directionRequested,
  });
}

class CollideCellEvent extends SnakeEvent {}

class ResetSnakeEvent extends SnakeEvent {}

class MoveEvent extends SnakeEvent {
  final Vector2 direction;

  MoveEvent({
    required this.direction,
  });
}

class SnakeState {
  final Direction direction;
  final List<Vector2> headDirectionHistory;
  final int lengthSnake;
  SnakeState({
    required this.direction,
    required this.headDirectionHistory,
    required this.lengthSnake,
  });

  SnakeState copyWith({
    Direction? direction,
    List<Vector2>? headDirectionHistory,
    int? lengthSnake,
  }) {
    return SnakeState(
      direction: direction ?? this.direction,
      headDirectionHistory: headDirectionHistory ?? this.headDirectionHistory,
      lengthSnake: lengthSnake ?? this.lengthSnake,
    );
  }
}

final initialState = SnakeState(
  direction: Direction.right,
  headDirectionHistory: List.unmodifiable([
    DirectionUtil.directionToVector(Direction.right),
  ]),
  lengthSnake: GameConfig.lengthSnake,
);

class SnakeBloc extends Bloc<SnakeEvent, SnakeState> {
  SnakeBloc() : super(initialState) {
    on<DragScreenEvent>((event, emit) {
      final directionRequested = DirectionUtil.vectorsToDirection(
        event.dragStartPosition,
        event.dragLastPosition,
      );

      if (directionRequested ==
          DirectionUtil.getForbiddenDirectionOf(state.direction)) {
        return;
      }
      emit(state.copyWith(direction: directionRequested));
    });
    on<TapArrowKeyEvent>((event, emit) {
      if (event.directionRequested ==
          DirectionUtil.getForbiddenDirectionOf(state.direction)) {
        return;
      }
      emit(state.copyWith(direction: event.directionRequested));
    });

    on<ResetSnakeEvent>((event, emit) => emit(initialState));

    on<MoveEvent>((event, emit) {
      final List<Vector2> history =
          List.unmodifiable([...state.headDirectionHistory, event.direction]);
      emit(
        state.copyWith(
          headDirectionHistory: history,
        ),
      );
    });
  }
}
