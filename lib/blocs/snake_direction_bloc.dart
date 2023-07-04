import 'package:flame/game.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snake_game/utils/direction_util.dart';

abstract class SnakeDirectionEvent {}

class MoveEvent extends SnakeDirectionEvent {
  final Vector2 dragStartPosition;
  final Vector2 dragLastPosition;
  MoveEvent({
    required this.dragStartPosition,
    required this.dragLastPosition,
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
    on<MoveEvent>((event, emit) {
      emit(
        SnakeDirectionState(
          direction: DirectionUtil.vectorsToDirection(
            event.dragStartPosition,
            event.dragLastPosition,
          ),
        ),
      );
    });
  }
}
