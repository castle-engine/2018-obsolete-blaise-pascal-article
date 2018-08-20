unit GameInitialize;

interface

implementation

uses Classes,
  CastleWindow, CastleScene, CastleFilesUtils, CastleKeysMouse,
  CastleVectors, CastleCameras, CastleStringUtils, CastleTransform;

var
  Window: TCastleWindow;
  LevelScene: TCastleScene;

type
  TEnemy = class(TCastleTransform)
  public
    SoldierScene: TCastleScene;
    MoveDirection: Integer; //< Always 1 or -1
    constructor Create(AOwner: TComponent); override;
    procedure Update(const SecondsPassed: Single; var RemoveMe: TRemoveType); override;
  end;

constructor TEnemy.Create(AOwner: TComponent);
begin
  inherited;

  MoveDirection := -1;

  SoldierScene := TCastleScene.Create(Application);
  SoldierScene.Load(ApplicationData('character/soldier1.castle-anim-frames'));
  SoldierScene.ProcessEvents := true;
  SoldierScene.PlayAnimation('walk', true);

  Add(SoldierScene);
end;

procedure TEnemy.Update(const SecondsPassed: Single; var RemoveMe: TRemoveType);
const
  MovingSpeed = 2;
begin
  inherited;

  // We modify the Z coordinate, responsible for enemy going forward
  Translation := Translation +
    Vector3(0, 0, MoveDirection * SecondsPassed * MovingSpeed);

  // Toggle MoveDirection between 1 and -1
  if Translation.Z > 5 then
    MoveDirection := -1
  else
  if Translation.Z < -5 then
    MoveDirection := 1;
end;

procedure WindowPress(Container: TUIContainer; const Event: TInputPressRelease);
begin
  if Event.IsKey(CtrlM) then
    Window.SceneManager.WalkCamera.MouseLook :=
      not Window.SceneManager.WalkCamera.MouseLook;
end;

procedure ApplicationInitialize;
var
  Enemy: TEnemy;
begin
  Window.OnPress := @WindowPress;

  Enemy := TEnemy.Create(Application);
  Window.SceneManager.Items.Add(Enemy);

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
