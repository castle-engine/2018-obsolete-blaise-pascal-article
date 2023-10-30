unit GameInitialize;

interface

implementation

uses CastleWindow, CastleScene;

var
  Window: TCastleWindow;
  SoldierScene: TCastleScene;

procedure ApplicationInitialize;
begin
  SoldierScene := TCastleScene.Create(Application);
  SoldierScene.Load('data/character/soldier1.castle-anim-frames');

  Window.SceneManager.Items.Add(SoldierScene);
  Window.SceneManager.MainScene := SoldierScene;
end;

initialization
  Window := TCastleWindow.Create(Application);
  Application.MainWindow := Window;
  Application.OnInitialize := @ApplicationInitialize;
end.
