unit uResQuestions;

// EMS Resource Module

interface

uses
  System.SysUtils, System.Classes, System.JSON,
  EMS.Services, EMS.ResourceAPI, EMS.ResourceTypes,
  uDMQuestions;

  {
    -- Perguntas que o ID 1 respondeu
    select action.*, questions.* from quiz_action action
      left join questions
      on questions.que_id = action.qac_que_id
    where action.qac_qui_id = 1
    /resquestions/users/
    /resquestions/users/1

    -- Perguntas que pertencem a determinado questionário
    select quiz.*, questions.* from questions
      left join quiz
      on questions.que_qui_id = quiz.qui_id
    /resquestions/quiz/
    /resquestions/quiz/1
  }

type
  TresQuestionsUser = class(TComponent, IEMSEndPointPublisher)
  private
    class constructor Create;
    class destructor Destroy;
  published
    [EndPointRequestSummary('Question User', 'ListItems', 'Retrieves list of items', 'application/json', '')]
    [EndPointResponseDetails(200, 'Ok', TAPIDoc.TPrimitiveType.spObject, TAPIDoc.TPrimitiveFormat.None, '', '')]
    procedure Get(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse); overload;

    [EndPointRequestSummary('Question User', 'GetItem', 'Retrieves item with specified ID', 'application/json', '')]
    [EndPointRequestParameter(TAPIDocParameter.TParameterIn.Path, 'item', 'A item ID', true, TAPIDoc.TPrimitiveType.spString,
      TAPIDoc.TPrimitiveFormat.None, TAPIDoc.TPrimitiveType.spString, '', '')]
    [EndPointResponseDetails(200, 'Ok', TAPIDoc.TPrimitiveType.spObject, TAPIDoc.TPrimitiveFormat.None, '', '')]
    [EndPointResponseDetails(404, 'Not Found', TAPIDoc.TPrimitiveType.spNull, TAPIDoc.TPrimitiveFormat.None, '', '')]
    [ResourceSuffix('./{item}')]
    procedure GetItem(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse); overload;

    [EndPointRequestSummary('Question User', 'PostItem', 'Creates new item', '', 'application/json')]
    [EndPointRequestParameter(TAPIDocParameter.TParameterIn.Body, 'body', 'A new item content', true, TAPIDoc.TPrimitiveType.spObject,
      TAPIDoc.TPrimitiveFormat.None, TAPIDoc.TPrimitiveType.spObject, '', '')]
    [EndPointResponseDetails(200, 'Ok', TAPIDoc.TPrimitiveType.spNull, TAPIDoc.TPrimitiveFormat.None, '', '')]
    [EndPointResponseDetails(409, 'Item Exist', TAPIDoc.TPrimitiveType.spNull, TAPIDoc.TPrimitiveFormat.None, '', '')]
    procedure Post(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
  end;


  TresQuestionsQuiz = class(TComponent, IEMSEndPointPublisher)
  private
    class constructor Create;
    class destructor Destroy;
  published

    [EndPointRequestSummary('Question Quiz', 'ListItems', 'Retrieves list of items', 'application/json', '')]
    [EndPointResponseDetails(200, 'Ok', TAPIDoc.TPrimitiveType.spObject, TAPIDoc.TPrimitiveFormat.None, '', '')]
    procedure Get(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse); overload;

    [EndPointRequestSummary('Question Quiz', 'GetItem', 'Retrieves item with specified ID', 'application/json', '')]
    [EndPointRequestParameter(TAPIDocParameter.TParameterIn.Path, 'item', 'A item ID', true, TAPIDoc.TPrimitiveType.spString,
      TAPIDoc.TPrimitiveFormat.None, TAPIDoc.TPrimitiveType.spString, '', '')]
    [EndPointResponseDetails(200, 'Ok', TAPIDoc.TPrimitiveType.spObject, TAPIDoc.TPrimitiveFormat.None, '', '')]
    [EndPointResponseDetails(404, 'Not Found', TAPIDoc.TPrimitiveType.spNull, TAPIDoc.TPrimitiveFormat.None, '', '')]
    [ResourceSuffix('./{item}')]
    procedure GetItem(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse); overload;

    [EndPointRequestSummary('Question Quiz', 'PostItem', 'Creates new item', '', 'application/json')]
    [EndPointRequestParameter(TAPIDocParameter.TParameterIn.Body, 'body', 'A new item content', true, TAPIDoc.TPrimitiveType.spObject,
      TAPIDoc.TPrimitiveFormat.None, TAPIDoc.TPrimitiveType.spObject, '', '')]
    [EndPointResponseDetails(200, 'Ok', TAPIDoc.TPrimitiveType.spNull, TAPIDoc.TPrimitiveFormat.None, '', '')]
    [EndPointResponseDetails(409, 'Item Exist', TAPIDoc.TPrimitiveType.spNull, TAPIDoc.TPrimitiveFormat.None, '', '')]
    procedure Post(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
  end;


  [ResourceName('resQuestions')]
  TresQuestions = class(TDataModule)
  public
    users : TresQuestionsUser;
    quiz  : TresQuestionsQuiz;
    constructor Create(AOwner : TComponent); override;
  end;

var
  FModule : TdmQuestions;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TresQuestionsQuiz }

procedure TresQuestionsUser.Get(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
begin
  FModule.qryQuestionsUser.Close;
  FModule.qryQuestionsUser.Open;
  FModule.qryQuestionsUser.First;

  {Inicia a gravação do array "qui_name"}
//  AResponse.Body.JSONWriter.WritePropertyName('quiz_name');
  AResponse.Body.JSONWriter.WriteStartArray;

  while not FModule.qryQuestionsUser.Eof do
  begin
    AResponse.Body.JSONWriter.WriteStartObject;
      AResponse.Body.JSONWriter.WritePropertyName('qui_id');
      AResponse.Body.JSONWriter.WriteValue(FModule.qryQuestionsUserqac_qui_id.AsString);

      AResponse.Body.JSONWriter.WritePropertyName('desc_01');
      AResponse.Body.JSONWriter.WriteValue(FModule.qryQuestionsUserque_01_desc.AsString);

      AResponse.Body.JSONWriter.WritePropertyName('desc_02');
      AResponse.Body.JSONWriter.WriteValue(FModule.qryQuestionsUserque_02_desc.AsString);

      AResponse.Body.JSONWriter.WritePropertyName('desc_03');
      AResponse.Body.JSONWriter.WriteValue(FModule.qryQuestionsUserque_03_desc.AsString);

    try
      AResponse.Body.JSONWriter.WriteEndObject;
    except
    end;

    FModule.qryQuestionsUser.Next;
  end;

  {Para se evitar a mensagem "No token to close"}
  try
    {Matriz de exams}
    AResponse.Body.JSONWriter.WriteEndArray;
  except
  end;

  AResponse.StatusCode := 200;
end;

procedure TresQuestionsUser.GetItem(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  sId : string;
  iIndex : Integer;
  jObject : TJSONObject;
begin
  sId     := ARequest.Params.Values['item'];
  jObject := TJSONObject.Create;

  if sid.IsEmpty then
  begin
    jObject.AddPair('result', 'inform user id');
    AResponse.Body.SetValue(jObject, True);
    AResponse.StatusCode := 200;
    Exit;
  end;

  FModule.qryQuestionsUserItem.Close;
  FModule.qryQuestionsUserItem.ParamByName('user').AsInteger := StrToInt(sId);
  FModule.qryQuestionsUserItem.Open;

  if FModule.qryQuestionsUserItem.IsEmpty then
  begin
    jObject.AddPair('result', 'question id not found');
    AResponse.Body.SetValue(jObject, True);
    AResponse.StatusCode := 200;
    Exit;
  end;

  for iIndex := 0 to FModule.qryQuestionsUserItem.FieldCount-1 do
  begin
    jObject.AddPair(FModule.qryQuestionsUserItem.Fields[iIndex].FieldName,
                    FModule.qryQuestionsUserItem.Fields[iIndex].AsString);
  end;

  AResponse.Body.SetValue(jObject, True);
  AResponse.StatusCode := 200;
end;

procedure TresQuestionsUser.Post(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
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

class constructor TresQuestionsUser.Create;
begin
  if (FModule = nil) then
  begin
    FModule := TdmQuestions.Create(nil);
  end;
end;

class destructor TresQuestionsUser.Destroy;
begin
  if Assigned(FModule) then
  begin
    FModule.DisposeOf;
  end;
end;

{ TresQuestionsQuiz }

class constructor TresQuestionsQuiz.Create;
begin
(*
  if (FModule = nil) then
  begin
    FModule := TdmQuestions.Create(nil);
  end;
*)
end;

class destructor TresQuestionsQuiz.Destroy;
begin
(*
  if Assigned(FModule) then
  begin
    FModule.DisposeOf;
  end;
*)
end;

procedure TresQuestionsQuiz.Get(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
begin
  FModule.qryQuestionsQuiz.Close;
  FModule.qryQuestionsQuiz.Open;
  FModule.qryQuestionsQuiz.First;

  {Inicia a gravação do array "qui_name"}
//  AResponse.Body.JSONWriter.WritePropertyName('quiz_name');
  AResponse.Body.JSONWriter.WriteStartArray;

  while not FModule.qryQuestionsQuiz.Eof do
  begin
    AResponse.Body.JSONWriter.WriteStartObject;
      AResponse.Body.JSONWriter.WritePropertyName('qui_id');
      AResponse.Body.JSONWriter.WriteValue(FModule.qryQuestionsQuizque_id.AsString);

      AResponse.Body.JSONWriter.WritePropertyName('que_01_desc');
      AResponse.Body.JSONWriter.WriteValue(FModule.qryQuestionsQuizItemque_01_desc.AsString);

      AResponse.Body.JSONWriter.WritePropertyName('que_02_desc');
      AResponse.Body.JSONWriter.WriteValue(FModule.qryQuestionsQuizItemque_02_desc.AsString);

      AResponse.Body.JSONWriter.WritePropertyName('que_03_desc');
      AResponse.Body.JSONWriter.WriteValue(FModule.qryQuestionsQuizItemque_03_desc.AsString);

      AResponse.Body.JSONWriter.WritePropertyName('que_04_desc');
      AResponse.Body.JSONWriter.WriteValue(FModule.qryQuestionsQuizItemque_04_desc.AsString);

      AResponse.Body.JSONWriter.WritePropertyName('qui_id');
      AResponse.Body.JSONWriter.WriteValue(FModule.qryQuestionsQuizItemqui_id.AsString);

      AResponse.Body.JSONWriter.WritePropertyName('qui_name');
      AResponse.Body.JSONWriter.WriteValue(FModule.qryQuestionsQuizItemqui_name.AsString);

    try
      AResponse.Body.JSONWriter.WriteEndObject;
    except
    end;

    FModule.qryQuestionsQuiz.Next;
  end;

  {Para se evitar a mensagem "No token to close"}
  try
    {Matriz de exams}
    AResponse.Body.JSONWriter.WriteEndArray;
  except
  end;

  AResponse.StatusCode := 200;
end;

procedure TresQuestionsQuiz.GetItem(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  sId : string;
  iIndex : Integer;
  jObject : TJSONObject;
begin
  sId     := ARequest.Params.Values['item'];
  jObject := TJSONObject.Create;

  if sid.IsEmpty then
  begin
    jObject.AddPair('result', 'inform user id');
    AResponse.Body.SetValue(jObject, True);
    AResponse.StatusCode := 200;
    Exit;
  end;

  FModule.qryQuestionsQuizItem.Close;
  FModule.qryQuestionsQuizItem.ParamByName('id').AsInteger := StrToInt(sId);
  FModule.qryQuestionsQuizItem.Open;

  if FModule.qryQuestionsQuizItem.IsEmpty then
  begin
    jObject.AddPair('result', 'question id not found');
    AResponse.Body.SetValue(jObject, True);
    AResponse.StatusCode := 200;
    Exit;
  end;

  for iIndex := 0 to FModule.qryQuestionsQuizItem.FieldCount-1 do
  begin
    jObject.AddPair(FModule.qryQuestionsQuizItem.Fields[iIndex].FieldName,
                    FModule.qryQuestionsQuizItem.Fields[iIndex].AsString);
  end;

  AResponse.Body.SetValue(jObject, True);
  AResponse.StatusCode := 200;
end;

procedure TresQuestionsQuiz.Post(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
begin
  AResponse.Body.SetValue(TJSONString.Create('resQuestionQuiz POST'), True)
end;

{ TresQuestions }

constructor TresQuestions.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  if (FModule = nil) then
  begin
    FModule := TdmQuestions.Create(nil);
  end;

  users := TresQuestionsUser.Create(Self);
  quiz  := TresQuestionsQuiz.Create(Self);
end;

procedure Register;
begin
  RegisterResource(TypeInfo(TresQuestions));
end;

initialization
  Register;
end.
