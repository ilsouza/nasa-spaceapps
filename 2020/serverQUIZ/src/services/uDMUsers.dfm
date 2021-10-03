object dmUsers: TdmUsers
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 260
  Width = 365
  object qryUsersGetItem: TFDQuery
    SQL.Strings = (
      'select * from users where usr_name = :name')
    Left = 144
    Top = 48
    ParamData = <
      item
        Name = 'NAME'
        ParamType = ptInput
      end>
  end
  object qryUsersPostItem: TFDQuery
    SQL.Strings = (
      'insert into users (usr_name) values (:name)')
    Left = 144
    Top = 120
    ParamData = <
      item
        Name = 'NAME'
        ParamType = ptInput
      end>
  end
end
