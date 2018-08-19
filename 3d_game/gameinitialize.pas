unit GameInitialize;

interface

implementation

uses CastleWindow, CastleScene, CastleFilesUtils, CastleKeysMouse;

var
  Window: TCastleWindow;
  SoldierScene: TCastleScene;

procedure WindowPress(Container: TUIContainer; const Event: TInputPressRelease);
begin
  if Event.IsKey('1') then
    SoldierScene.PlayAnimation('walk', true)
  else
  if Event.IsKey('2') then
    SoldierScene.PlayAnimation('stand', true)
  else
  if Event.IsKey('3') then
    SoldierScene.PlayAnimation('die', true);
end;

procedure ApplicationInitialize;
begin
  Window.OnPress := @WindowPress;

  SoldierScene := TCastleScene.Create(Application);
  SoldierScene.Load(ApplicationData('character/soldier1.castle-anim-frames'));
  SoldierScene.ProcessEvents := true;
  SoldierScene.PlayAnimation('walk', true);

  Window.SceneManager.Items.Add(SoldierScene);
  Window.SceneManager.MainScene := SoldierScene;
end;

initialization
  Window := TCastleWindow.Create(Application);
  Application.MainWindow := Window;
  Application.OnInitialize := @ApplicationInitialize;
end.
