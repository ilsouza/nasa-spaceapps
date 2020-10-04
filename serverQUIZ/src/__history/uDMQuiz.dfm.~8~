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
    SQL.Strings = (
      'select qui_name from quiz')
    Left = 232
    Top = 56
  end
end
