unit uDMQuestions;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  uDM;

type
  TdmQuestions = class(TDataModule)
    qryQuestionsGetItem: TFDQuery;
    qryQuestionsPostItem: TFDQuery;
    qryQuestionsGet: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    FDM : Tdm;
  public
    { Public declarations }
  end;

var
  dmQuestions: TdmQuestions;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

procedure TdmQuestions.DataModuleCreate(Sender: TObject);
begin
  if (FDM = nil) then
  begin
    FDM := TDM.Create(nil);
  end;

  qryQuestionsGet.Connection      := FDM.conQuiz;
  qryQuestionsGetItem.Connection  := FDM.conQuiz;
  qryQuestionsPostItem.Connection := FDM.conQuiz;
end;

procedure TdmQuestions.DataModuleDestroy(Sender: TObject);
begin
  if Assigned(FDM) then
  begin
    FDM.DisposeOf;
  end;
end;

end.
