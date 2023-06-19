part of stem_odyssey;

class GroundSprite extends SpriteComponent {
  final String img;
  GroundSprite({
    super.position,
  })  : img = 'ground_tile_1.png',
        super(
          size: Vector2.all(tileSize),
        );
  GroundSprite.tile({
    super.position,
  })  : img = 'b_tile.png',
        super(
          size: Vector2.all(tileSize),
        );

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load(img);
  }
}
