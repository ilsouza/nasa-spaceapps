unit Interfaces.SimulateTransparency;

interface

uses
  FMX.Types,
  FMX.Graphics;

type
  ISimulateTransparency = interface
    ['{9817708F-B2A6-42E3-BC21-FC5F5BCF3950}']
    procedure SetBlurredBackground(out ABitmap: TBitmap);
  end;

implementation

end.
