object frmInput: TfrmInput
  Left = 0
  Top = 0
  Caption = 'Digite o n'#250'mero do pedido'
  ClientHeight = 69
  ClientWidth = 248
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object lbPedido: TLabel
    Left = 0
    Top = 0
    Width = 248
    Height = 13
    Align = alTop
    Caption = 'N'#250'mero Pedido'
    ExplicitWidth = 72
  end
  object edtNuPedido: TEdit
    Left = 0
    Top = 13
    Width = 248
    Height = 21
    Align = alTop
    TabOrder = 0
  end
  object btnOk: TButton
    Left = 38
    Top = 40
    Width = 75
    Height = 25
    Caption = 'Ok'
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancelar: TButton
    Left = 119
    Top = 40
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    ModalResult = 2
    TabOrder = 2
  end
end
