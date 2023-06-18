import 'package:flame/game.dart';
import 'package:flame/widgets.dart';
import 'package:flutter/material.dart';
import './sprites/sprites.dart';

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

class STEMOdyssey extends FlameGame {
  STEMOdyssey({
    super.children,
    super.camera,
  });

  @override
  Future<void> onLoad() async {
    await addAll([
      BuildingSprite(),
      MCMaleSprite(
        animation: SpriteAnimation.spriteList(
          await Future.wait([1, 2].map(
            (i) => Sprite.load('mc_male_$i.png'),
          )),
          stepTime: 0.2,
        ),
      ),
    ]);
  }
}
