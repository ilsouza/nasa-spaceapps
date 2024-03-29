unit UDM;

interface

uses
  System.SysUtils,
  System.Classes,
  REST.Backend.EMSProvider;
type
  Tdm = class(TDataModule)
    emsLAPProvider: TEMSProvider;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dm: Tdm;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure Tdm.DataModuleCreate(Sender: TObject);
begin
  { Para debugar com o EMSDevServerCommand o Linux, usar as configurações abaixo: }
//  emsLAPProvider.URLBasePath := '';

  {Chamada pelo Apache}
///////////  emsLAPProvider.URLHost     := 'lapp.uniware.com.br';
///////////  emsLAPProvider.URLProtocol := 'https';
///////////  emsLAPProvider.URLPort     := 443;
///////////  emsLAPProvider.URLBasePath := 'ems-server';

  {Chamada pelo ngrok}
  //emsLAPProvider.URLHost     := '156e85a3.ngrok.io';
  //emsLAPProvider.URLProtocol := 'https';
  //emsLAPProvider.URLPort     := 0;
  //emsLAPProvider.URLBasePath := '';

(*
  emsLAPProvider.URLBasePath := AdvIniFile.Read('EMSProvider', 'URLBasePath', '').AsString;
  emsLAPProvider.URLHost     := AdvIniFile.Read('EMSProvider', 'URLHost', 'lapp.uniware.com.br').AsString;
  emsLAPProvider.URLPort     := AdvIniFile.Read('EMSProvider', 'URLPort', 443).AsInteger;
*)
end;

end.
