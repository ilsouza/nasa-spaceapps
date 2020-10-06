unit uDMQuizActions;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  UDM;

type
  TdmQuizActions = class(TDataModule)
    qryQuizActionGetItem: TFDQuery;
    qryQuizActionPostItem: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    FDM : Tdm;
  public
    { Public declarations }
  end;

var
  dmQuizActions: TdmQuizActions;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

procedure TdmQuizActions.DataModuleCreate(Sender: TObject);
begin
  if (FDM = nil) then
  begin
    FDM := Tdm.Create(nil);
  end;

  qryQuizActionGetItem.Connection  := FDM.conQuiz;
  qryQuizActionPostItem.Connection := FDM.conQuiz;
end;

procedure TdmQuizActions.DataModuleDestroy(Sender: TObject);
begin
  if Assigned(FDM) then
  begin
    FDM.DisposeOf;
  end;
end;

end.
