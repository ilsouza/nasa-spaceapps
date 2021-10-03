unit Service.Login;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Threading,
  System.UITypes,
  REST.Backend.ServiceTypes,
  REST.Types,
  System.JSON,
  Data.Bind.Components,
  Data.Bind.ObjectScope,
  REST.Client,
  REST.Backend.EMSServices,
  REST.Backend.EndPoint,
  UDM,
  FMX.Dialogs,
  FMX.DialogService,
  FMX.Consts,
  REST.Backend.EMSProvider;

type
  TsrvServiceLogin = class(TDataModule)
    rRespSendEmail: TRESTResponse;
    backEndPointSendEmail: TBackendEndpoint;
    rRespPassword: TRESTResponse;
    backEndPointPassword: TBackendEndpoint;
    rRespLogin: TRESTResponse;
    backEndPointLogin: TBackendEndpoint;
    rRespSendEmailPassword: TRESTResponse;
    backEndPointSendEmailPassword: TBackendEndpoint;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    FModule : TDM;
  public
    { Public declarations }
    procedure DoLogin(AParametro: TJSONObject);
    procedure ProcessCallback(const AStatusCode: Integer);
  end;

var
  srvServiceLogin: TsrvServiceLogin;

implementation

uses
//  Storage.Chronos,
  FUser.Login, FUser.Password, FUser.Register;

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure TsrvServiceLogin.DataModuleCreate(Sender: TObject);
begin
  FModule := Tdm.Create(nil);
  TAppSharedUtils.SetProvider(TDataModule(Self), FModule.emsLAPProvider);
end;

procedure TsrvServiceLogin.DataModuleDestroy(Sender: TObject);
begin
  FModule.DisposeOf;
end;

procedure TsrvServiceLogin.DoLogin(AParametro: TJSONObject);
var
  jRetorno: TJSONObject;
  LTask: ITask;
  LThread: TThread;
  sLogin: string;
  sUserID: string;
  sUserNickname: string;
begin

  backEndPointLogin.Accept := EMS_APPLICATION_JSON;
  backEndPointLogin.Body.Add(AParametro);

  LTask := TTask.Create(
    procedure()
    var
      LStatusCode: Integer;
    begin
      LStatusCode := HTTP_RESPONSE_UNASSIGNED;
      try
        try
          try
            backEndPointLogin.Execute;
            LStatusCode := rRespLogin.StatusCode;
          except
            LStatusCode := HTTP_RESPONSE_UNASSIGNED;
          end;
        finally
          case LStatusCode of
            HTTP_SUCCESSFUL_REQUEST:
              begin
                jRetorno := TJSONObject.ParseJSONValue(rRespLogin.Content) as TJSONObject;
                try
                  sLogin   := jRetorno.GetValue(RETURN_KEY_LOGIN).Value;
                  if jRetorno.TryGetValue<string>(EMS_VALUE_USER_ID, sUserID) then
                  begin
                    Chronos.SetItem<Integer>(APP_USER_ID, sUserID.ToInteger);
                  end;

                  if jRetorno.TryGetValue<string>(RETURN_VALUE_USER_NICKNAME, sUserNickname) then
                  begin
                    if sUserNickname <> EmptyStr then
                    begin
                      Chronos.SetItem<string>(APP_USER_NICKNAME, sUserNickname);
                    end;
                  end;

                finally
                  jRetorno.DisposeOf;
                end;
              end;

            HTTP_RESPONSE_UNASSIGNED:
              begin
                TThread.Synchronize(
                  LThread,
                  procedure()
                  begin
                    TDialogService.MessageDialog(
                      ERROR_SERVER_NOT_FOUND,
                      TMsgDlgType.mtError,
                      [TMsgDlgBtn.mbOK],
                      TMsgDlgBtn.mbOK,
                      0,
                      procedure(const AResult: TModalResult)
                      begin
                        frmUserLogin.edtEmail.SetFocus;
                      end);
                  end);
              end;
          end;
        end;
      finally
        TAppSharedUtils.HideActivityIndicator;
        TThread.Synchronize(
          LThread,
          procedure()
          begin
           frmUserLogin.ProcessCallback(LStatusCode);
          end);
      end;
    end);

  TAppSharedUtils.ShowActivityIndicator(frmUserLogin);
  LThread := TThread.CurrentThread;
  LTask.Start;
end;

procedure TsrvServiceLogin.ProcessCallback(const AStatusCode: Integer);
begin
  case AStatusCode of
    HTTP_SUCCESSFUL_REQUEST:
      begin
        frmUserPassword.tabCadastro.ActiveTab := frmUserPassword.tab5_CadastrarSenha;
        frmUserPassword.Show;
      end;
    HTTP_ERROR_NOT_FOUND:
      begin
        //
      end;
    HTTP_RESPONSE_UNASSIGNED:
      begin
        //
      end;
  end;
end;


end.