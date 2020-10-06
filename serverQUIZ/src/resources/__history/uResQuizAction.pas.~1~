unit uResQuizAction;

// EMS Resource Module

interface

uses
  System.SysUtils, System.Classes, System.JSON,
  EMS.Services, EMS.ResourceAPI, EMS.ResourceTypes,
  uDMQuizActions;

type
  [ResourceName('resQuizAction')]
  TresQuizAction = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FModule : TdmQuizActions;
  published

    [EndPointRequestSummary('Tests', 'ListItems', 'Retrieves list of items', 'application/json', '')]
    [EndPointResponseDetails(200, 'Ok', TAPIDoc.TPrimitiveType.spObject, TAPIDoc.TPrimitiveFormat.None, '', '')]
    procedure Get(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);

    [EndPointRequestSummary('Tests', 'GetItem', 'Retrieves item with specified ID', 'application/json', '')]
    [EndPointRequestParameter(TAPIDocParameter.TParameterIn.Path, 'item', 'A item ID', true, TAPIDoc.TPrimitiveType.spString,
      TAPIDoc.TPrimitiveFormat.None, TAPIDoc.TPrimitiveType.spString, '', '')]
    [EndPointResponseDetails(200, 'Ok', TAPIDoc.TPrimitiveType.spObject, TAPIDoc.TPrimitiveFormat.None, '', '')]
    [EndPointResponseDetails(404, 'Not Found', TAPIDoc.TPrimitiveType.spNull, TAPIDoc.TPrimitiveFormat.None, '', '')]
    [ResourceSuffix('{item}')]
    procedure GetItem(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);

    [EndPointRequestSummary('Tests', 'PostItem', 'Creates new item', '', 'application/json')]
    [EndPointRequestParameter(TAPIDocParameter.TParameterIn.Body, 'body', 'A new item content', true, TAPIDoc.TPrimitiveType.spObject,
      TAPIDoc.TPrimitiveFormat.None, TAPIDoc.TPrimitiveType.spObject, '', '')]
    [EndPointResponseDetails(200, 'Ok', TAPIDoc.TPrimitiveType.spNull, TAPIDoc.TPrimitiveFormat.None, '', '')]
    [EndPointResponseDetails(409, 'Item Exist', TAPIDoc.TPrimitiveType.spNull, TAPIDoc.TPrimitiveFormat.None, '', '')]
    procedure Post(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
  end;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

procedure TresQuizAction.DataModuleCreate(Sender: TObject);
begin
  if (FModule = nil) then
  begin
    FModule := TdmQuizActions.Create(nil);
  end;
end;

procedure TresQuizAction.DataModuleDestroy(Sender: TObject);
begin
  if Assigned(FModule) then
  begin
    FModule.DisposeOf;
  end;
end;

procedure TresQuizAction.Get(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
begin
  // Sample code
  AResponse.Body.SetValue(TJSONString.Create('resQuizAction'), True)
end;

procedure TresQuizAction.GetItem(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  LItem: string;
begin
  LItem := ARequest.Params.Values['item'];
  // Sample code
  AResponse.Body.SetValue(TJSONString.Create('resQuizAction ' + LItem), True)
end;

procedure TresQuizAction.Post(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  iIndex : Word;
  sIdUser, sIdQuiz, sIdQuestion, sIdAnswer, sIdCorrect  : String;

  i, iTamanhoPacote, iSchdID : Integer;

  jObject, jParametros : TJSONObject;
begin
  jObject := TJSONObject.Create;

  if ARequest.Body.TryGetObject(jParametros) then
  begin
    try
      sIdUser     := jParametros.GetValue('qac_usr').Value;
      sIdQuiz     := jParametros.GetValue('qac_qui_id').Value;
      sIdQuestion := jParametros.GetValue('qac_que_id').Value;
      sIdAnswer   := jParametros.GetValue('qac_answer').Value;
      sIdCorrect  := jParametros.GetValue('qac_correct').Value;
    except
      sIdUser     := '0';
      sIdQuiz     := '';
      sIdQuestion := '';
      sIdAnswer   := '';
      sIdCorrect  := '';
    end;
  end;

  try
    FModule.qryQuizActionPostItem.Close;

    FModule.qryQuizActionPostItem.ParamByName('usr').AsInteger     := sIdUser.ToInteger;
    FModule.qryQuizActionPostItem.ParamByName('qui_id').AsInteger  := sIdQuiz.ToInteger;
    FModule.qryQuizActionPostItem.ParamByName('que_id').AsInteger  := sIdQuestion.ToInteger;
    FModule.qryQuizActionPostItem.ParamByName('answer').AsInteger  := sIdAnswer.ToInteger;
    FModule.qryQuizActionPostItem.ParamByName('correct').AsBoolean := sIdCorrect.ToBoolean;

    FModule.qryQuizActionPostItem.ExecSQL;

    jObject.AddPair('result', 'ok');
  except
    on e : exception do
    begin
      jObject := TJSONObject.Create;
      jObject.AddPair('Result', 'error:' + e.message);
    end;
  end;

  AResponse.Body.SetValue(jObject, True);
  AResponse.StatusCode := 200;
end;

procedure Register;
begin
  RegisterResource(TypeInfo(TresQuizAction));
end;

initialization
  Register;
end.


