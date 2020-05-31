# Example cross-platform 3D game using Castle Game Engine

Source code and data files (models, textures).

The creation of this game will be described in great detail in the upcoming
article about Castle Game Engine in
[Blaise Pascal Magazine](https://www.blaisepascalmagazine.eu/).

**This repository is obsolete**.
While the example here still works perfectly, a better (remade) version is now distributed
with the CGE engine, as a template _"3D FPS game"_ inside the [CGE visual editor](https://castle-engine.io/manual_editor.php).
That new, remade version uses glTF for data (much better format to export from Blender)
and designs the level using visual editor.
Just download [the latest Castle Game Engine](https://castle-engine.io/),
run the editor, choose _"New Project -> 3D FPS Game"_ as a template and run the project.

# Compiling

To compile the demo, you will need [Castle Game Engine](https://castle-engine.io/).
You can download the stable version and install it following
[Castle Game Engine documentation](https://castle-engine.io/documentation.php) or the instructions in
the _Blaise Pascal Magazine_ article.
You can also use the [engine development version](https://github.com/castle-engine/castle-engine/).

- `3d_game` is our primary demo.
  It uses `TCastleWindow` class and can be compiled also for the mobile platforms (Android, iOS).

    You can compile it using Lazarus (just open the lpi file inside)
    or using [Castle Game Engine build tool](https://github.com/castle-engine/castle-engine/wiki/Build-Tool).

- `3d_game_alternative_using_castlecontrol` is an alternative version of the demo
  in which we use `TCastleControl` class inside a regular Lazarus LCL form.

    You can compile it using Lazarus (just open the lpi file inside).

Both versions can of course be compiled on "normal" desktop platforms supported
by Castle Game Engine -- Linux, Windows, macOS etc.

# Authors

Copyright Michalis Kamburelis.
Code licensed on terms of Apache License 2.0.

The data files (3D models, textures and audio) are based on various assets
from https://opengameart.org/ , and they use various Creative Commons licenses.
See the file `3d_game/data/AUTHORS.txt` for details.
