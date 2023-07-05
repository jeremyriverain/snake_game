import 'package:flame/effects.dart';
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
  final List<Effect> effect;

  MoveEvent({
    required this.effect,
  });
}

class SnakeState {
  final Direction direction;
  final List<List<Effect>> bodyPartsEffects;
  final int lengthSnake;
  SnakeState({
    required this.direction,
    required this.bodyPartsEffects,
    required this.lengthSnake,
  });

  SnakeState copyWith({
    Direction? direction,
    List<List<Effect>>? bodyPartsEffects,
    int? lengthSnake,
  }) {
    return SnakeState(
      direction: direction ?? this.direction,
      bodyPartsEffects: bodyPartsEffects ?? this.bodyPartsEffects,
      lengthSnake: lengthSnake ?? this.lengthSnake,
    );
  }
}

final initialState = SnakeState(
  direction: Direction.right,
  bodyPartsEffects: [],
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
      emit(
        state.copyWith(
          bodyPartsEffects: [
            event.effect,
          ],
        ),
      );
    });
  }
}
