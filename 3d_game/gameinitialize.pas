{ Example cross-platform 3D game using Castle Game Engine. }
unit GameInitialize;

interface

implementation

uses Classes,
  CastleWindow, CastleScene, CastleFilesUtils, CastleKeysMouse, CastleUtils,
  CastleVectors, CastleCameras, CastleStringUtils, CastleTransform,
  CastleApplicationProperties, CastleLog, CastleTimeUtils, CastleSoundEngine;

var
  Window: TCastleWindow;
  LevelScene: TCastleScene;

type
  TEnemy = class(TCastleTransform)
  public
    SoldierScene: TCastleScene;
    MoveDirection: Integer; //< Always 1 or -1
    Dead: Boolean;
    constructor Create(AOwner: TComponent); override;
    procedure Update(const SecondsPassed: Single; var RemoveMe: TRemoveType); override;
  end;

constructor TEnemy.Create(AOwner: TComponent);
begin
  inherited;

  MoveDirection := -1;

  SoldierScene := TCastleScene.Create(Self);
  { This loads castle-data:/character/soldier1.castle-anim-frames asset.
    We use <warmup_cache> inside data/CastleSettings.xml to make
    sure this asset is in cache, which means that actually the line below is very fast
    (it does not load new files from disk). }
  SoldierScene.URL := 'castle-data:/character/soldier1.castle-anim-frames';
  SoldierScene.ProcessEvents := true;
  SoldierScene.PlayAnimation('walk', true);

  Add(SoldierScene);
end;

procedure TEnemy.Update(const SecondsPassed: Single; var RemoveMe: TRemoveType);
const
  MovingSpeed = 2;
begin
  inherited;

  if Dead then Exit;

  // We modify the Z coordinate, responsible for enemy going forward
  Translation := Translation +
    Vector3(0, 0, MoveDirection * SecondsPassed * MovingSpeed);

  Direction := Vector3(0, 0, MoveDirection);

  // Toggle MoveDirection between 1 and -1
  if Translation.Z > 5 then
    MoveDirection := -1
  else
  if Translation.Z < -5 then
    MoveDirection := 1;
end;

procedure WindowPress(Container: TUIContainer; const Event: TInputPressRelease);
var
  HitEnemy: TEnemy;
begin
  if Event.IsMouseButton(mbLeft) then
  begin
    SoundEngine.Sound(SoundEngine.SoundFromName('shoot_sound'));

    if (Window.SceneManager.MouseRayHit <> nil) and
       (Window.SceneManager.MouseRayHit.Count >= 2) and
       (Window.SceneManager.MouseRayHit[1].Item is TEnemy) then
    begin
      HitEnemy := Window.SceneManager.MouseRayHit[1].Item as TEnemy;
      HitEnemy.SoldierScene.PlayAnimation('die', false);
      HitEnemy.SoldierScene.Pickable := false;
      HitEnemy.SoldierScene.Collides := false;
      HitEnemy.Dead := true;
    end;
  end;

  if Event.IsKey(CtrlM) then
    Window.SceneManager.WalkCamera.MouseLook :=
      not Window.SceneManager.WalkCamera.MouseLook;
end;

procedure ApplicationInitialize;
var
  Enemy: TEnemy;
  I: Integer;
  TimeStart: TProcessTimerResult;
begin
  { This line is needed because CGE default of TCastleTransform.DefaultOrientation
    is now adjusted to what Blender->glTF exporter does.
    See https://github.com/castle-engine/castle-engine/wiki/Upgrading-to-Castle-Game-Engine-7.0 }
  TCastleTransform.DefaultOrientation := otUpYDirectionMinusZ;

  Window.OnPress := @WindowPress;

  Window.Container.LoadSettings('castle-data:/CastleSettings.xml');

  TimeStart := ProcessTimer;

  for I := 0 to 9 do
  begin
    Enemy := TEnemy.Create(Application);
    Enemy.Translation := Vector3(-5 + I * 1.5, 0, RandomFloatRange(-5, 5));
    Window.SceneManager.Items.Add(Enemy);
  end;

  WritelnLog('Loading enemies took %f seconds', [TimeStart.ElapsedTime]);

  LevelScene := TCastleScene.Create(Application);
  LevelScene.Load('castle-data:/level/level-dungeon.x3d');
  LevelScene.Spatial := [ssRendering, ssDynamicCollisions];
  LevelScene.Attributes.PhongShading := true;
  Window.SceneManager.Items.Add(LevelScene);

  Window.SceneManager.MainScene := LevelScene;

  Window.SceneManager.NavigationType := ntWalk;
  Window.SceneManager.WalkCamera.MoveSpeed := 10;
  Window.SceneManager.WalkCamera.SetView(
    Vector3(21.15, 1.71, 10.59), // position
    Vector3(-0.73, 0.00, -0.68), // direction
    Vector3(0.00, 1.00, 0.00), // up (current)
    Vector3(0.00, 1.00, 0.00) // gravity up
  );

  SoundEngine.RepositoryURL := 'castle-data:/audio/index.xml';
  SoundEngine.MusicPlayer.Sound := SoundEngine.SoundFromName('dark_music');
end;

initialization
  Profiler.Enabled := true;

  Window := TCastleWindow.Create(Application);
  Application.MainWindow := Window;
  Application.OnInitialize := @ApplicationInitialize;
end.
