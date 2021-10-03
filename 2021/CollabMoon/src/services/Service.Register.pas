unit Service.Register;

interface

uses
  System.SysUtils,
  System.StrUtils,
  System.Classes,
  System.Threading,
  System.JSON,
  System.UITypes,
  USharedConsts,
  UAppSharedUtils,
  REST.Backend.ServiceTypes,
  REST.Client,
  Data.Bind.Components,
  Data.Bind.ObjectScope,
  REST.Backend.EndPoint,
  UDM,
  FMX.Dialogs,
  FMX.DialogService;

type
  TsrvRegister = class(TDataModule)
    BackEndpointRegister: TBackendEndpoint;
    rRespRegister: TRESTResponse;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    FDM: TDM;
  public
    { Public declarations }
    procedure RegisterUser;
  end;

var
  srvRegister: TsrvRegister;

implementation

uses
  Storage.Chronos,
  FUser.Register;

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

{ TsrvRegister }

procedure TsrvRegister.DataModuleCreate(Sender: TObject);
begin
  FDM := TDM.Create(nil);
  TAppSharedUtils.SetProvider(TDataModule(Self), FDM.emsLAPProvider);
end;

procedure TsrvRegister.DataModuleDestroy(Sender: TObject);
begin
  if Assigned(FDM) then
  begin
    FDM.DisposeOf;
  end;
end;

procedure TsrvRegister.RegisterUser;
var
  LJSONObject: TJSONObject;
  LJSONResponse: TJSONObject;
  LTask: ITask;
  LThread: TThread;
  LUserID: Integer;
begin
  LJSONObject := TJSONObject.Create;

  LJSONObject.AddPair('Email', Chronos.GetItem<string>(APP_USER_EMAIL));
  LJSONObject.AddPair('Nickname', Chronos.GetItem<string>(APP_USER_NICKNAME));
  LJSONObject.AddPair('Password', Chronos.GetItem<string>(APP_USER_PASSWORD));
  LJSONObject.AddPair('Type', Chronos.GetItem<string>(APP_USER_TYPE));

  LTask := TTask.Create(
    procedure()
    begin
      BackEndpointRegister.Body.Add(LJSONObject);

      try
        BackEndpointRegister.Execute;
      finally
        if rRespRegister.StatusCode <> HTTP_SUCCESSFUL_REQUEST then
        begin
          TThread.Synchronize(
            LThread,
            procedure ()
            begin
              TDialogService.MessageDialog(
                HTTP_ERROR_MESSAGE_INTERNAL_SERVER_ERROR,
                TMsgDlgType.mtError,
                [TMsgDlgBtn.mbOk],
                TMsgDlgBtn.mbOK,
                0,
                procedure(const AResult: TModalResult)
                begin
                  TAppSharedUtils.HideActivityIndicator;
                end);
            end);
        end
        else
        begin
          LJSONResponse := TJSONObject.ParseJSONValue(rRespRegister.JSONText) as TJSONObject;
          try
            TryStrToInt(LJSONResponse.GetValue('UserID').Value, LUserID);
            Chronos.SetItem<Integer>(APP_USER_ID, LUserID);
          finally
            LJSONResponse.DisposeOf;
          end;
          TAppSharedUtils.HideActivityIndicator;
          frmUserRegister.tabCadastro.ActiveTab := frmUserRegister.tab6_Parabens;
        end;
      end;
    end);

  TAppSharedUtils.ShowActivityIndicator(frmUserRegister);
  LThread := TThread.CurrentThread;
  LTask.Start;
end;

end.
