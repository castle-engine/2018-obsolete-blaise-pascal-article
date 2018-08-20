unit GameInitialize;

interface

implementation

uses CastleWindow, CastleScene, CastleFilesUtils, CastleKeysMouse,
  CastleVectors, CastleCameras, CastleStringUtils;

var
  Window: TCastleWindow;
  LevelScene, SoldierScene: TCastleScene;

procedure WindowPress(Container: TUIContainer; const Event: TInputPressRelease);
begin
  if Event.IsKey('1') then
    SoldierScene.PlayAnimation('walk', true)
  else
  if Event.IsKey('2') then
    SoldierScene.PlayAnimation('stand', true)
  else
  if Event.IsKey('3') then
    SoldierScene.PlayAnimation('die', true)
  else
  if Event.IsKey(CtrlM) then
    Window.SceneManager.WalkCamera.MouseLook :=
      not Window.SceneManager.WalkCamera.MouseLook;
end;

procedure ApplicationInitialize;
begin
  Window.OnPress := @WindowPress;

  SoldierScene := TCastleScene.Create(Application);
  SoldierScene.Load(ApplicationData('character/soldier1.castle-anim-frames'));
  SoldierScene.ProcessEvents := true;
  SoldierScene.PlayAnimation('walk', true);
  Window.SceneManager.Items.Add(SoldierScene);

  LevelScene := TCastleScene.Create(Application);
  LevelScene.Load(ApplicationData('level/level-dungeon.x3d'));
  LevelScene.Spatial := [ssRendering, ssDynamicCollisions];
  LevelScene.Attributes.PhongShading := true;
  Window.SceneManager.Items.Add(LevelScene);

  Window.SceneManager.MainScene := LevelScene;

  Window.SceneManager.NavigationType := ntWalk;
  Window.SceneManager.WalkCamera.MoveSpeed := 10;
  Window.SceneManager.WalkCamera.SetView(
    Vector3(9.69, 1.72, 8.12), // position
    Vector3(0.87, 0.00, -0.49), // direction
    Vector3(0.00, 1.00, 0.00), // up (current)
    Vector3(0.00, 1.00, 0.00) // gravity up
  );
end;

initialization
  Window := TCastleWindow.Create(Application);
  Application.MainWindow := Window;
  Application.OnInitialize := @ApplicationInitialize;
end.
