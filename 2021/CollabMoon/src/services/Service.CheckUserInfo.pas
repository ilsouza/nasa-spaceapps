unit Service.CheckUserInfo;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Threading,
  System.JSON,
  System.UITypes,
  REST.Backend.ServiceTypes,
  REST.Types,
  Data.Bind.Components,
  Data.Bind.ObjectScope,
  REST.Client,
  REST.Backend.EndPoint,
  UDM,
  USharedConsts,
  UAppSharedUtils,
  UAppSharedTypes,
  Storage.Chronos,
  FMX.DialogService;

type
  TsrvCheckUserInfo = class(TDataModule)
    BackEndpointCheckUserInfo: TBackendEndpoint;
    rRespCheckUserInfo: TRESTResponse;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    FDM: TDM;
    procedure ResetBackEndpoint(ABackEndpoint: TBackendEndpoint);
  public
    { Public declarations }
    procedure DoCheckUserInfo(ASampleCollectionType: TSampleCollectionType);
    function DoCheckLabUnit : Integer;
  end;

var
  srvCheckUserInfo: TsrvCheckUserInfo;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

uses
  FLaboratory.Menu;

procedure TsrvCheckUserInfo.DataModuleCreate(Sender: TObject);
begin
  if (FDM = nil) then
  begin
    FDM := TDM.Create(nil);
  end;

  TAppSharedUtils.SetProvider(TDataModule(Self), FDM.emsLAPProvider);
end;

procedure TsrvCheckUserInfo.DataModuleDestroy(Sender: TObject);
begin
  if Assigned(FDM) then
  begin
    FDM.DisposeOf;
  end;
end;

function TsrvCheckUserInfo.DoCheckLabUnit : Integer;
var
  iLabCode : Integer;
begin
  if Chronos.TryGetItem<integer>(APP_LAB_ID, iLabCode) then
  begin
    Result := iLabCode;
  end
    else
    begin
      Result := -1;
    end;
end;

procedure TsrvCheckUserInfo.DoCheckUserInfo(ASampleCollectionType: TSampleCollectionType);
var
  LTask: ITask;
  LJSONResponse: TJSONObject;
  LSampleCollectionType: TSampleCollectionType;
  LUserProfileOk: Boolean;
  LUserAddressOk: Boolean;
  LUserInfoStatus: TUserInfoStatus;
begin
  LTask := TTask.Create(
    procedure()
    var
      LUserID: Integer;
    begin
      ResetBackEndpoint(BackEndpointCheckUserInfo);

      LUserID := Chronos.GetItem<Integer>(APP_USER_ID);

      BackEndpointCheckUserInfo.AllowHTTPErrors := TCustomBackendEndpoint.TAllowHTTPErrors.Any;
      BackEndpointCheckUserInfo.ResourceSuffix := LUserID.ToString;

      try
        BackEndpointCheckUserInfo.Execute;
      finally
        if rRespCheckUserInfo.StatusCode = HTTP_SUCCESSFUL_REQUEST then
        begin
          LUserInfoStatus := TUserInfoStatus.uiUnassigned;
                
          LJSONResponse := TJSONObject.ParseJSONValue(rRespCheckUserInfo.JSONText) as TJSONObject;
          try
            LUserProfileOk := StrToBool(LJSONResponse.GetValue('UserProfileOk').ToString);
            LUserAddressOk := StrToBool(LJSONResponse.GetValue('UserAddressOk').ToString);

            if LUserProfileOk and LUserAddressOk then
            begin
              LUserInfoStatus := TUserInfoStatus.uiInfoOk;
            end
            else
            begin
              if not LUserProfileOk then
              begin
                LUserInfoStatus := TUserInfoStatus.uiUserProfileMissing;
              end
              else
              begin
                LUserInfoStatus := TUserInfoStatus.uiUserAddressMissing;
              end;
            end;
          finally
            LJSONResponse.DisposeOf;            
            TAppSharedUtils.HideActivityIndicator;
            TThread.Synchronize(
              TThread.CurrentThread,
              procedure()
              begin
                frmLaboratoryMenu.DoCallScheduleRequest(LSampleCollectionType, LUserInfoStatus);
              end);
          end;          
        end
        else
        begin
          TThread.Synchronize(
            TThread.CurrentThread,
            procedure()
            begin
              TDialogService.ShowMessage(ERROR_SERVER_NOT_FOUND);
              TAppSharedUtils.HideActivityIndicator;
            end);
        end;
      end;
    end);

  LSampleCollectionType := ASampleCollectionType;
  TAppSharedUtils.ShowActivityIndicator(frmLaboratoryMenu);
  LTask.Start;

end;

procedure TsrvCheckUserInfo.ResetBackEndpoint(ABackEndpoint: TBackendEndpoint);
begin
  ABackEndpoint.AllowHTTPErrors := TCustomBackendEndpoint.TAllowHTTPErrors.None;
  ABackEndpoint.Params.Clear;
  ABackEndpoint.ResourceSuffix := EmptyStr;
  ABackEndpoint.Accept := EmptyStr;
end;

end.
