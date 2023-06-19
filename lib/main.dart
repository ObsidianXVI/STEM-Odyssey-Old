library stem_odyssey;

import 'package:flame/collisions.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart' hide Route;
import 'package:flutter/services.dart';
import 'package:flame/components.dart';

part './sprites/building.dart';
part './sprites/mc_male_sprite.dart';
part './sprites/ground.dart';

part './map/mapgen.dart';

part './utils/expirable_value.dart';

const double tileSize = 48;

/* void main() {
  final Game game = STEMOdyssey(
    children: [],
  );
  runApp(
    GameWidget(
      game: game,
      loadingBuilder: (BuildContext context) {
        return Center(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.deepPurple.shade900,
            child: const Center(
              child: Text('STEM Odyssey'),
            ),
          ),
        );
      },
      overlayBuilderMap: {
        'minimap': (BuildContext context, Game game) {
          return Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 20,
                right: 20,
              ),
              child: Container(
                width: 200,
                height: 200,
                color: Colors.black.withOpacity(0.3),
              ),
            ),
          );
        },
        'press_e_to_enter': (BuildContext context, Game game) {
          return Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: 60,
              color: Colors.black.withOpacity(0.3),
              child: const Center(
                child: Text(
                  'Press E to enter the building',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
        },
      },
    ),
  );
}

class STEMOdyssey extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  STEMOdyssey({
    super.children,
    super.camera,
  });

  final RouterComponent routerComponent = RouterComponent(
    initialRoute: 'splash',
    routes: {
      'splash': Route(GamePage.new),
      'building': Route(() {
        return BuildingSpriteMap();
      }),
      'fullmap': Route(() {
        return FullSpriteMap();
      }),
    },
  );

  bool animationIsPlaying = true;

  BuildingSprite? closestBuildingSprite;

  @override
  KeyEventResult onKeyEvent(
      RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (keysPressed.contains(LogicalKeyboardKey.keyE)) {
      if (closestBuildingSprite != null) {
        print('genning map');
      }
    }
    return super.onKeyEvent(event, keysPressed);
  }

  @override
  Future<void> onLoad() async {
    overlays.add('minimap');

    final MCMaleSprite mcMaleSprite = MCMaleSprite(
      onTouchBuildingSprite: (BuildingSprite buildingSprite) {
        routerComponent.pushNamed('building');
        timedAction(4, () {
          closestBuildingSprite = null;
        });
        overlays.add('press_e_to_enter');
        timedAction(2, () {
          overlays.remove('press_e_to_enter');
        });
      },
      animation: SpriteAnimation.spriteList(
        await Future.wait([1, 2].map(
          (i) => Sprite.load('mc_male_$i.png'),
        )),
        stepTime: 0.15,
      ),
    );

    mcMaleSprite.playing = animationIsPlaying;
    await add(routerComponent);
    camera.followComponent(mcMaleSprite);
  }
}

class GamePage extends Component with HasGameRef<STEMOdyssey> {
  GamePage() {
    gameRef.routerComponent.pushNamed('fullmap');
    addAll([]);
  }
}
 */

void main(List<String> args) {
  final Game game = STEMOdyssey();
  runApp(
    GameWidget(
      game: game,
      loadingBuilder: (BuildContext context) {
        return Center(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.deepPurple.shade900,
            child: const Center(
              child: Text('STEM Odyssey'),
            ),
          ),
        );
      },
      overlayBuilderMap: {
        'minimap': (BuildContext context, Game game) {
          return Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 20,
                right: 20,
              ),
              child: Container(
                width: 200,
                height: 200,
                color: Colors.black.withOpacity(0.3),
              ),
            ),
          );
        },
        'press_e_to_enter': (BuildContext context, Game game) {
          return Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: 60,
              color: Colors.black.withOpacity(0.3),
              child: const Center(
                child: Text(
                  'Press E to enter the building',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
        },
      },
    ),
  );
}

class STEMOdyssey extends FlameGame
    with HasCollisionDetection, HasKeyboardHandlerComponents {
  final RouterComponent routerComponent = RouterComponent(
    initialRoute: 'fullmap',
    routes: {
      'fullmap': Route(FullMap.new),
      'building': Route(BuildingMap.new),
    },
  );

  STEMOdyssey() : super(children: []);

  @override
  Future<void> onLoad() async {
    add(
      routerComponent,
    );
  }
}

class GamePage extends Component with HasGameRef<STEMOdyssey> {
  GamePage() {
    //gameRef.routerComponent.pushNamed('fullmap');
    addAll([
      TextComponent(text: 'STEM Odyssey'),
    ]);
  }
}

class FullMap extends Component with HasGameRef<STEMOdyssey> {
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
    addAll([
      ...MapGen.generateMap(50, 50),
      mcMaleSprite,
    ]);
  }
}

class BuildingMap extends Component with HasGameRef<STEMOdyssey> {
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
    addAll([
      ...MapGen.generateBuildingMap(),
      mcMaleSprite,
    ]);
  }
}
