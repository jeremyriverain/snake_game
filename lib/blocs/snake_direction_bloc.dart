import 'package:flame/game.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snake_game/utils/direction_util.dart';

abstract class SnakeDirectionEvent {}

class DragScreenEvent extends SnakeDirectionEvent {
  final Vector2 dragStartPosition;
  final Vector2 dragLastPosition;
  DragScreenEvent({
    required this.dragStartPosition,
    required this.dragLastPosition,
  });
}

class MoveEvent extends SnakeDirectionEvent {
  final Direction direction;
  MoveEvent({
    required this.direction,
  });
}

class SnakeDirectionState {
  final Direction direction;
  SnakeDirectionState({
    required this.direction,
  });
}

class SnakeDirectionBloc
    extends Bloc<SnakeDirectionEvent, SnakeDirectionState> {
  SnakeDirectionBloc()
      : super(
          SnakeDirectionState(
            direction: Direction.right,
          ),
        ) {
    on<DragScreenEvent>((event, emit) {
      emit(
        SnakeDirectionState(
          direction: DirectionUtil.vectorsToDirection(
            event.dragStartPosition,
            event.dragLastPosition,
          ),
        ),
      );
    });
    on<MoveEvent>((event, emit) {
      emit(
        SnakeDirectionState(
          direction: event.direction,
        ),
      );
    });
  }
}
