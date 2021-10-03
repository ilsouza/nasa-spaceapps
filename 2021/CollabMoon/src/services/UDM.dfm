object dm: Tdm
  OnCreate = DataModuleCreate
  Height = 377
  Width = 440
  PixelsPerInch = 96
  object emsLAPProvider: TEMSProvider
    ApiVersion = '2'
    URLProtocol = 'https'
    URLHost = 'lapp.uniware.com.br'
    URLPort = 443
    URLBasePath = 'ems-server'
    Left = 72
    Top = 40
  end
end
