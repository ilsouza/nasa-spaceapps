unit uResUsers;

// EMS Resource Module

interface

uses
  System.SysUtils, System.Classes, System.JSON,
  EMS.Services, EMS.ResourceAPI, EMS.ResourceTypes,
  UDMUSers;

type
  [ResourceName('resUsers')]
  TresUsers = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FModule : TdmUsers;
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

procedure TresUsers.DataModuleCreate(Sender: TObject);
begin
  if (FModule = nil) then
  begin
    FModule := TdmUsers.Create(nil);
  end;
end;

procedure TresUsers.DataModuleDestroy(Sender: TObject);
begin
  if Assigned(FModule) then
  begin
    FModule.DisposeOf;
  end;
end;

//------------------------------------------------------------------------------------------------------------------------------------

procedure TresUsers.Get(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  jObject : TJSONObject;
begin
  jObject := TJSONObject.Create;

  jObject.AddPair('result', 'resUsers');
  AResponse.Body.SetValue(jObject, True)
end;

procedure TresUsers.GetItem(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  sName : string;
  jObject : TJSONObject;
begin
  sName := ARequest.Params.Values['item'];

  jObject := TJSONObject.Create;

  if sName.IsEmpty then
  begin
    jObject.AddPair('result', 'inform user');
    AResponse.Body.SetValue(jObject, True);
    AResponse.StatusCode := 200;
    Exit;
  end;

  FModule.qryUsersGetItem.Close;
  FModule.qryUsersGetItem.ParamByName('name').AsString := sName;
  FModule.qryUsersGetItem.Open;

  if FModule.qryUsersGetItem.IsEmpty then
  begin
    jObject.AddPair('result', 'user name not found');
    AResponse.Body.SetValue(jObject, True);
    AResponse.StatusCode := 200;
    Exit;
  end;

  jObject :=  TJSONObject.Create;

  jObject.AddPair('result', FModule.qryUsersGetItem.FieldByName('usr_name').AsString);
  AResponse.Body.SetValue(jObject, True);
  AResponse.StatusCode := 200;
end;

procedure TresUsers.Post(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  iIndex : Word;
  sName : String;

  jObject, jParametros : TJSONObject;
begin
  if ARequest.Body.TryGetObject(jParametros) then
  begin
    try
      sName := jParametros.GetValue('usr_name').Value;
    except
      sName := '';
    end;
  end;

  jObject := TJSONObject.Create;

  try
    FModule.qryUsersPostItem.Close;
    FModule.qryUsersPostItem.ParamByName('name').AsString   := sName;
    FModule.qryUsersPostItem.ExecSQL;

    jObject.AddPair('result', 'ok');
  except
    jObject.AddPair('Result', 'error');
  end;

  AResponse.Body.SetValue(jObject, True);
  AResponse.StatusCode := 200;
end;

procedure Register;
begin
  RegisterResource(TypeInfo(TresUsers));
end;

initialization
  Register;
end.


