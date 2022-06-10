program AppWK;

uses
  Vcl.Forms,
  frm_Main in 'View\frm_Main.pas' {frmMain},
  ctr_SolicitarPedido in 'Controller\ctr_SolicitarPedido.pas',
  frm_SolicitarPedido in 'View\frm_SolicitarPedido.pas' {frmSolicitarPedido},
  Model.Pedido in 'Model\Model.Pedido.pas',
  Model.Base in 'Model\Model.Base.pas',
  Model.Cliente in 'Model\Model.Cliente.pas',
  Model.Produto in 'Model\Model.Produto.pas',
  Model.PedidoItem in 'Model\Model.PedidoItem.pas',
  frm_Input in 'View\frm_Input.pas' {frmInput},
  DAO.Pedido in 'DAO\DAO.Pedido.pas',
  dtm_Principal in 'DAO\dtm_Principal.pas' {dtmPrincipal: TDataModule},
  DAO.Cliente in 'DAO\DAO.Cliente.pas',
  DAO.Produto in 'DAO\DAO.Produto.pas',
  DAO.PedidoItem in 'DAO\DAO.PedidoItem.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TdtmPrincipal, dtmPrincipal);
  Application.Run;
end.
