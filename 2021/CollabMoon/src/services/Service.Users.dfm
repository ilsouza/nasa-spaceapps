object srvUsers: TsrvUsers
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 450
  Width = 630
  object BackEndpointUsers: TBackendEndpoint
    Params = <>
    Resource = 'resUsers'
    Response = rRespUsers
    Left = 80
    Top = 24
  end
  object rRespUsers: TRESTResponse
    ContentType = 'application/json'
    Left = 200
    Top = 24
  end
  object mTblUserProfile: TFDMemTable
    CachedUpdates = True
    OnUpdateRecord = mTblUserProfileUpdateRecord
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 80
    Top = 264
    object mTblUserProfileuser_nid: TIntegerField
      FieldName = 'user_nid'
    end
    object mTblUserProfileuser_cname: TStringField
      FieldName = 'user_cname'
      Size = 150
    end
    object mTblUserProfileuser_cdocnumber: TStringField
      FieldName = 'user_cdocnumber'
      Size = 11
    end
    object mTblUserProfileuser_cphone: TStringField
      FieldName = 'user_cphone'
      Size = 15
    end
    object mTblUserProfileuser_egender: TStringField
      FieldName = 'user_egender'
      Size = 1
    end
    object mTblUserProfileuser_dbirthdate: TDateTimeField
      FieldName = 'user_dbirthdate'
    end
  end
  object BackEndpointGetItem: TBackendEndpoint
    Params = <
      item
        Kind = pkHTTPHEADER
        Name = 'RequestedItem'
        Value = 'Profile'
        ContentType = ctAPPLICATION_JSON
      end>
    Resource = 'resUsers'
    ResourceSuffix = '1'
    Response = rRespGetItem
    AllowHTTPErrors = Any
    Left = 80
    Top = 88
  end
  object rRespGetItem: TRESTResponse
    ContentType = 'application/json'
    Left = 200
    Top = 88
  end
  object BackEndpointPutItem: TBackendEndpoint
    Method = rmPUT
    Params = <>
    Resource = 'resUsers'
    Response = rRespPutItem
    AllowHTTPErrors = Any
    Left = 80
    Top = 206
  end
  object rRespPutItem: TRESTResponse
    Left = 199
    Top = 206
  end
  object BackEndpointPostItem: TBackendEndpoint
    Method = rmPOST
    Params = <>
    Resource = 'resUsers'
    Response = rRespPostItem
    Left = 80
    Top = 150
  end
  object rRespPostItem: TRESTResponse
    Left = 200
    Top = 151
  end
  object mTblUserAddress: TFDMemTable
    FieldDefs = <>
    CachedUpdates = True
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 80
    Top = 320
    object mTblUserAddressaddr_nid: TIntegerField
      FieldName = 'addr_nid'
    end
    object mTblUserAddressuser_nid: TIntegerField
      FieldName = 'user_nid'
    end
    object mTblUserAddressaddr_etype: TStringField
      FieldName = 'addr_etype'
      Size = 10
    end
    object mTblUserAddressaddr_cpublicplace: TStringField
      FieldName = 'addr_cpublicplace'
      Size = 250
    end
    object mTblUserAddressaddr_nnumber: TIntegerField
      FieldName = 'addr_nnumber'
    end
    object mTblUserAddressaddr_cunit: TStringField
      FieldName = 'addr_cunit'
      Size = 40
    end
    object mTblUserAddressaddr_cdistrict: TStringField
      FieldName = 'addr_cdistrict'
      Size = 150
    end
    object mTblUserAddressaddr_ccity: TStringField
      FieldName = 'addr_ccity'
      Size = 150
    end
    object mTblUserAddressaddr_cstate: TStringField
      FieldName = 'addr_cstate'
      Size = 2
    end
    object mTblUserAddressaddr_cpostalcode: TStringField
      FieldName = 'addr_cpostalcode'
    end
    object mTblUserAddressaddr_cibge: TStringField
      FieldName = 'addr_cibge'
      Size = 6
    end
  end
end