import 'package:flame/components.dart';
import 'package:snake_game/game_config.dart';

class GridUtil {
  final double sizeCell;
  final int columns;
  final int rows;
  final Vector2 gridPosition;

  GridUtil({
    required this.sizeCell,
    required this.columns,
    required this.rows,
    required this.gridPosition,
  });

  List<Vector2> getAllVectors() {
    final cells = <Vector2>[];
    for (var column = 0; column < columns; column++) {
      for (var row = 0; row < rows; row++) {
        cells.add(Vector2(column.toDouble(), row.toDouble()));
      }
    }
    return cells;
  }

  Vector2 toVirtualVector({
    required PositionComponent component,
  }) {
    return ((component.anchor.toOtherAnchorPosition(component.absolutePosition,
                Anchor.topLeft, Vector2.all(sizeCell)) -
            gridPosition) /
        sizeCell)
      ..floor();
  }

  Vector2 toRelativePosition({
    required Vector2 virtualGridVector,
  }) {
    return ((virtualGridVector + Vector2.all(.5)) * sizeCell);
  }

  static bool hasMovedToNextCell({
    required Vector2 previousCell,
    required Vector2 nextCell,
  }) {
    final isXAxisOverflowed = nextCell.x - previousCell.x > GameConfig.sizeCell;
    final isYAxisOverflowed = nextCell.y - previousCell.y > GameConfig.sizeCell;
    return isXAxisOverflowed || isYAxisOverflowed;
  }

  // static Vector2 normalizeVector(Vector2 vector) {
  //   return Vector2(vector.x.floorToDouble(), vector.y.floorToDouble());
  // }
}
