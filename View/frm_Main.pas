unit frm_Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfrmMain = class(TForm)
    btnSolicitarPedido: TButton;
    procedure btnSolicitarPedidoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses frm_SolicitarPedido, ctr_SolicitarPedido, Model.Pedido;

procedure TfrmMain.btnSolicitarPedidoClick(Sender: TObject);
var
  LPedido: TPedido;
  LView: TfrmSolicitarPedido;
  LCtrSolicitarPedido: TCtrSolicitarPedido;

begin
  LPedido := nil;
  LView := nil;
  LCtrSolicitarPedido := nil;
  try
    LPedido := TPedido.Create;
    LView := TfrmSolicitarPedido.Create(nil);
    LCtrSolicitarPedido := TCtrSolicitarPedido.Create(LView, LPedido);
    LCtrSolicitarPedido.ShowModal;
  finally
    LView.FreeOnRelease;
    LPedido.Free;
    LCtrSolicitarPedido.Free;
  end;

end;

end.
