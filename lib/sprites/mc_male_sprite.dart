part of stem_odyssey;

class MCMaleSprite extends SpriteAnimationComponent with CollisionCallbacks {
  final void Function(BuildingSprite) onTouchBuildingSprite;
  MCMaleSprite({
    required super.animation,
    required this.onTouchBuildingSprite,
  }) : super(
          size: Vector2.all(56),
          //position: Vector2(tileSize * 10, tileSize * 10),
        );

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is ScreenHitbox) {
      //...
    } else if (other is BuildingSprite) {
      onTouchBuildingSprite(other);
      position = intersectionPoints.first;
    }
  }

  @override
  Future<void> onLoad() async {
    addAll([
      RectangleHitbox(
        position: position,
        size: size,
        isSolid: true,
      ),
      KeyboardListenerComponent(
        keyDown: {
          LogicalKeyboardKey.keyA: (keysPressed) {
            position.add(Vector2(-(tileSize / 2), 0));
            return true;
          },
          LogicalKeyboardKey.keyD: (keysPressed) {
            position.add(Vector2((tileSize / 2), 0));
            return true;
          },
          LogicalKeyboardKey.keyW: (keysPressed) {
            position.add(Vector2(0, -(tileSize / 2)));
            return true;
          },
          LogicalKeyboardKey.keyS: (keysPressed) {
            position.add(Vector2(0, (tileSize / 2)));
            return true;
          },
        },
      ),
    ]);
  }
}
