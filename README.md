# (OBSOLETE) Article and example cross-platform 3D game using Castle Game Engine, for Blaise Pascal Magazine 2018 article

This is the article and accompanying source code for the article _"Creating Games Using Castle Game Engine"_ published in 2018 in the [Blaise Pascal Magazine](https://www.blaisepascalmagazine.eu/).

- Subdirectory `article`, more precisely the file `article/cge-article.adoc`, contains the article (in AsciiDoctor markup; GitHub will render it automatically).

- `3d_game` and `3d_game_alternative_using_castlecontrol` contain the full source code (with data files -- models, textures).

This repository, as well as the corresponding article, are obsolete now, as of 2023. The article was nice back in 2018 -- it described the engine capabilities (as of 2018), presented how to develop a simple 3D application.

## Better: Use Castle Game Engine "3D FPS Game"

Instead of this repository, you will have a better starting point if you use the template _"3D FPS game"_ inside the [CGE visual editor](https://castle-engine.io/manual_editor.php).

That new, remade version uses glTF for data (much better format to export from Blender) and designs the level using visual editor.

Just download [the latest Castle Game Engine](https://castle-engine.io/), run the editor, choose _"New Project -> 3D FPS Game"_ as a template and run the project.

## Better: "Bad Chess", 2023 article and source code

Another thing better than this repository is our 2023 article along with accompanying source code for "Blaise Pascal Magazine": [The bad way to play chess: 3D physics fun using Castle Game Engine](https://github.com/castle-engine/bad-chess/).

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
