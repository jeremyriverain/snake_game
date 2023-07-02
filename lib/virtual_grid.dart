import 'package:flame/components.dart';

class VirtualGrid {
  final double sizeCell;
  final int columns;
  final int rows;
  final Vector2 gridPosition;

  VirtualGrid({
    required this.sizeCell,
    required this.columns,
    required this.rows,
    required this.gridPosition,
  });

  List<Vector2> getAllCells() {
    final cells = <Vector2>[];
    for (var column = 0; column < columns; column++) {
      for (var row = 0; row < rows; row++) {
        cells.add(Vector2(column.toDouble(), row.toDouble()));
      }
    }
    return cells;
  }

  Vector2 toVirtualGrid({
    required PositionComponent component,
  }) {
    return ((component.anchor.toOtherAnchorPosition(component.absolutePosition,
                Anchor.topLeft, Vector2.all(sizeCell)) -
            gridPosition) /
        sizeCell)
      ..floor();
  }

  Vector2 toAbsolutePosition({
    required Vector2 virtualGridVector,
  }) {
    return (virtualGridVector * sizeCell);
  }
}
