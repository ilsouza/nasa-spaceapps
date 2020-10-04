unit uDMQuizAction;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TdmQuizActions = class(TDataModule)
    qryQuizActionGetItem: TFDQuery;
    qryQuizActionPostItem: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmQuizActions: TdmQuizActions;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

uses uDM;

{$R *.dfm}

end.