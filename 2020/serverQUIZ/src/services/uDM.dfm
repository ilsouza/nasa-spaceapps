object dm: Tdm
  OldCreateOrder = False
  Height = 384
  Width = 491
  object conQuiz: TFDConnection
    Params.Strings = (
      'Database=quiz'
      'User_Name=postgres'
      'Password=postgres'
      'Server=192.168.0.11'
      'DriverID=PG')
    LoginPrompt = False
    Left = 96
    Top = 48
  end
  object qryOpen: TFDQuery
    Connection = conQuiz
    Left = 216
    Top = 48
  end
  object qryExec: TFDQuery
    Connection = conQuiz
    Left = 296
    Top = 48
  end
  object FDPhysPgDriverLink1: TFDPhysPgDriverLink
    Left = 216
    Top = 112
  end
end
