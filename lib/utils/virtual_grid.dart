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

  List<Vector2> getEmptyCells(List<PositionComponent> components) {
    final filledCells = components
        .map((component) => toVirtualVector(component: component))
        .toList();

    return getAllVectors()
        .where((cell) => !filledCells.contains(cell))
        .toList();
  }
}
