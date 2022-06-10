object dtmPrincipal: TdtmPrincipal
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 349
  Width = 477
  object LFBQuery: TFDQuery
    Connection = LFBConnection
    SQL.Strings = (
      'select * from TB_TESTE')
    Left = 136
    Top = 56
  end
  object LFBConnection: TFDConnection
    Params.Strings = (
      'LoginTimeout=3'
      'Password=HBM_SYS_WEB2019@'
      'User_Name=HBM_SYS_WEB'
      'Database=hbm_web'
      'Server=localhost'
      'DriverID=MySQL')
    LoginPrompt = False
    Left = 40
    Top = 56
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    VendorHome = 'C:\Projetos\HBMWeb\Win32\Debug\dll\'
    VendorLib = 'libmysql.dll'
    Left = 144
    Top = 224
  end
end
