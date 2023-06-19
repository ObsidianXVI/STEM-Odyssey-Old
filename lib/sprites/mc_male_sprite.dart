part of stem_odyssey;

class MCMaleSprite extends SpriteAnimationComponent
    with CollisionCallbacks, KeyboardHandler {
  BuildingSprite? buildingSprite;
  final STEMOdyssey game;
  MCMaleSprite({
    required super.animation,
    required this.game,
  }) : super(
          size: Vector2.all(56),
          //position: Vector2(tileSize * 10, tileSize * 10),
        );

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is ScreenHitbox) {
      //...
    } else if (other is BuildingSprite) {
      game.overlays.add('press_e_to_enter');
      timedAction(2, () {
        game.overlays.remove('press_e_to_enter');
      });
      buildingSprite = other;
      position = intersectionPoints.first;
    }
  }

  @override
  Future<void> onLoad() async {
    addAll([
      RectangleHitbox(
        position: position,
        size: size,
        isSolid: true,
      ),
      KeyboardListenerComponent(
        keyUp: {
          LogicalKeyboardKey.keyA: (keysPressed) {
            playing = false;
            return true;
          },
          LogicalKeyboardKey.keyD: (keysPressed) {
            playing = false;
            return true;
          },
          LogicalKeyboardKey.keyW: (keysPressed) {
            playing = false;

            return true;
          },
          LogicalKeyboardKey.keyS: (keysPressed) {
            playing = false;
            return true;
          },
        },
        keyDown: {
          LogicalKeyboardKey.keyE: (keysPressed) {
            if (buildingSprite != null) {
              game.routerComponent.pushNamed('building');
            }
            return true;
          },
          LogicalKeyboardKey.keyX: (keysPressed) {
            if (buildingSprite != null) {
              game.routerComponent.pushNamed('building');
              if (game.routerComponent.currentRoute.name!
                  .startsWith('building')) {
                game.routerComponent.pop();
              }
            }
            return true;
          },
          LogicalKeyboardKey.keyA: (keysPressed) {
            position.add(Vector2(-(tileSize / 2), 0));
            playing = true;
            return true;
          },
          LogicalKeyboardKey.keyD: (keysPressed) {
            position.add(Vector2((tileSize / 2), 0));
            playing = true;
            return true;
          },
          LogicalKeyboardKey.keyW: (keysPressed) {
            position.add(Vector2(0, -(tileSize / 2)));
            playing = true;
            return true;
          },
          LogicalKeyboardKey.keyS: (keysPressed) {
            position.add(Vector2(0, (tileSize / 2)));
            playing = true;
            return true;
          },
        },
      ),
    ]);
  }
}
