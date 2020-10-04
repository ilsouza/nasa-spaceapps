object dmQuizActions: TdmQuizActions
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 331
  Width = 418
  object qryQuizActionGetItem: TFDQuery
    Left = 144
    Top = 48
  end
  object qryQuizActionPostItem: TFDQuery
    SQL.Strings = (
      'insert into quiz_action'
      '  (qac_usr_id, qac_qui_id, qac_que_id, qac_answer, qac_correct)'
      'values'
      '  (:usr, :qui_id, :que_id, :answer, :correct)')
    Left = 144
    Top = 120
    ParamData = <
      item
        Name = 'USR'
        ParamType = ptInput
      end
      item
        Name = 'QUI_ID'
        ParamType = ptInput
      end
      item
        Name = 'QUE_ID'
        ParamType = ptInput
      end
      item
        Name = 'ANSWER'
        ParamType = ptInput
      end
      item
        Name = 'CORRECT'
        ParamType = ptInput
      end>
  end
end
