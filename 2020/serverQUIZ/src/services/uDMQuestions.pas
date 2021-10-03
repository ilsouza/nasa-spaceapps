unit uDMQuestions;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  uDM;

type
  TdmQuestions = class(TDataModule)
    qryQuestionsUserItem: TFDQuery;
    qryQuestionsPostItem: TFDQuery;
    qryQuestionsUser: TFDQuery;
    qryQuestionsUserqac_id: TIntegerField;
    qryQuestionsUserqac_usr_id: TIntegerField;
    qryQuestionsUserqac_qui_id: TIntegerField;
    qryQuestionsUserqac_que_id: TIntegerField;
    qryQuestionsUserqac_answer: TSmallintField;
    qryQuestionsUserqac_correct: TBooleanField;
    qryQuestionsUserque_id: TIntegerField;
    qryQuestionsUserque_description: TWideStringField;
    qryQuestionsUserque_01_desc: TWideStringField;
    qryQuestionsUserque_02_desc: TWideStringField;
    qryQuestionsUserque_03_desc: TWideStringField;
    qryQuestionsUserque_04_desc: TWideStringField;
    qryQuestionsUserque_ro: TSmallintField;
    qryQuestionsUserque_link_yt: TWideStringField;
    qryQuestionsUserque_qui_id: TIntegerField;
    qryQuestionsQuizItem: TFDQuery;
    qryQuestionsQuizPostItem: TFDQuery;
    qryQuestionsQuiz: TFDQuery;
    qryQuestionsQuizqui_id: TIntegerField;
    qryQuestionsQuizqui_name: TWideStringField;
    qryQuestionsQuizque_id: TIntegerField;
    qryQuestionsQuizque_description: TWideStringField;
    qryQuestionsQuizque_01_desc: TWideStringField;
    qryQuestionsQuizque_02_desc: TWideStringField;
    qryQuestionsQuizque_03_desc: TWideStringField;
    qryQuestionsQuizque_04_desc: TWideStringField;
    qryQuestionsQuizque_ro: TSmallintField;
    qryQuestionsQuizque_link_yt: TWideStringField;
    qryQuestionsQuizque_qui_id: TIntegerField;
    qryQuestionsQuizItemqui_id: TIntegerField;
    qryQuestionsQuizItemqui_name: TWideStringField;
    qryQuestionsQuizItemque_id: TIntegerField;
    qryQuestionsQuizItemque_description: TWideStringField;
    qryQuestionsQuizItemque_01_desc: TWideStringField;
    qryQuestionsQuizItemque_02_desc: TWideStringField;
    qryQuestionsQuizItemque_03_desc: TWideStringField;
    qryQuestionsQuizItemque_04_desc: TWideStringField;
    qryQuestionsQuizItemque_ro: TSmallintField;
    qryQuestionsQuizItemque_link_yt: TWideStringField;
    qryQuestionsQuizItemque_qui_id: TIntegerField;
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

  qryQuestionsUser.Connection     := FDM.conQuiz;
  qryQuestionsUserItem.Connection := FDM.conQuiz;
  qryQuestionsPostItem.Connection := FDM.conQuiz;

  qryQuestionsQuiz.Connection         := FDM.conQuiz;
  qryQuestionsQuizItem.Connection     := FDM.conQuiz;
  qryQuestionsQuizPostItem.Connection := FDM.conQuiz;

  FDM.conQuiz.Open;
end;

procedure TdmQuestions.DataModuleDestroy(Sender: TObject);
begin
  if Assigned(FDM) then
  begin
    FDM.DisposeOf;
  end;
end;

end.
