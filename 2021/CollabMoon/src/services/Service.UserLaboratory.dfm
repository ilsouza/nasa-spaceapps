object srvUserLaboratory: TsrvUserLaboratory
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 615
  Width = 734
  object BackEndpointPostItem: TBackendEndpoint
    Method = rmPOST
    Params = <>
    Resource = 'resUserLaboratory'
    Response = rRespPostItem
    Left = 56
    Top = 30
  end
  object rRespPostItem: TRESTResponse
    Left = 176
    Top = 31
  end
end
