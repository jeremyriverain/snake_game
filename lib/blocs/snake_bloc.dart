import 'package:flame/game.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  final Direction direction;
  TapArrowKeyEvent({
    required this.direction,
  });
}

class MoveHeadEvent extends SnakeEvent {
  final Vector2 position;

  MoveHeadEvent({required this.position});
}

class SnakeState {
  final Direction direction;
  final Vector2 headPosition;
  SnakeState({
    required this.direction,
    required this.headPosition,
  });

  SnakeState copyWith({
    Direction? direction,
    Vector2? headPosition,
  }) {
    return SnakeState(
      direction: direction ?? this.direction,
      headPosition: headPosition ?? this.headPosition,
    );
  }
}

class SnakeBloc extends Bloc<SnakeEvent, SnakeState> {
  SnakeBloc()
      : super(
          SnakeState(
            direction: Direction.right,
            headPosition: Vector2.zero(),
          ),
        ) {
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
      if (event.direction ==
          DirectionUtil.getForbiddenDirectionOf(state.direction)) {
        return;
      }
      emit(state.copyWith(direction: event.direction));
    });

    on<MoveHeadEvent>((event, emit) {
      emit(state.copyWith(headPosition: event.position));
    });
  }
}
