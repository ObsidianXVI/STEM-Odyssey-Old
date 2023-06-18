library stem_odyssey;

import 'package:flame/collisions.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flame/components.dart';

part './sprites/building.dart';
part './sprites/mc_male_sprite.dart';
part './sprites/ground.dart';

part './map/mapgen.dart';

const double tileSize = 48;

void main() {
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

  bool animationIsPlaying = true;

  BuildingSprite? closestBuildingSprite;

  @override
  KeyEventResult onKeyEvent(
      RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    // TODO: implement onKeyEvent
    return super.onKeyEvent(event, keysPressed);
  }

  @override
  Future<void> onLoad() async {
    overlays.add('minimap');

    final MCMaleSprite mcMaleSprite = MCMaleSprite(
      onTouchBuildingSprite: (BuildingSprite buildingSprite) {
        closestBuildingSprite = buildingSprite;
        overlays.add('press_e_to_enter');
        Future.delayed(const Duration(seconds: 2),
            () => overlays.remove('press_e_to_enter'));
      },
      animation: SpriteAnimation.spriteList(
        await Future.wait([1, 2].map(
          (i) => Sprite.load('mc_male_$i.png'),
        )),
        stepTime: 0.15,
      ),
    );

    final GroundSprite groundSprite = GroundSprite();

    mcMaleSprite.playing = animationIsPlaying;
    await addAll([
      ...MapGen.generateMap(50, 50),
      BuildingSprite(),
      mcMaleSprite,
    ]);
    camera.followComponent(mcMaleSprite);
  }
}
