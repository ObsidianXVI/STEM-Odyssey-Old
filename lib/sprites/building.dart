part of odyssey.sprites;

class BuildingSprite extends SpriteComponent {
  BuildingSprite() : super(size: Vector2.all(256));

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('test_building.png');
  }
}

enum MCMaleSpriteStatus {
  idle,
  running,
}

class MCMaleSprite extends SpriteAnimationComponent {
  MCMaleSprite({
    required super.animation,
  }) : super(size: Vector2.all(56));

  @override
  Future<void> onLoad() async {}
}
