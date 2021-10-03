object srvCheckUserInfo: TsrvCheckUserInfo
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 246
  Width = 310
  object BackEndpointCheckUserInfo: TBackendEndpoint
    Params = <>
    Resource = 'resCheckUserInfo'
    Response = rRespCheckUserInfo
    Left = 80
    Top = 24
  end
  object rRespCheckUserInfo: TRESTResponse
    Left = 216
    Top = 24
  end
end
