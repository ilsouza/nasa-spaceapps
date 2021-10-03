unit Service.BuscaCEP;

interface

uses
  System.SysUtils,
  System.Classes,
  System.JSON,
  System.Threading,
  System.StrUtils,
  System.UITypes,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  Data.DB,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  REST.Types,
  REST.Client,
  Data.Bind.Components,
  Data.Bind.ObjectScope,
  FMX.DialogService,
  USharedUtils,
  UAppSharedUtils,
  Classes.Utils.SmartStringBuilder;

type
  TsrvBuscaCEP = class(TDataModule)
    rClientCEP: TRESTClient;
    rReqCEP: TRESTRequest;
    rRespCEP: TRESTResponse;
  private
    { Private declarations }
    procedure ClearAddressData(ADataSet: TFDMemTable);
  public
    { Public declarations }
    procedure GetAddress(const ACEP: string; ADataSet: TFDMemTable);
  end;

var
  srvBuscaCEP: TsrvBuscaCEP;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

uses
  FUser.Profile;

procedure TsrvBuscaCEP.ClearAddressData(ADataSet: TFDMemTable);
begin
  ADataSet.Tag := -1;
  ADataSet.FieldByName('addr_cpostalcode').Clear;
  ADataSet.FieldByName('addr_cpublicplace').Clear;
  ADataSet.FieldByName('addr_cdistrict').Clear;
  ADataSet.FieldByName('addr_ccity').Clear;
  ADataSet.FieldByName('addr_cstate').Clear;
  ADataSet.FieldByName('addr_cibge').Clear;
  ADataSet.Tag := 0;
end;

procedure TsrvBuscaCEP.GetAddress(const ACEP: string; ADataSet: TFDMemTable);
const
  API_CEP_RETURN_TYPE = '\json';

var
  LJSONObject: TJSONObject;
  LJSONResult: TJSONObject;
  LTask: ITask;
  LThread: TThread;
  LPublicPlace: TSmartStringBuilder;
begin
  LTask := TTask.Create(
      procedure()
      begin
        try
          if ACEP <> EmptyStr then
          begin
            rReqCEP.ResourceSuffix := ACEP + API_CEP_RETURN_TYPE;;
            rReqCEP.Execute;
            if rRespCEP.StatusCode = 200 then
            begin
              LJSONObject := (TJSONObject.ParseJSONValue(rRespCEP.JSONText) as TJSONObject);
              try
                if LJSONObject.GetValue('resultType').ToString.DeQuotedString(Chr(34)) = '1' then
                begin
                  LJSONResult := (LJSONObject.GetValue('result') as TJSONObject);

                  LPublicPlace
                    .Builder
                    .Append(LJSONResult.GetValue('tipoLogradouro').ToString.DeQuotedString(Chr(34)))
                    .AppendSpace
                    .Append(LJSONResult.GetValue('logradouro').ToString.DeQuotedString(Chr(34)));

                  {$REGION 'FillAddressData'}
                  ADataSet.FieldByName('addr_cpublicplace').AsString := LPublicPlace.Builder.ToString;
                  ADataSet.FieldByName('addr_cdistrict').AsString    := LJSONResult.GetValue('bairro').ToString.DeQuotedString(Chr(34));
                  ADataSet.FieldByName('addr_ccity').AsString        := LJSONResult.GetValue('localidade').ToString.DeQuotedString(Chr(34));
                  ADataSet.FieldByName('addr_cstate').AsString       := LJSONResult.GetValue('siglaEstado').ToString.DeQuotedString(Chr(34));
                  ADataSet.FieldByName('addr_cibge').AsString        := LeftStr(LJSONResult.GetValue('cibgelocalidade').ToString.DeQuotedString(Chr(34)), 6);
                  {$ENDREGION}
                end
                else
                begin
                  ClearAddressData(ADataSet);
                  TThread.Synchronize(LThread,
                    procedure()
                    begin
                      TDialogService.MessageDialog(
                        'CEP não encontrado.',
                        TMsgDlgType.mtWarning,
                        [TMsgDlgBtn.mbOk],
                        TMsgDlgBtn.mbOk,
                        0,
                        procedure(const AResult: TModalResult)
                        begin
                          TAppSharedUtils.HideActivityIndicator;
                          frmUserProfile.edtTabiAddressPostalCode.SetFocus;
                        end);
                    end);
                end;
              finally
                LJSONObject.DisposeOf;
              end;
            end
            else
            begin
              TThread.Synchronize(LThread,
                procedure()
                begin
                  TDialogService.MessageDialog(
                    'Não foi possível efetuar a consulta de CEP.',
                    TMsgDlgType.mtWarning,
                    [TMsgDlgBtn.mbOk],
                    TMsgDlgBtn.mbOk,
                    0,
                    procedure(const AResult: TModalResult)
                    begin
                      TAppSharedUtils.HideActivityIndicator;
                      frmUserProfile.edtTabiAddressPostalCode.SetFocus;
                    end);
                end);
            end;
          end
          else
          begin
            ClearAddressData(ADataSet);
          end;
        finally
          TAppSharedUtils.HideActivityIndicator;
        end;
      end);

  TAppSharedUtils.ShowActivityIndicator(frmUserProfile);
  LThread := TThread.CurrentThread;
  LTask.Start;
end;

end.
