unit uDMQuiz;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  UDM;

type
  TdmQuiz = class(TDataModule)
    qryQuizGetItem: TFDQuery;
    qryQuizPostItem: TFDQuery;
    qryQuizGet: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    FDM : TDM;
  public
    { Public declarations }
  end;

var
  dmQuiz: TdmQuiz;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

procedure TdmQuiz.DataModuleCreate(Sender: TObject);
begin
  if (FDM = nil) then
  begin
    FDM := TDM.Create(nil);
  end;

  qryQuizGet.Connection      := FDM.conQuiz;
  qryQuizGetItem.Connection  := FDM.conQuiz;
  qryQuizPostItem.Connection := FDM.conQuiz;
end;

procedure TdmQuiz.DataModuleDestroy(Sender: TObject);
begin
  if Assigned(FDM) then
  begin
    FDM.DisposeOf;
  end;
end;

end.
