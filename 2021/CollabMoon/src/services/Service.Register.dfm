object srvRegister: TsrvRegister
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 424
  Width = 581
  object BackEndpointRegister: TBackendEndpoint
    Method = rmPOST
    Params = <>
    Resource = 'resRegister'
    Response = rRespRegister
    AllowHTTPErrors = Any
    Left = 64
    Top = 24
  end
  object rRespRegister: TRESTResponse
    Left = 184
    Top = 24
  end
end
