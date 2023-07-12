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
  final Direction directionRequested;
  TapArrowKeyEvent({
    required this.directionRequested,
  });
}

class CollideCellEvent extends SnakeEvent {}

class ResetSnakeEvent extends SnakeEvent {}

class SnakeState {
  final Direction direction;
  SnakeState({
    required this.direction,
  });

  SnakeState copyWith({
    Direction? direction,
    int? lengthSnake,
  }) {
    return SnakeState(
      direction: direction ?? this.direction,
    );
  }
}

class SnakeBloc extends Bloc<SnakeEvent, SnakeState> {
  SnakeBloc()
      : super(SnakeState(
          direction: Direction.right,
        )) {
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

    on<ResetSnakeEvent>((event, emit) => emit(SnakeState(
          direction: Direction.right,
        )));
  }
}
