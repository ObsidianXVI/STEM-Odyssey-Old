part of stem_odyssey;

class GroundSprite extends SpriteComponent {
  GroundSprite({
    super.position,
  }) : super(
          size: Vector2.all(tileSize),
        );

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('ground_tile_1.png');
  }
}
