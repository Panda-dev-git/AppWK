object frmSolicitarPedido: TfrmSolicitarPedido
  Left = 0
  Top = 0
  Caption = 'frmSolicitarPedido'
  ClientHeight = 410
  ClientWidth = 666
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object lbTotalPedido: TLabel
    Left = 0
    Top = 397
    Width = 666
    Height = 13
    Align = alBottom
    Caption = 'Total Pedido: 0'
    ExplicitWidth = 72
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 666
    Height = 129
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 3
      Top = 45
      Width = 87
      Height = 13
      Caption = 'c'#243'digo do produto'
    end
    object Label2: TLabel
      Left = 145
      Top = 45
      Width = 54
      Height = 13
      Caption = 'quantidade'
    end
    object Label3: TLabel
      Left = 305
      Top = 46
      Width = 63
      Height = 13
      Caption = 'valor unit'#225'rio'
    end
    object Label4: TLabel
      Left = 3
      Top = 3
      Width = 69
      Height = 13
      Caption = 'C'#243'digo Cliente'
    end
    object btnInserirItem: TButton
      Left = 456
      Top = 56
      Width = 75
      Height = 25
      Caption = 'Inserir'
      TabOrder = 6
    end
    object edtCodProduto: TEdit
      Left = 3
      Top = 60
      Width = 121
      Height = 21
      TabOrder = 3
    end
    object edtQuantidade: TEdit
      Left = 145
      Top = 60
      Width = 121
      Height = 21
      TabOrder = 4
    end
    object edtVlUnitario: TEdit
      Left = 305
      Top = 60
      Width = 121
      Height = 21
      TabOrder = 5
    end
    object edtCodCliente: TEdit
      Left = 3
      Top = 18
      Width = 121
      Height = 21
      TabOrder = 0
    end
    object btnBuscarPedido: TButton
      Left = 160
      Top = 14
      Width = 97
      Height = 25
      Caption = 'Buscar Pedido'
      TabOrder = 1
    end
    object btnCancelarPedido: TButton
      Left = 271
      Top = 14
      Width = 97
      Height = 25
      Caption = 'Cancelar Pedido'
      TabOrder = 2
    end
    object btnGravarPedido: TButton
      Left = 374
      Top = 14
      Width = 91
      Height = 25
      Caption = 'Gravar Pedido'
      TabOrder = 7
      OnClick = btnGravarPedidoClick
    end
  end
  object GridItem: TStringGrid
    Left = 0
    Top = 129
    Width = 666
    Height = 268
    Align = alClient
    FixedCols = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goFixedRowDefAlign]
    TabOrder = 1
  end
end
