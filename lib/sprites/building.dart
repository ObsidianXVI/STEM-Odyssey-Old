part of stem_odyssey;

class BuildingSprite extends SpriteComponent {
  BuildingSprite() : super(size: Vector2.all(tileSize * 5));

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('test_building.png');
  }
}

enum MCMaleSpriteStatus {
  idle,
  running,
}
