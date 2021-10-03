unit Service.Laboratory;

interface

uses
  System.SysUtils, System.Classes, REST.Backend.ServiceTypes, REST.Backend.EMSServices, System.JSON, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, REST.Backend.EndPoint, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, REST.Response.Adapter, FireDAC.Stan.Async, FireDAC.DApt, UDM, UAppSharedUtils;

type
  TsrvServiceLaboratory = class(TDataModule)
    backEndPointLaboratoryItem: TBackendEndpoint;
    rRespLaboratoryItem: TRESTResponse;
    rdsarLaboratoryItem: TRESTResponseDataSetAdapter;
    tblLaboratoryItem: TFDMemTable;
    backEndPointLabs: TBackendEndpoint;
    rRespLabs: TRESTResponse;
    rdsarLabs: TRESTResponseDataSetAdapter;
    tblLabs: TFDMemTable;
    tblLabslab_nid: TIntegerField;
    tblLabslab_cname: TWideStringField;
    tblLabslab_cemail: TWideStringField;
    tblLabslab_cadminid: TWideStringField;
    tblLabslab_cdbhost: TWideStringField;
    tblLabslab_cdbname: TWideStringField;
    tblLabslab_clogin: TWideStringField;
    tblLabslab_cusername: TWideStringField;
    tblLabslab_cdbpassword: TWideStringField;
    tblLabslab_cdbport: TWideStringField;
    tblLabslab_caccessurl: TWideStringField;
    backEndPointLabsGet: TBackendEndpoint;
    rRespLabsGet: TRESTResponse;
    rdsarLabsGet: TRESTResponseDataSetAdapter;
    tblLabsGet: TFDMemTable;
    tblLabsGetlab_nid: TIntegerField;
    tblLabsGetlab_cname: TWideStringField;
    tblLaboratoryItemunit_cname: TWideStringField;
    tblLaboratoryItemunit_ccep: TWideStringField;
    tblLaboratoryItemunit_ccodcity: TWideStringField;
    tblLaboratoryItemunit_ccodcity_1: TWideStringField;
    tblLaboratoryItemunit_nid: TWideStringField;
    tblLaboratoryItemunit_address: TWideStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    FModule : TDM;
  public
    { Public declarations }
  end;

var
  srvServiceLaboratory: TsrvServiceLaboratory;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure TsrvServiceLaboratory.DataModuleCreate(Sender: TObject);
begin
  if (FModule = nil) then
  begin
    FModule := Tdm.Create(nil);
  end;

  TAppSharedUtils.SetProvider(TDataModule(Self), FModule.emsLAPProvider);
end;

procedure TsrvServiceLaboratory.DataModuleDestroy(Sender: TObject);
begin
  FModule.DisposeOf;
end;

end.
