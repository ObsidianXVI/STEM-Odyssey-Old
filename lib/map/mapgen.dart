part of stem_odyssey;

class MapGen {
  static List<SpriteComponent> generateMap(int width, int height) {
    final List<SpriteComponent> spriteComponents = [];
    final GroundSprite sprite1 = GroundSprite();
    final NotifyingVector2 origin = sprite1.position;
    spriteComponents.add(sprite1);
    for (int col = 0; col < width; col++) {
      for (int row = 0; row < height; row++) {
        spriteComponents.add(
          GroundSprite(
            position: Vector2(
              tileSize * col,
              tileSize * row,
            ),
          ),
        );
      }
    }
    spriteComponents.add(
      BuildingSprite(),
    );
    return spriteComponents;
  }

  static List<SpriteComponent> generateBuildingMap() {
    final List<SpriteComponent> spriteComponents = [];
    final GroundSprite sprite1 = GroundSprite.tile();
    final NotifyingVector2 origin = sprite1.position;
    spriteComponents.add(sprite1);
    for (int col = 0; col < 10; col++) {
      for (int row = 0; row < 15; row++) {
        spriteComponents.add(
          GroundSprite(
            position: Vector2(
              tileSize * col,
              tileSize * row,
            ),
          ),
        );
      }
    }
    return spriteComponents;
  }
}
