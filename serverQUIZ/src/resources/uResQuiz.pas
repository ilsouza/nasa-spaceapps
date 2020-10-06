unit uResQuiz;

// EMS Resource Module

interface

uses
  System.SysUtils, System.Classes, System.JSON,
  EMS.Services, EMS.ResourceAPI, EMS.ResourceTypes,
  UDMQuiz;

type
  [ResourceName('resQuiz')]
  TresQuiz = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FModule : TdmQuiz;
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

procedure TresQuiz.DataModuleCreate(Sender: TObject);
begin
  if (FModule = nil) then
  begin
    FModule := TdmQuiz.Create(nil);
  end;
end;

procedure TresQuiz.DataModuleDestroy(Sender: TObject);
begin
  if Assigned(FModule) then
  begin
    FModule.DisposeOf;
  end;
end;

procedure TresQuiz.Get(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  jObject : TJSONObject;
begin
  FModule.qryQuizGet.Close;
  FModule.qryQuizGet.Open;
  FModule.qryQuizGet.First;

  jObject := TJSONObject.Create;

  {Inicia a gravação do array "qui_name"}
//  AResponse.Body.JSONWriter.WritePropertyName('quiz_name');
  AResponse.Body.JSONWriter.WriteStartArray;

  while not FModule.qryQuizGet.Eof do
  begin
    AResponse.Body.JSONWriter.WriteStartObject;
      AResponse.Body.JSONWriter.WritePropertyName('qui_name');
      AResponse.Body.JSONWriter.WriteValue(FModule.qryQuizGet.FieldByName('qui_name').AsString);

    try
      AResponse.Body.JSONWriter.WriteEndObject;
    except
    end;

    FModule.qryQuizGet.Next;
  end;

  {Para se evitar a mensagem "No token to close"}
  try
    {Matriz de exams}
    AResponse.Body.JSONWriter.WriteEndArray;
  except
  end;

  AResponse.StatusCode := 200;
end;

procedure TresQuiz.GetItem(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  sId : string;
  jObject : TJSONObject;
begin
  sId     := ARequest.Params.Values['item'];
  jObject := TJSONObject.Create;

  if sid.IsEmpty then
  begin
    AResponse.Body.SetValue(TJSONString.Create('inform quiz id'), True);
    AResponse.StatusCode := 200;
    Exit;
  end;

  FModule.qryQuizGetItem.Close;
  FModule.qryQuizGetItem.ParamByName('id').AsInteger := StrToInt(sId);
  FModule.qryQuizGetItem.Open;

  if FModule.qryQuizGetItem.IsEmpty then
  begin
    jObject.AddPair('result', 'quiz not found');
    AResponse.Body.SetValue(jObject, True);
    AResponse.StatusCode := 200;
    Exit;
  end;

  jObject.AddPair('qui_name', FModule.qryQuizGetItem.FieldByName('qui_name').AsString);
  AResponse.Body.SetValue(jObject, True);
  AResponse.StatusCode := 200;
end;

procedure TresQuiz.Post(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  iIndex : Word;
  sName : String;
  i, iTamanhoPacote, iSchdID : Integer;

  jObject, jParametros : TJSONObject;
begin
  jObject := TJSONObject.Create;

  if ARequest.Body.TryGetObject(jParametros) then
  begin
    try
      sName := jParametros.GetValue('name').Value;
    except
      sName := '';
    end;
  end;

  try
    FModule.qryQuizPostItem.Close;
    FModule.qryQuizPostItem.ParamByName('name').AsString := sName;
    FModule.qryQuizPostItem.ExecSQL;

    jObject.AddPair('result', 'ok');
  except
    jObject := TJSONObject.Create;
    jObject.AddPair('Result', 'error');
  end;

  AResponse.Body.SetValue(jObject, True);
  AResponse.StatusCode := 200;
end;

procedure Register;
begin
  RegisterResource(TypeInfo(TresQuiz));
end;

initialization
  Register;
end.


