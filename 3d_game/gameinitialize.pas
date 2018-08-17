unit GameInitialize;

interface

implementation

uses CastleWindow, CastleScene;

var
  Window: TCastleWindow;

procedure ApplicationInitialize;
var
  Scene: TCastleScene;
begin
  Scene := TCastleScene.Create(Application);
  Scene.Load('data/character/soldier1.castle-anim-frames');

  Window.SceneManager.Items.Add(Scene);
  Window.SceneManager.MainScene := Scene;
end;

initialization
  Window := TCastleWindow.Create(Application);
  Application.MainWindow := Window;
  Application.OnInitialize := @ApplicationInitialize;
end.

