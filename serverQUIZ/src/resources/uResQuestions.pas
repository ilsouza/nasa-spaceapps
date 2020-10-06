unit uResQuestions;

// EMS Resource Module

interface

uses
  System.SysUtils, System.Classes, System.JSON,
  EMS.Services, EMS.ResourceAPI, EMS.ResourceTypes,
  uDMQuestions;

type
  [ResourceName('resQuestions')]
  TresQuestions = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FModule : TdmQuestions;
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

procedure TresQuestions.DataModuleCreate(Sender: TObject);
begin
  if (FModule = nil) then
  begin
    FModule := TdmQuestions.Create(nil);
  end;
end;

procedure TresQuestions.DataModuleDestroy(Sender: TObject);
begin
  if Assigned(FModule) then
  begin
    FModule.DisposeOf;
  end;
end;

procedure TresQuestions.Get(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  jObject : TJSONObject;
begin
  FModule.qryQuestionsGet.Close;
  FModule.qryQuestionsGet.Open;
  FModule.qryQuestionsGet.First;

  jObject := TJSONObject.Create;

  {Inicia a gravação do array "qui_name"}
//  AResponse.Body.JSONWriter.WritePropertyName('quiz_name');
  AResponse.Body.JSONWriter.WriteStartArray;

  while not FModule.qryQuestionsGet.Eof do
  begin
    AResponse.Body.JSONWriter.WriteStartObject;
      AResponse.Body.JSONWriter.WritePropertyName('que_description');
      AResponse.Body.JSONWriter.WriteValue(FModule.qryQuestionsGet.FieldByName('que_description').AsString);

      AResponse.Body.JSONWriter.WritePropertyName('que_01_desc');
      AResponse.Body.JSONWriter.WriteValue(FModule.qryQuestionsGet.FieldByName('que_01_desc').AsString);

      AResponse.Body.JSONWriter.WritePropertyName('que_02_desc');
      AResponse.Body.JSONWriter.WriteValue(FModule.qryQuestionsGet.FieldByName('que_02_desc').AsString);

      AResponse.Body.JSONWriter.WritePropertyName('que_03_desc');
      AResponse.Body.JSONWriter.WriteValue(FModule.qryQuestionsGet.FieldByName('que_03_desc').AsString);

      AResponse.Body.JSONWriter.WritePropertyName('que_04_desc');
      AResponse.Body.JSONWriter.WriteValue(FModule.qryQuestionsGet.FieldByName('que_04_desc').AsString);

      AResponse.Body.JSONWriter.WritePropertyName('que_ro');
      AResponse.Body.JSONWriter.WriteValue(FModule.qryQuestionsGet.FieldByName('que_ro').AsString);

      AResponse.Body.JSONWriter.WritePropertyName('que_link_yt');
      AResponse.Body.JSONWriter.WriteValue(FModule.qryQuestionsGet.FieldByName('que_link_yt').AsString);

    try
      AResponse.Body.JSONWriter.WriteEndObject;
    except
    end;

    FModule.qryQuestionsGet.Next;
  end;

  {Para se evitar a mensagem "No token to close"}
  try
    {Matriz de exams}
    AResponse.Body.JSONWriter.WriteEndArray;
  except
  end;

  AResponse.StatusCode := 200;
end;

procedure TresQuestions.GetItem(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  sId : string;
  iIndex : Integer;
  jObject : TJSONObject;
begin
  sId     := ARequest.Params.Values['item'];
  jObject := TJSONObject.Create;

  if sid.IsEmpty then
  begin
    jObject.AddPair('result', 'inform question id');
    AResponse.Body.SetValue(jObject, True);
    AResponse.StatusCode := 200;
    Exit;
  end;

  FModule.qryQuestionsGetItem.Close;
  FModule.qryQuestionsGetItem.ParamByName('id').AsInteger := StrToInt(sId);
  FModule.qryQuestionsGetItem.Open;

  if FModule.qryQuestionsGetItem.IsEmpty then
  begin
    jObject.AddPair('result', 'question id not found');
    AResponse.Body.SetValue(jObject, True);
    AResponse.StatusCode := 200;
    Exit;
  end;

  for iIndex := 0 to FModule.qryQuestionsGetItem.FieldCount-1 do
  begin
    jObject.AddPair(FModule.qryQuestionsGetItem.Fields[iIndex].FieldName,
                    FModule.qryQuestionsGetItem.FieldByName('que_id').AsString);
  end;

  AResponse.Body.SetValue(jObject, True);
  AResponse.StatusCode := 200;
end;

procedure TresQuestions.Post(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  iIndex : Word;
  sDescription, s01_desc, s02_desc, s03_desc,
  s04_desc, sRo, sLink  : String;

  i, iTamanhoPacote, iSchdID : Integer;

  jObject, jParametros : TJSONObject;
begin
  jObject := TJSONObject.Create;

  if ARequest.Body.TryGetObject(jParametros) then
  begin
    try
      sDescription := jParametros.GetValue('que_description').Value;
      s01_desc     := jParametros.GetValue('que_01_desc').Value;
      s02_desc     := jParametros.GetValue('que_02_desc').Value;
      s03_desc     := jParametros.GetValue('que_03_desc').Value;
      s04_desc     := jParametros.GetValue('que_04_desc').Value;
      sRo          := jParametros.GetValue('que_ro').Value;
      sLink        := jParametros.GetValue('que_link').Value;
    except
      sDescription := '';
      s01_desc     := '';
      s02_desc     := '';
      s03_desc     := '';
      s04_desc     := '';
      sRo          := '';
      sLink        := '';
    end;
  end;

  try
    FModule.qryQuestionsPostItem.Close;

    FModule.qryQuestionsPostItem.ParamByName('description').AsString := sDescription;
    FModule.qryQuestionsPostItem.ParamByName('01_desc').AsString     := s01_desc;
    FModule.qryQuestionsPostItem.ParamByName('02_desc').AsString     := s02_desc;
    FModule.qryQuestionsPostItem.ParamByName('03_desc').AsString     := s03_desc;
    FModule.qryQuestionsPostItem.ParamByName('04_desc').AsString     := s04_desc;;
    FModule.qryQuestionsPostItem.ParamByName('ro').AsInteger         := StrToInt(sRo);
    FModule.qryQuestionsPostItem.ParamByName('link').AsString        := sLink;

    FModule.qryQuestionsPostItem.ExecSQL;

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
  RegisterResource(TypeInfo(TresQuestions));
end;

initialization
  Register;
end.


