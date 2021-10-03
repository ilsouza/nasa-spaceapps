object dmQuestions: TdmQuestions
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 417
  Width = 840
  object qryQuestionsUserItem: TFDQuery
    Connection = dm.conQuiz
    SQL.Strings = (
      'select action.*, questions.* from quiz_action action'
      ' left join questions'
      ' on questions.que_id = action.qac_que_id'
      'where action.qac_qui_id = :user')
    Left = 104
    Top = 128
    ParamData = <
      item
        Name = 'USER'
        ParamType = ptInput
      end>
  end
  object qryQuestionsPostItem: TFDQuery
    Connection = dm.conQuiz
    SQL.Strings = (
      'insert into questions '
      
        '  (que_description, que_01_desc, que_02_desc, que_03_desc, que_0' +
        '4_desc, que_ro, que_link_yt) '
      'values'
      
        '  (:description, :01_desc, :02_desc, :03_desc, :04_desc, :ro, :l' +
        'ink)')
    Left = 104
    Top = 200
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
  object qryQuestionsUser: TFDQuery
    Connection = dm.conQuiz
    SQL.Strings = (
      'select action.*, questions.* from quiz_action action'
      ' left join questions'
      ' on questions.que_id = action.qac_que_id')
    Left = 104
    Top = 64
    object qryQuestionsUserqac_id: TIntegerField
      FieldName = 'qac_id'
      Origin = 'qac_id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object qryQuestionsUserqac_usr_id: TIntegerField
      FieldName = 'qac_usr_id'
      Origin = 'qac_usr_id'
    end
    object qryQuestionsUserqac_qui_id: TIntegerField
      FieldName = 'qac_qui_id'
      Origin = 'qac_qui_id'
    end
    object qryQuestionsUserqac_que_id: TIntegerField
      FieldName = 'qac_que_id'
      Origin = 'qac_que_id'
    end
    object qryQuestionsUserqac_answer: TSmallintField
      FieldName = 'qac_answer'
      Origin = 'qac_answer'
    end
    object qryQuestionsUserqac_correct: TBooleanField
      FieldName = 'qac_correct'
      Origin = 'qac_correct'
    end
    object qryQuestionsUserque_id: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'que_id'
      Origin = 'que_id'
    end
    object qryQuestionsUserque_description: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'que_description'
      Origin = 'que_description'
      Size = 1000
    end
    object qryQuestionsUserque_01_desc: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'que_01_desc'
      Origin = 'que_01_desc'
      Size = 1000
    end
    object qryQuestionsUserque_02_desc: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'que_02_desc'
      Origin = 'que_02_desc'
      Size = 1000
    end
    object qryQuestionsUserque_03_desc: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'que_03_desc'
      Origin = 'que_03_desc'
      Size = 1000
    end
    object qryQuestionsUserque_04_desc: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'que_04_desc'
      Origin = 'que_04_desc'
      Size = 1000
    end
    object qryQuestionsUserque_ro: TSmallintField
      AutoGenerateValue = arDefault
      FieldName = 'que_ro'
      Origin = 'que_ro'
    end
    object qryQuestionsUserque_link_yt: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'que_link_yt'
      Origin = 'que_link_yt'
      Size = 200
    end
    object qryQuestionsUserque_qui_id: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'que_qui_id'
      Origin = 'que_qui_id'
    end
  end
  object qryQuestionsQuizItem: TFDQuery
    Connection = dm.conQuiz
    SQL.Strings = (
      'select quiz.*, questions.* from questions'
      '  left join quiz'
      '  on questions.que_qui_id = quiz.qui_id'
      'where quiz.qui_id = :id')
    Left = 248
    Top = 128
    ParamData = <
      item
        Name = 'ID'
        ParamType = ptInput
      end>
    object qryQuestionsQuizItemqui_id: TIntegerField
      FieldName = 'qui_id'
      Origin = 'qui_id'
    end
    object qryQuestionsQuizItemqui_name: TWideStringField
      FieldName = 'qui_name'
      Origin = 'qui_name'
    end
    object qryQuestionsQuizItemque_id: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'que_id'
      Origin = 'que_id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object qryQuestionsQuizItemque_description: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'que_description'
      Origin = 'que_description'
      Size = 1000
    end
    object qryQuestionsQuizItemque_01_desc: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'que_01_desc'
      Origin = 'que_01_desc'
      Size = 1000
    end
    object qryQuestionsQuizItemque_02_desc: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'que_02_desc'
      Origin = 'que_02_desc'
      Size = 1000
    end
    object qryQuestionsQuizItemque_03_desc: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'que_03_desc'
      Origin = 'que_03_desc'
      Size = 1000
    end
    object qryQuestionsQuizItemque_04_desc: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'que_04_desc'
      Origin = 'que_04_desc'
      Size = 1000
    end
    object qryQuestionsQuizItemque_ro: TSmallintField
      AutoGenerateValue = arDefault
      FieldName = 'que_ro'
      Origin = 'que_ro'
    end
    object qryQuestionsQuizItemque_link_yt: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'que_link_yt'
      Origin = 'que_link_yt'
      Size = 200
    end
    object qryQuestionsQuizItemque_qui_id: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'que_qui_id'
      Origin = 'que_qui_id'
    end
  end
  object qryQuestionsQuizPostItem: TFDQuery
    Connection = dm.conQuiz
    SQL.Strings = (
      'insert into questions '
      
        '  (que_description, que_01_desc, que_02_desc, que_03_desc, que_0' +
        '4_desc, que_ro, que_link_yt) '
      'values'
      
        '  (:description, :01_desc, :02_desc, :03_desc, :04_desc, :ro, :l' +
        'ink)')
    Left = 248
    Top = 200
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
  object qryQuestionsQuiz: TFDQuery
    Connection = dm.conQuiz
    SQL.Strings = (
      'select quiz.*, questions.* from questions'
      '  left join quiz'
      '  on questions.que_qui_id = quiz.qui_id'
      '')
    Left = 248
    Top = 64
    object qryQuestionsQuizqui_id: TIntegerField
      FieldName = 'qui_id'
      Origin = 'qui_id'
    end
    object qryQuestionsQuizqui_name: TWideStringField
      FieldName = 'qui_name'
      Origin = 'qui_name'
    end
    object qryQuestionsQuizque_id: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'que_id'
      Origin = 'que_id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object qryQuestionsQuizque_description: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'que_description'
      Origin = 'que_description'
      Size = 1000
    end
    object qryQuestionsQuizque_01_desc: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'que_01_desc'
      Origin = 'que_01_desc'
      Size = 1000
    end
    object qryQuestionsQuizque_02_desc: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'que_02_desc'
      Origin = 'que_02_desc'
      Size = 1000
    end
    object qryQuestionsQuizque_03_desc: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'que_03_desc'
      Origin = 'que_03_desc'
      Size = 1000
    end
    object qryQuestionsQuizque_04_desc: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'que_04_desc'
      Origin = 'que_04_desc'
      Size = 1000
    end
    object qryQuestionsQuizque_ro: TSmallintField
      AutoGenerateValue = arDefault
      FieldName = 'que_ro'
      Origin = 'que_ro'
    end
    object qryQuestionsQuizque_link_yt: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'que_link_yt'
      Origin = 'que_link_yt'
      Size = 200
    end
    object qryQuestionsQuizque_qui_id: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'que_qui_id'
      Origin = 'que_qui_id'
    end
  end
end
