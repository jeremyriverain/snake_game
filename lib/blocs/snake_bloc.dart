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
  final Direction? directionRequested;
  SnakeState({
    required this.direction,
    this.directionRequested,
  });

  SnakeState copyWith({
    Direction? direction,
    Direction? directionRequested,
  }) {
    return SnakeState(
      direction: direction ?? this.direction,
      directionRequested: directionRequested ?? this.directionRequested,
    );
  }
}

final initialState = SnakeState(
  direction: Direction.right,
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
      emit(state.copyWith(directionRequested: directionRequested));
    });
    on<TapArrowKeyEvent>((event, emit) {
      if (event.directionRequested ==
          DirectionUtil.getForbiddenDirectionOf(state.direction)) {
        return;
      }
      emit(state.copyWith(directionRequested: event.directionRequested));
    });

    on<CollideCellEvent>((event, emit) {
      emit(state.copyWith(direction: state.directionRequested));
    });

    on<ResetSnakeEvent>((event, emit) => emit(initialState));
  }
}
