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
            child: Container(
              width: 50,
              height: 50,
              color: Colors.black.withOpacity(0.3),
            ),
          );
        },
      },
    ),
  );
}

class STEMOdyssey extends FlameGame with HasKeyboardHandlerComponents {
  STEMOdyssey({
    super.children,
    super.camera,
  });
  bool animationIsPlaying = true;

  @override
  Future<void> onLoad() async {
    final MCMaleSprite mcMaleSprite = MCMaleSprite(
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
