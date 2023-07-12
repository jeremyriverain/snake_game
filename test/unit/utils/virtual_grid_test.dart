import 'package:flame/components.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:snake_game/utils/virtual_grid.dart';

void main() {
  group('GridUtil', () {
    const double sizeCell = 10;

    final offsetGrid = Vector2.all(10);

    final grid = VirtualGrid(
      sizeCell: sizeCell,
      columns: 2,
      rows: 3,
      gridPosition: offsetGrid,
    );

    test('getAllCells', () {
      expect(
        grid.getAllVectors(),
        [
          Vector2(0, 0),
          Vector2(0, 1),
          Vector2(0, 2),
          Vector2(1, 0),
          Vector2(1, 1),
          Vector2(1, 2),
        ],
      );
    });

    test('toVirtualGrid', () {
      final component = PositionComponent()
        ..size = Vector2.all(sizeCell)
        ..position = offsetGrid;

      expect(
        grid.toVirtualVector(component: component),
        Vector2(0, 0),
      );

      component.position = offsetGrid + Vector2(10, 20);

      expect(
        grid.toVirtualVector(component: component),
        Vector2(1, 2),
      );
    });

    test('toRelativePosition', () {
      expect(
        grid.toRelativePosition(virtualGridVector: Vector2(0, 0)),
        Vector2(5, 5),
      );

      expect(
        grid.toRelativePosition(virtualGridVector: Vector2(1, 2)),
        Vector2(15, 25),
      );
    });

    test('getEmptyCells', () {
      expect(grid.getEmptyCells([]), grid.getAllVectors());
      expect(
        grid.getEmptyCells([
          PositionComponent()
            ..anchor = Anchor.center
            ..position = offsetGrid + Vector2(5, 5),
        ]),
        grid.getAllVectors()
          ..removeWhere(
            (element) => element == Vector2.zero(),
          ),
      );

      expect(
        grid.getEmptyCells([
          PositionComponent()
            ..anchor = Anchor.topLeft
            ..position = offsetGrid + Vector2.zero()
        ]),
        grid.getAllVectors()
          ..removeWhere(
            (element) => element == Vector2.zero(),
          ),
      );

      expect(
        grid.getEmptyCells([
          PositionComponent()
            ..anchor = Anchor.topLeft
            ..position = offsetGrid + Vector2.zero(),
          PositionComponent()
            ..anchor = Anchor.topLeft
            ..position = offsetGrid + Vector2(sizeCell, 0),
        ]),
        grid.getAllVectors()
          ..removeWhere(
            (element) => element == Vector2.zero() || element == Vector2(1, 0),
          ),
      );
    });
  });
}
