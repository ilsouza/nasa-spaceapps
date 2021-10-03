unit Service.UserLaboratory;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Threading,
  System.UITypes,
  FMX.DialogService,
  FireDAC.Comp.Client,
  UDM,
  REST.Backend.ServiceTypes,
  System.JSON,
  REST.Client,
  REST.Types,
  Data.Bind.Components,
  Data.Bind.ObjectScope,
  REST.Backend.EndPoint;

type
  TsrvUserLaboratory = class(TDataModule)
    BackEndpointPostItem: TBackendEndpoint;
    rRespPostItem: TRESTResponse;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    FDM: TDM;
    procedure ResetBackEndpoint(ABackEndpoint: TBackendEndpoint);
  public
    { Public declarations }
    procedure DoPostLabSuggestion(var ADataSet: TFDMemTable);
  end;

const
  EMS_GET_ITEM_PARAM_NAME = 'RequestedItem';
  EMS_POST_ITEM_PARAM_NAME_DATATYPE = 'datatype';
  EMS_POST_ITEM_PARAM_VALUE_SUGGESTION = 'LabSuggestion';
  WARNING_LAB_SUGGESTION_REQUIRED_INFO_NOT_FOUND = 'Por favor, informe os dados completos do laboratório desejado.';
  INFORMATION_LAB_SUGGESTION_ACCEPTED = 'Sugestão enviada com sucesso';

var
  srvUserLaboratory: TsrvUserLaboratory;

implementation

uses
  FUser.Profile,
  UJSONHelper,
  USharedConsts,
  USharedUtils,
  UAppSharedUtils,
  Classes.AdvJSONObjectWriter;

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

{ TsrvUserLaboratory }

procedure TsrvUserLaboratory.DataModuleCreate(Sender: TObject);
begin
  FDM := TDM.Create(nil);
  TAppSharedUtils.SetProvider(TDataModule(Self), FDM.emsLAPProvider);
end;

procedure TsrvUserLaboratory.DataModuleDestroy(Sender: TObject);
begin
  if Assigned(FDM) then
  begin
    FDM.DisposeOf;
  end;
end;

procedure TsrvUserLaboratory.DoPostLabSuggestion(var ADataSet: TFDMemTable);
{$REGION 'Inner methods'}
  function _ValidateData: Boolean;
  begin
    try
      Result :=
        (ADataSet.FieldByName('sugg_cname').AsString <> EmptyStr) and
        (ADataSet.FieldByName('sugg_cphone').AsString <> EmptyStr);
    except
      Result := False;
    end;
  end;
{$ENDREGION}
var
  LTask: ITask;
  LThread: TThread;
  LDataSet: TFDMemTable;
  LAdvJSONObjectWriter: IAdvJSONObjectWriter;
begin
  if _ValidateData then
  begin
    LTask := TTask.Create(
      procedure()
      begin
        ResetBackEndpoint(BackEndpointPostItem);

        BackEndpointPostItem.AllowHTTPErrors := TCustomBackendEndpoint.TAllowHTTPErrors.None;
        BackEndpointPostItem.Accept := EMS_APPLICATION_JSON;

        BackEndpointPostItem.AddParameter(
          EMS_POST_ITEM_PARAM_NAME_DATATYPE,
          EMS_POST_ITEM_PARAM_VALUE_SUGGESTION,
          TRESTRequestParameterKind.pkHTTPHEADER);

        BackEndpointPostItem.Body.Add(LAdvJSONObjectWriter.AsJSONObject);

        try
          BackEndpointPostItem.Execute;
        finally
          if rRespPostItem.StatusCode <> HTTP_SUCCESSFUL_REQUEST then
          begin
            TThread.Synchronize(
              LThread,
              procedure()
              begin
                TDialogService.MessageDialog(
                  ERROR_ON_INSERT_OPERATION,
                  TMsgDlgType.mtError,
                  [TMsgDlgBtn.mbOk],
                  TMsgDlgBtn.mbOk,
                  0,
                  procedure(const AResult: TModalResult)begin
                    TAppSharedUtils.HideActivityIndicator;
                  end);
              end);
          end
          else
          begin
            TThread.Synchronize(
              LThread,
              procedure()
              begin
                LDataSet.Close;
                LDataSet.Open;
                TDialogService.MessageDialog(
                  INFORMATION_LAB_SUGGESTION_ACCEPTED,
                  TMsgDlgType.mtInformation,
                  [TMsgDlgBtn.mbOk],
                  TMsgDlgBtn.mbOk,
                  0,
                  procedure(const AResult: TModalResult)begin
                    TAppSharedUtils.HideActivityIndicator;
                  end);
              end);
          end;
        end;
      end);

    TAppSharedUtils.ShowActivityIndicator(frmUserProfile);
    LThread := TThread.CurrentThread;
    LDataSet := ADataSet;
    LAdvJSONObjectWriter := TAdvJSONObjectWriter.Create;
    LAdvJSONObjectWriter.AddStringPair('sugg_cname', ADataSet.FieldByName('sugg_cname').AsString);
    LAdvJSONObjectWriter.AddStringPair('sugg_cphone', ADataSet.FieldByName('sugg_cphone').AsString);
    LTask.Start;
  end
  else
  begin
    TThread.Synchronize(
      nil,
      procedure()
      begin
        TDialogService.MessageDialog(
          WARNING_LAB_SUGGESTION_REQUIRED_INFO_NOT_FOUND,
          TMsgDlgType.mtWarning,
          [TMsgDlgBtn.mbOk],
          TMsgDlgBtn.mbOk,
          0,
          procedure(const AResult: TModalResult)begin
            frmUserProfile.edtTabiLaboratoryFocusHelper.SetFocus;
          end);
      end);
  end;
end;

procedure TsrvUserLaboratory.ResetBackEndpoint(ABackEndpoint: TBackendEndpoint);
begin
  ABackEndpoint.AllowHTTPErrors := TCustomBackendEndpoint.TAllowHTTPErrors.None;
  ABackEndpoint.Params.Clear;
  ABackEndpoint.ResourceSuffix := EmptyStr;
end;

end.
