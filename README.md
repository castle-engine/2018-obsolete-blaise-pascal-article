# Example cross-platform 3D game using Castle Game Engine.

Source code and data files (models, textures).

The creation of this game will be described in great detail in the upcoming
article about Castle Game Engine in
[Blaise Pascal Magazine](https://www.blaisepascalmagazine.eu/).

# Compiling

To compile the demo, you will need Castle Game Engine from
https://castle-engine.io/ .
You can download the stable version and install it following
https://castle-engine.io/documentation.php or the instructions in
the _Blaise Pascal Magazine_ article.
You can also use the engine development version from https://github.com/castle-engine/castle-engine/ .

- `3d_game` is our primary demo.
  It uses TCastleWindow and can be compiled also for the mobile platforms (Android, iOS).
  You can compile it using Lazarus (just open the lpi file inside)
  or using Castle Game Engine build tool
  ( https://github.com/castle-engine/castle-engine/wiki/Build-Tool ).

- `3d_game_alternative_using_castlecontrol` is an alternative version of the demo
  in which we use TCastleControl inside a regular Lazarus LCL form.
  You can compile it using Lazarus (just open the lpi file inside).

# Authors

Copyright Michalis Kamburelis.
Code licensed on terms of Apache License 2.0.

The data files (3D models, textures and audio) are based on various assets
from https://opengameart.org/ , and they use various Creative Commons licenses.
See the file 3d_game/data/AUTHORS.txt for details.
