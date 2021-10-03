object srvBuscaCEP: TsrvBuscaCEP
  OldCreateOrder = False
  Height = 394
  Width = 580
  object rClientCEP: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'utf-8, *;q=0.8'
    BaseURL = 'https://cep.acredite.se'
    Params = <>
    Left = 56
    Top = 16
  end
  object rReqCEP: TRESTRequest
    Client = rClientCEP
    Params = <>
    Resource = 'cep'
    Response = rRespCEP
    SynchronizedEvents = False
    Left = 56
    Top = 74
  end
  object rRespCEP: TRESTResponse
    ContentType = 'text/html'
    Left = 56
    Top = 130
  end
end
