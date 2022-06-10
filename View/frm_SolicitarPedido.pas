unit frm_SolicitarPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmSolicitarPedido = class(TForm)
    Panel1: TPanel;
    btnInserirItem: TButton;
    edtCodProduto: TEdit;
    edtQuantidade: TEdit;
    edtVlUnitario: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    GridItem: TStringGrid;
    edtCodCliente: TEdit;
    Label4: TLabel;
    btnBuscarPedido: TButton;
    btnCancelarPedido: TButton;
    lbTotalPedido: TLabel;
    btnGravarPedido: TButton;
    procedure btnGravarPedidoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function ShowConfirma(pText, pCaption: String): Boolean;

  end;

var
  frmSolicitarPedido: TfrmSolicitarPedido;

implementation
uses frm_input;

{$R *.dfm}

procedure TfrmSolicitarPedido.btnGravarPedidoClick(Sender: TObject);
begin
  ShowMessage(frmInput.ShowModal().ToString);
end;

function TfrmSolicitarPedido.ShowConfirma(pText, pCaption: String): Boolean;
begin

  result := Application.MessageBox(PWideChar(pText), PWideChar(pCaption),mb_yesno + mb_iconquestion) = id_yes;

end;

end.
