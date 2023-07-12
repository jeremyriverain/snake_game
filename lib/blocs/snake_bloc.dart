import 'package:equatable/equatable.dart';
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

class UpdateDirectionEvent extends SnakeEvent {
  final Direction directionRequested;
  UpdateDirectionEvent({
    required this.directionRequested,
  });
}

class ResetSnakeEvent extends SnakeEvent {}

class SnakeState extends Equatable {
  final Direction direction;

  const SnakeState({
    required this.direction,
  });

  SnakeState copyWith({
    Direction? direction,
  }) {
    return SnakeState(
      direction: direction ?? this.direction,
    );
  }

  @override
  List<Object> get props => [direction];
}

class SnakeBloc extends Bloc<SnakeEvent, SnakeState> {
  SnakeBloc()
      : super(const SnakeState(
          direction: Direction.right,
        )) {
    on<DragScreenEvent>((event, emit) {
      final directionRequested = DirectionUtil.vectorsToDirection(
        event.dragStartPosition,
        event.dragLastPosition,
      );

      add(UpdateDirectionEvent(directionRequested: directionRequested));
    });

    on<UpdateDirectionEvent>((event, emit) {
      if (event.directionRequested ==
          DirectionUtil.getForbiddenDirectionOf(state.direction)) {
        return;
      }
      emit(state.copyWith(direction: event.directionRequested));
    });

    on<ResetSnakeEvent>(
      (event, emit) => emit(
        const SnakeState(
          direction: Direction.right,
        ),
      ),
    );
  }
}
