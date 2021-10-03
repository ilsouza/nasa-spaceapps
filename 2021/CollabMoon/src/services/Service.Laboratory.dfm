object srvServiceLaboratory: TsrvServiceLaboratory
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 245
  Width = 618
  object backEndPointLaboratoryItem: TBackendEndpoint
    Provider = dm.emsLAPProvider
    Params = <>
    Resource = 'reslaboratories'
    Response = rRespLaboratoryItem
    Left = 88
    Top = 40
  end
  object rRespLaboratoryItem: TRESTResponse
    ContentType = 'application/json'
    Left = 224
    Top = 40
  end
  object rdsarLaboratoryItem: TRESTResponseDataSetAdapter
    Active = True
    Dataset = tblLaboratoryItem
    FieldDefs = <>
    Response = rRespLaboratoryItem
    Left = 344
    Top = 40
  end
  object tblLaboratoryItem: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'unit_cname'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'unit_ccep'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'unit_ccodcity'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'unit_ccodcity_1'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'unit_address'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'unit_nid'
        DataType = ftWideString
        Size = 255
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 456
    Top = 40
    object tblLaboratoryItemunit_cname: TWideStringField
      FieldName = 'unit_cname'
      Size = 255
    end
    object tblLaboratoryItemunit_ccep: TWideStringField
      FieldName = 'unit_ccep'
      Size = 255
    end
    object tblLaboratoryItemunit_ccodcity: TWideStringField
      FieldName = 'unit_ccodcity'
      Size = 255
    end
    object tblLaboratoryItemunit_ccodcity_1: TWideStringField
      FieldName = 'unit_ccodcity_1'
      Size = 255
    end
    object tblLaboratoryItemunit_nid: TWideStringField
      FieldName = 'unit_nid'
      Size = 255
    end
    object tblLaboratoryItemunit_address: TWideStringField
      FieldName = 'unit_address'
      Size = 255
    end
  end
  object backEndPointLabs: TBackendEndpoint
    Provider = dm.emsLAPProvider
    Method = rmPOST
    Params = <>
    Resource = 'reslaboratories'
    Response = rRespLabs
    Left = 88
    Top = 104
  end
  object rRespLabs: TRESTResponse
    ContentType = 'text/html'
    Left = 224
    Top = 104
  end
  object rdsarLabs: TRESTResponseDataSetAdapter
    Dataset = tblLabs
    FieldDefs = <>
    Response = rRespLabs
    Left = 344
    Top = 104
  end
  object tblLabs: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 456
    Top = 104
    object tblLabslab_nid: TIntegerField
      FieldName = 'lab_nid'
      Origin = 'lab_nid'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object tblLabslab_cname: TWideStringField
      FieldName = 'lab_cname'
      Origin = 'lab_cname'
      Size = 80
    end
    object tblLabslab_cemail: TWideStringField
      FieldName = 'lab_cemail'
      Origin = 'lab_cemail'
      Size = 50
    end
    object tblLabslab_cadminid: TWideStringField
      FieldName = 'lab_cadminid'
      Origin = 'lab_cadminid'
      Size = 5
    end
    object tblLabslab_cdbhost: TWideStringField
      FieldName = 'lab_cdbhost'
      Origin = 'lab_cdbhost'
      Size = 100
    end
    object tblLabslab_cdbname: TWideStringField
      FieldName = 'lab_cdbname'
      Origin = 'lab_cdbname'
      Size = 40
    end
    object tblLabslab_clogin: TWideStringField
      FieldName = 'lab_clogin'
      Origin = 'lab_clogin'
      Size = 30
    end
    object tblLabslab_cusername: TWideStringField
      FieldName = 'lab_cusername'
      Origin = 'lab_cusername'
      Size = 30
    end
    object tblLabslab_cdbpassword: TWideStringField
      FieldName = 'lab_cdbpassword'
      Origin = 'lab_cdbpassword'
      Size = 30
    end
    object tblLabslab_cdbport: TWideStringField
      FieldName = 'lab_cdbport'
      Origin = 'lab_cdbport'
      Size = 4
    end
    object tblLabslab_caccessurl: TWideStringField
      FieldName = 'lab_caccessurl'
      Origin = 'lab_caccessurl'
      Size = 255
    end
  end
  object backEndPointLabsGet: TBackendEndpoint
    Provider = dm.emsLAPProvider
    Params = <>
    Resource = 'reslaboratories'
    Response = rRespLabsGet
    Left = 88
    Top = 168
  end
  object rRespLabsGet: TRESTResponse
    ContentType = 'application/json'
    Left = 224
    Top = 168
  end
  object rdsarLabsGet: TRESTResponseDataSetAdapter
    Active = True
    Dataset = tblLabsGet
    FieldDefs = <>
    Response = rRespLabsGet
    Left = 344
    Top = 168
  end
  object tblLabsGet: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'lab_cname'
        DataType = ftWideString
        Size = 80
      end
      item
        Name = 'lab_nid'
        DataType = ftInteger
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 456
    Top = 168
    object tblLabsGetlab_nid: TIntegerField
      FieldName = 'lab_nid'
      Origin = 'lab_nid'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object tblLabsGetlab_cname: TWideStringField
      FieldName = 'lab_cname'
      Origin = 'lab_cname'
      Size = 80
    end
  end
end