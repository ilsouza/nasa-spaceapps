object dmQuestions: TdmQuestions
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 326
  Width = 377
  object qryQuestionsGetItem: TFDQuery
    SQL.Strings = (
      'select * from questions where que_id = :id')
    Left = 144
    Top = 48
    ParamData = <
      item
        Name = 'ID'
        ParamType = ptInput
      end>
  end
  object qryQuestionsPostItem: TFDQuery
    SQL.Strings = (
      'insert into questions '
      
        '  (que_description, que_01_desc, que_02_desc, que_03_desc, que_0' +
        '4_desc, que_ro, que_link_yt) '
      'values'
      
        '  (:description, :01_desc, :02_desc, :03_desc, :04_desc, :ro, :l' +
        'ink)')
    Left = 144
    Top = 120
    ParamData = <
      item
        Name = 'DESCRIPTION'
        ParamType = ptInput
      end
      item
        Name = '01_DESC'
        ParamType = ptInput
      end
      item
        Name = '02_DESC'
        ParamType = ptInput
      end
      item
        Name = '03_DESC'
        ParamType = ptInput
      end
      item
        Name = '04_DESC'
        ParamType = ptInput
      end
      item
        Name = 'RO'
        ParamType = ptInput
      end
      item
        Name = 'LINK'
        ParamType = ptInput
      end>
  end
  object qryQuestionsGet: TFDQuery
    SQL.Strings = (
      'select * from questions')
    Left = 144
    Top = 192
  end
end
