part of stem_odyssey;

class BuildingSprite extends SpriteComponent with CollisionCallbacks {
  BuildingSprite() : super(size: Vector2.all(tileSize * 5));

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('test_building.png');
    add(
      RectangleHitbox(
        position: position,
        size: size,
        isSolid: true,
      ),
    );
  }
}

enum MCMaleSpriteStatus {
  idle,
  running,
}
