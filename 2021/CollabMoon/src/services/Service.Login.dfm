object srvServiceLogin: TsrvServiceLogin
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 465
  Width = 553
  PixelsPerInch = 96
  object rRespSendEmail: TRESTResponse
    Left = 224
    Top = 192
  end
  object backEndPointSendEmail: TBackendEndpoint
    Method = rmPOST
    Params = <>
    Resource = 'resSendEmail'
    Response = rRespSendEmail
    AllowHTTPErrors = ClientErrorNotFound_404
    Left = 104
    Top = 192
  end
  object rRespPassword: TRESTResponse
    ContentType = 'application/json'
    Left = 224
    Top = 128
  end
  object backEndPointPassword: TBackendEndpoint
    Method = rmPOST
    Params = <>
    Resource = 'resPassword'
    Response = rRespPassword
    AllowHTTPErrors = ClientErrorNotFound_404
    Left = 104
    Top = 128
  end
  object rRespLogin: TRESTResponse
    ContentType = 'application/json'
    Left = 224
    Top = 64
  end
  object backEndPointLogin: TBackendEndpoint
    Provider = dm.emsLAPProvider
    Method = rmPOST
    Params = <>
    Resource = 'resLogin'
    Response = rRespLogin
    AllowHTTPErrors = ClientErrorNotFound_404
    Left = 104
    Top = 64
  end
  object rRespSendEmailPassword: TRESTResponse
    Left = 280
    Top = 256
  end
  object backEndPointSendEmailPassword: TBackendEndpoint
    Method = rmPOST
    Params = <>
    Resource = 'resSendEmailPassword'
    Response = rRespSendEmailPassword
    AllowHTTPErrors = ClientErrorNotFound_404
    Left = 104
    Top = 256
  end
end