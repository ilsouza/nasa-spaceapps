unit uDMUsers;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, uDM;

type
  TdmUsers = class(TDataModule)
    qryUsersGetItem: TFDQuery;
    qryUsersPostItem: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    FDM : TDM;
  public
    { Public declarations }
  end;

var
  dmUsers: TdmUsers;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

procedure TdmUsers.DataModuleCreate(Sender: TObject);
begin
  if (FDM = nil) then
  begin
    FDM := TDM.Create(nil);
  end;

  qryUsersGetItem.Connection  := FDM.conQuiz;
  qryUsersPostItem.Connection := FDM.conQuiz;
end;

procedure TdmUsers.DataModuleDestroy(Sender: TObject);
begin
  if Assigned(FDM) then
  begin
    FDM.DisposeOf;
  end;
end;

end.
