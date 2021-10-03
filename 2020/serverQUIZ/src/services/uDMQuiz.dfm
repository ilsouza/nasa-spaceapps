object dmQuiz: TdmQuiz
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 363
  Width = 420
  object qryQuizGetItem: TFDQuery
    SQL.Strings = (
      'select qui_name from quiz where qui_id = :id')
    Left = 112
    Top = 56
    ParamData = <
      item
        Name = 'ID'
        ParamType = ptInput
      end>
  end
  object qryQuizPostItem: TFDQuery
    SQL.Strings = (
      'insert into quiz (qui_name) values (:name)')
    Left = 104
    Top = 128
    ParamData = <
      item
        Name = 'NAME'
        ParamType = ptInput
      end>
  end
  object qryQuizGet: TFDQuery
    Connection = dm.conQuiz
    SQL.Strings = (
      'select * from questions')
    Left = 232
    Top = 56
    object qryQuizGetque_id: TIntegerField
      FieldName = 'que_id'
      Origin = 'que_id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object qryQuizGetque_description: TWideStringField
      FieldName = 'que_description'
      Origin = 'que_description'
      Size = 1000
    end
    object qryQuizGetque_01_desc: TWideStringField
      FieldName = 'que_01_desc'
      Origin = 'que_01_desc'
      Size = 1000
    end
    object qryQuizGetque_02_desc: TWideStringField
      FieldName = 'que_02_desc'
      Origin = 'que_02_desc'
      Size = 1000
    end
    object qryQuizGetque_03_desc: TWideStringField
      FieldName = 'que_03_desc'
      Origin = 'que_03_desc'
      Size = 1000
    end
    object qryQuizGetque_04_desc: TWideStringField
      FieldName = 'que_04_desc'
      Origin = 'que_04_desc'
      Size = 1000
    end
    object qryQuizGetque_ro: TSmallintField
      FieldName = 'que_ro'
      Origin = 'que_ro'
    end
    object qryQuizGetque_link_yt: TWideStringField
      FieldName = 'que_link_yt'
      Origin = 'que_link_yt'
      Size = 200
    end
    object qryQuizGetque_qui_id: TIntegerField
      FieldName = 'que_qui_id'
      Origin = 'que_qui_id'
    end
  end
end
