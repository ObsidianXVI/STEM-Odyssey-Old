part of stem_odyssey;

class MCMaleSprite extends SpriteAnimationComponent with CollisionCallbacks {
  MCMaleSprite({
    required super.animation,
  }) : super(size: Vector2.all(56));

  @override
  void onCollision(Set<Vector2> points, PositionComponent other) {
    super.onCollision(points, other);
    if (other is ScreenHitbox) {
      //...
    } else if (other is BuildingSprite) {
      //...
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
