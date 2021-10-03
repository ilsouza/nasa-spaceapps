object srv2Laboratory: Tsrv2Laboratory
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 569
  Width = 629
  object BackEndpointPostItem: TBackendEndpoint
    Method = rmPOST
    Params = <>
    Resource = 'resLaboratory'
    Response = rRespPostItem
    Left = 64
    Top = 40
  end
  object rRespPostItem: TRESTResponse
    Left = 184
    Top = 40
  end
  object mTblScheduleRequestDocument: TFDMemTable
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
    Left = 368
    Top = 40
    object mTblScheduleRequestDocumentDocType: TStringField
      FieldName = 'DocType'
      Size = 3
    end
    object mTblScheduleRequestDocumentImageFileName: TStringField
      FieldName = 'ImageFileName'
      Size = 500
    end
    object mTblScheduleRequestDocumentLog_DateTime: TDateTimeField
      FieldName = 'Log_DateTime'
    end
  end
  object connMemory: TFDConnection
    Params.Strings = (
      'DriverID=SQLite')
    LoginPrompt = False
    Left = 512
    Top = 40
  end
  object LSQLMemory: TFDLocalSQL
    Connection = connMemory
    DataSets = <
      item
        DataSet = mTblScheduleRequestDocument
        Name = 'tbScheduleRequestDocument'
      end>
    Left = 512
    Top = 104
  end
  object sqlDeleteDocumentByType: TFDCommand
    Connection = connMemory
    CommandText.Strings = (
      'DELETE '
      '  FROM tbScheduleRequestDocument'
      ' WHERE DocType = :pDocType')
    ParamData = <
      item
        Name = 'PDOCTYPE'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
    Left = 368
    Top = 104
  end
  object qrySelectDocumentByType: TFDQuery
    Connection = connMemory
    SQL.Strings = (
      'SELECT DocType,'
      '       ImageFileName'
      '  FROM tbScheduleRequestDocument'
      ' WHERE DocType = :pDocType'
      ' ORDER BY Log_DateTime')
    Left = 368
    Top = 168
    ParamData = <
      item
        Name = 'PDOCTYPE'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
  end
  object BackEndpointPutItem: TBackendEndpoint
    Method = rmPUT
    Params = <>
    Resource = 'resLaboratory'
    Response = rRespPutItem
    Left = 64
    Top = 162
  end
  object rRespPutItem: TRESTResponse
    Left = 184
    Top = 162
  end
  object BackEndpointPostImage: TBackendEndpoint
    Method = rmPOST
    Params = <>
    Resource = 'resLaboratory'
    Response = rRespPostImage
    Left = 64
    Top = 104
  end
  object rRespPostImage: TRESTResponse
    Left = 184
    Top = 104
  end
  object sqlDeleteDocument: TFDCommand
    Connection = connMemory
    CommandText.Strings = (
      'DELETE '
      '  FROM tbScheduleRequestDocument'
      ' WHERE ImageFileName = :pImageFileName')
    ParamData = <
      item
        Name = 'PIMAGEFILENAME'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
    Left = 368
    Top = 224
  end
end