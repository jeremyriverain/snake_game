import 'package:flame/components.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:snake_game/utils/grid_util.dart';

void main() {
  group('GridUtil', () {
    const double sizeCell = 10;

    final grid = GridUtil(
      sizeCell: sizeCell,
      columns: 2,
      rows: 3,
      gridPosition: Vector2(10, 10),
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
        ..position = Vector2(10, 10);

      expect(
        grid.toVirtualVector(component: component),
        Vector2(0, 0),
      );

      component.position = Vector2(20, 30);

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
  });
}
