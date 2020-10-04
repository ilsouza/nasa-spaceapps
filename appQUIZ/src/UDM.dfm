object dm: Tdm
  OldCreateOrder = False
  Height = 420
  Width = 848
  object emsConn: TEMSProvider
    ApiVersion = '2'
    URLHost = '192.168.100.7'
    URLPort = 8080
    Left = 64
    Top = 48
  end
  object EMSDataSetResource1: TEMSDataSetResource
    Left = 696
    Top = 56
  end
  object getQuiz: TBackendEndpoint
    Provider = emsConn
    Params = <>
    Resource = 'http://localhost:8080/resQuiz'
    Response = respQuiz
    Left = 296
    Top = 56
  end
  object RESTClient1: TRESTClient
    Params = <>
    Left = 696
    Top = 192
  end
  object RESTRequest1: TRESTRequest
    Client = RESTClient1
    Params = <>
    Response = respQuiz
    Left = 696
    Top = 264
  end
  object respQuiz: TRESTResponse
    ContentType = 'application/json'
    Left = 296
    Top = 120
  end
  object getQuestions: TBackendEndpoint
    Provider = emsConn
    Params = <>
    Resource = 'http://localhost:8080/resQuestions'
    Response = respQuestions
    Left = 384
    Top = 56
  end
  object respQuestions: TRESTResponse
    ContentType = 'application/json'
    Left = 384
    Top = 120
  end
  object postQuizAction: TBackendEndpoint
    Provider = emsConn
    Method = rmPOST
    Params = <>
    Resource = 'http://localhost:8080/resQuizAction'
    Response = respQuizAction
    Left = 504
    Top = 56
  end
  object respQuizAction: TRESTResponse
    ContentType = 'application/json'
    Left = 504
    Top = 120
  end
  object getUsers: TBackendEndpoint
    Provider = emsConn
    Params = <>
    Resource = 'http://localhost:8080/resUsers'
    Response = respUsers
    Left = 64
    Top = 144
  end
  object respUsers: TRESTResponse
    ContentType = 'application/json'
    Left = 64
    Top = 208
  end
  object postUser: TBackendEndpoint
    Provider = emsConn
    Method = rmPOST
    Params = <>
    Resource = 'http://localhost:8080/resUsers'
    Response = respUsers
    Left = 136
    Top = 144
  end
  object dsaQuiz: TRESTResponseDataSetAdapter
    Active = True
    Dataset = mtabQuiz
    FieldDefs = <>
    Response = respQuiz
    Left = 296
    Top = 192
  end
  object mtabQuiz: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'qui_name'
        DataType = ftWideString
        Size = 255
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable, uvAutoCommitUpdates]
    UpdateOptions.LockWait = True
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 296
    Top = 248
    object mtabQuizqui_name: TWideStringField
      FieldName = 'qui_name'
      Size = 255
    end
  end
  object dtsQuiz: TDataSource
    DataSet = mtabQuiz
    Left = 296
    Top = 304
  end
  object dsaQuestions: TRESTResponseDataSetAdapter
    Active = True
    Dataset = mtabQuestions
    FieldDefs = <>
    Response = respQuestions
    Left = 384
    Top = 192
  end
  object mtabQuestions: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'que_description'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'que_01_desc'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'que_02_desc'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'que_03_desc'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'que_04_desc'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'que_ro'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'que_link_yt'
        DataType = ftWideString
        Size = 255
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable, uvAutoCommitUpdates]
    UpdateOptions.LockWait = True
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 384
    Top = 248
    object mtabQuestionsque_description: TWideStringField
      FieldName = 'que_description'
      Size = 255
    end
    object mtabQuestionsque_01_desc: TWideStringField
      FieldName = 'que_01_desc'
      Size = 255
    end
    object mtabQuestionsque_02_desc: TWideStringField
      FieldName = 'que_02_desc'
      Size = 255
    end
    object mtabQuestionsque_03_desc: TWideStringField
      FieldName = 'que_03_desc'
      Size = 255
    end
    object mtabQuestionsque_04_desc: TWideStringField
      FieldName = 'que_04_desc'
      Size = 255
    end
    object mtabQuestionsque_ro: TWideStringField
      FieldName = 'que_ro'
      Size = 255
    end
    object mtabQuestionsque_link_yt: TWideStringField
      FieldName = 'que_link_yt'
      Size = 255
    end
  end
  object dtsQuestions: TDataSource
    DataSet = mtabQuestions
    Left = 384
    Top = 304
  end
end
