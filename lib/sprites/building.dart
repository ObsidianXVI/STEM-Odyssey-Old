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

  List<SpriteComponent> generateMap() {
    return MapGen.generateBuildingMap();
  }
}

class BuildingSpriteMap extends SpriteComponent {
  final STEMOdyssey game;
  BuildingSpriteMap({
    required this.game,
  });

  @override
  Future<void> onLoad() async {
    final MCMaleSprite mcMaleSprite = MCMaleSprite(
      game: game,
      animation: SpriteAnimation.spriteList(
        await Future.wait([1, 2].map(
          (i) => Sprite.load('mc_male_$i.png'),
        )),
        stepTime: 0.15,
      ),
    );

    mcMaleSprite.playing = true;

    await addAll([
      ...MapGen.generateBuildingMap(),
      mcMaleSprite,
    ]);
  }
}

class FullSpriteMap extends Component {
  final STEMOdyssey game;
  FullSpriteMap({
    required this.game,
  });
  @override
  Future<void> onLoad() async {
    final MCMaleSprite mcMaleSprite = MCMaleSprite(
      game: game,
      animation: SpriteAnimation.spriteList(
        await Future.wait([1, 2].map(
          (i) => Sprite.load('mc_male_$i.png'),
        )),
        stepTime: 0.15,
      ),
    );

    mcMaleSprite.playing = true;

    await addAll([
      ...MapGen.generateMap(50, 50),
      mcMaleSprite,
    ]);
  }
}

enum MCMaleSpriteStatus {
  idle,
  running,
}
