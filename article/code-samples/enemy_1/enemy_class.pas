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

  SoldierScene := TCastleScene.Create(Self);
  SoldierScene.Load(ApplicationData('character/soldier1.castle-anim-frames'));
  SoldierScene.ProcessEvents := true;
  SoldierScene.PlayAnimation('walk', paForceLooping);

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
