unit UDM;

interface

uses
  System.SysUtils, System.Classes, REST.Backend.ServiceTypes, System.JSON, REST.Backend.EMSServices,
  REST.Types, REST.Client, Data.Bind.Components, Data.Bind.ObjectScope, REST.Backend.EndPoint,
  EMS.ResourceAPI, EMS.DataSetResource, REST.Backend.EMSProvider, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, REST.Response.Adapter;

type
  Tdm = class(TDataModule)
    emsConn: TEMSProvider;
    EMSDataSetResource1: TEMSDataSetResource;
    getQuiz: TBackendEndpoint;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    respQuiz: TRESTResponse;
    getQuestions: TBackendEndpoint;
    respQuestions: TRESTResponse;
    postQuizAction: TBackendEndpoint;
    respQuizAction: TRESTResponse;
    getUsers: TBackendEndpoint;
    respUsers: TRESTResponse;
    postUser: TBackendEndpoint;
    dsaQuiz: TRESTResponseDataSetAdapter;
    mtabQuiz: TFDMemTable;
    dtsQuiz: TDataSource;
    mtabQuizqui_name: TWideStringField;
    dsaQuestions: TRESTResponseDataSetAdapter;
    mtabQuestions: TFDMemTable;
    dtsQuestions: TDataSource;
    mtabQuestionsque_description: TWideStringField;
    mtabQuestionsque_01_desc: TWideStringField;
    mtabQuestionsque_02_desc: TWideStringField;
    mtabQuestionsque_03_desc: TWideStringField;
    mtabQuestionsque_04_desc: TWideStringField;
    mtabQuestionsque_ro: TWideStringField;
    mtabQuestionsque_link_yt: TWideStringField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dm: Tdm;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

end.
