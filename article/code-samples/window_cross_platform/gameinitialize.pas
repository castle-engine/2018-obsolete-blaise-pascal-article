unit GameInitialize;

interface

implementation

uses CastleWindow;

var
  Window: TCastleWindow;

initialization
  Window := TCastleWindow.Create(Application);
  Application.MainWindow := Window;
end.
