unit ctr_SolicitarPedido;

interface
uses System.Variants, System.Classes, frm_SolicitarPedido, Model.Pedido,
System.SysUtils, Model.PedidoItem,
Model.Produto;

  type
  TCtrSolicitarPedido = class

  private
    FView: TfrmSolicitarPedido;
    FPedido: TPedido;
    indexEditItem: Integer;
    procedure edtCodClienteChange(Sender: TObject);
    procedure btnInserirItemClick(Sender: TObject);
    procedure btnBuscarPedidoClick(Sender: TObject);
    procedure btnCancelarPedidoClick(Sender: TObject);
    procedure btnGravarPedidoClick(Sender: TObject);
    procedure edtCodClienteExit(Sender: TObject);
    procedure edtCodProdutoExit(Sender: TObject);
    procedure GridItemEnter(Sender: TObject);
    procedure CarregarPedido;
    procedure CarregarListaItem;
    procedure CarregarItem(const row: Integer; const item: TPedidoItem);
    procedure AddItem(item: TPedidoItem);
    procedure GridItemKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

  public

    function ShowModal: Integer;
    constructor Create(var view: TfrmSolicitarPedido; var pedido: TPedido);

  end;

implementation
uses frm_input, DAO.Cliente, DAO.Produto, DAO.Pedido, dtm_principal;



{ TCtrSolicitarPedido }

procedure TCtrSolicitarPedido.AddItem(item: TPedidoItem);
begin
  FView.GridItem.RowCount := FView.GridItem.RowCount +1;
  CarregarItem(FView.GridItem.RowCount -1, item);
end;

procedure TCtrSolicitarPedido.btnBuscarPedidoClick(Sender: TObject);
var
  inputPedido: TFrmInput;
  Pedido: TPedido;
begin

  inputPedido := nil;
  Pedido := nil;
  try
    inputPedido := TfrmInput.Create(FView);
    if (inputPedido.ShowModal() = 1) then
    begin
      if StrToIntDef(inputPedido.edtNuPedido.Text, 0) <= 0 then
        raise Exception.Create('Erro, número do pedido inválido.');


      Pedido := TDAOPedido.GetPedido(StrToIntDef(inputPedido.edtNuPedido.Text, 0));
      if Pedido = nil then
        raise Exception.Create('Erro, Pedido não encontrado.');
      FPedido.Assign(Pedido);
      CarregarPedido;

    end;


  finally
    Pedido.Free;
    inputPedido.FreeOnRelease;
  end;



end;

procedure TCtrSolicitarPedido.btnCancelarPedidoClick(Sender: TObject);
var
  inputPedido: TFrmInput;
  pedido: TPedido;
begin

  pedido := nil;
  inputPedido := nil;
  try

    inputPedido := TfrmInput.Create(FView);

    if (inputPedido.ShowModal() = 1) then
    begin
      pedido := TPedido.Create;
      pedido.nu_pedido := StrToIntDef(inputPedido.edtNuPedido.Text, 0);
      if pedido.nu_pedido <= 0 then
        raise Exception.Create('Erro, número do pedido inválido.');



      dtmPrincipal.LFBConnection.StartTransaction;
      try
        pedido.Delete();
        dtmPrincipal.LFBConnection.Commit;
      except
        if dtmPrincipal.LFBConnection.InTransaction then
          dtmPrincipal.LFBConnection.Rollback;
        raise;
      end;

    end;

  finally
    pedido.Free;
    inputPedido.FreeOnRelease;
  end;


end;

procedure TCtrSolicitarPedido.btnGravarPedidoClick(Sender: TObject);
begin

  
  //if (StrToIntDef(FView.edtCodCliente.Text, 0) > 0) then
  //  FPedido.cliente :=  StrToIntDef(FView.edtCodCliente.Text, 0);

  dtmPrincipal.LFBConnection.StartTransaction;
  try
    FPedido.Salvar();
    dtmPrincipal.LFBConnection.Commit;
  except
    if dtmPrincipal.LFBConnection.InTransaction then
      dtmPrincipal.LFBConnection.Rollback;
    raise;
  end;


end;

procedure TCtrSolicitarPedido.btnInserirItemClick(Sender: TObject);
var
  item: TPedidoItem;
begin


  if StrToIntDef(FView.edtCodProduto.Text, 0) <= 0 then
  begin
    FView.edtCodProduto.SetFocus;
    raise Exception.Create('Digite um código de produto válido.');
  end;

  if StrToCurrDef(FView.edtQuantidade.Text, 0) <= 0 then
  begin
    FView.edtQuantidade.SetFocus;
    raise Exception.Create('Digite uma quantidade válida.' + sLineBreak + ' Ex.: 10,6');
  end;

  if StrToCurrDef(FView.edtVlUnitario.Text, 0) <= 0 then
  begin
    FView.edtVlUnitario.SetFocus;
    raise Exception.Create('Digite um valor válido.' + sLineBreak + ' Ex.: 10,6');
  end;

  if indexEditItem <= 0 then
  begin
    item := TPedidoItem.Create(FPedido);
    FPedido.lista_item.Add(item);
  end
  else
    item := FPedido.lista_item[indexEditItem-1];

  item.produto := TDAOProduto.GetProduto(StrToInt(FView.edtCodProduto.Text));
  //item.produto.id_produto := StrToInt(FView.edtCodProduto.Text);
  //item.produto.ds_produto :=  'Teste1';
  item.quantidade := StrToCurr(FView.edtQuantidade.Text);
  item.vl_unitario := StrToCurr(FView.edtVlUnitario.Text);

  indexEditItem := 0;
  CarregarListaItem;

  FView.edtCodProduto.Enabled := True;
  FView.edtCodProduto.Text := '';
  FView.edtQuantidade.Text := '';
  FView.edtVlUnitario.Text := '';

end;

procedure TCtrSolicitarPedido.CarregarItem(const row: Integer;
  const item: TPedidoItem);
begin

  FView.GridItem.Cells[0, row] := item.produto.id_produto.ToString();
  FView.GridItem.Cells[1, row] := item.produto.ds_produto;
  FView.GridItem.Cells[2, row] := CurrToStr(item.quantidade);
  FView.GridItem.Cells[3, row] := FormatFloat('0.00', item.vl_unitario);
  FView.GridItem.Cells[4, row] := FormatFloat('0.00', item.vl_total);

end;

procedure TCtrSolicitarPedido.CarregarListaItem;
var
 i: Integer;
 item: TPedidoItem;
begin
  {
  item := TPedidoItem.Create(FPedido);
  item.produto := TProduto.Create;
  item.produto.id_produto := 1;
  item.produto.ds_produto :=  'Teste1';
  item.produto.vl_preco_venda :=  10;
  item.quantidade := 2;
  item.vl_unitario := 15;

  FPedido.lista_item.Add(item);

  item := TPedidoItem.Create(FPedido);
  item.produto := TProduto.Create;
  item.produto.id_produto := 1;
  item.produto.ds_produto :=  'Teste1';
  item.produto.vl_preco_venda :=  10;
  item.quantidade := 1;
  item.vl_unitario := 15;

  FPedido.lista_item.Add(item);

  item := TPedidoItem.Create(FPedido);
  item.produto := TProduto.Create;
  item.produto.id_produto := 1;
  item.produto.ds_produto :=  'Teste1';
  item.produto.vl_preco_venda :=  10;
  item.quantidade := 5;
  item.vl_unitario := 15;

  FPedido.lista_item.Add(item);
  }

  FView.GridItem.RowCount := FPedido.lista_item.Count + 1;
  FView.GridItem.Cols[0].Text := 'Código Produto';
  FView.GridItem.ColWidths[0] := 120;
  FView.GridItem.Cols[1].Text := 'Descrição do Produto';
  FView.GridItem.ColWidths[1] := 120;
  FView.GridItem.Cols[2].Text := 'Quantidade';
  FView.GridItem.ColWidths[2] := 90;
  FView.GridItem.Cols[3].Text := 'Vlr. unitário';
  FView.GridItem.ColWidths[3] := 90;
  FView.GridItem.Cols[4].Text := 'Vlr. Total';
  FView.GridItem.ColWidths[4] := 90;
  FView.GridItem.FixedRows := 0;


  for i := 0 to FPedido.lista_item.Count -1 do
  begin
    CarregarItem(i+1, FPedido.lista_item[i]);
  end;

  FView.lbTotalPedido.Caption := 'Total Pedido: ' + FormatFloat('0.00', FPedido.vl_total);


end;

procedure TCtrSolicitarPedido.CarregarPedido;
begin

  if (FPedido.cliente = nil) or (FPedido.cliente.id_cliente = 0) then
    FView.edtCodCliente.Text := ''
  else
    FView.edtCodCliente.Text := FPedido.cliente.id_cliente.ToString;

  CarregarListaItem;
end;

constructor TCtrSolicitarPedido.Create(var view: TfrmSolicitarPedido; var pedido: TPedido);
begin

  Self.FView := view;
  Self.FPedido := pedido;
  indexEditItem := 0;
  Self.FView.edtCodCliente.OnChange := edtCodClienteChange;
  Self.FView.edtCodCliente.OnExit := edtCodClienteExit;
  Self.FView.edtCodProduto.OnExit := edtCodProdutoExit;
  Self.FView.btnInserirItem.OnClick := btnInserirItemClick;
  Self.FView.btnBuscarPedido.OnClick := btnBuscarPedidoClick;
  Self.FView.btnCancelarPedido.OnClick := btnCancelarPedidoClick;
  Self.FView.btnGravarPedido.OnClick := btnGravarPedidoClick;
  Self.FView.GridItem.OnKeyDown := GridItemKeyDown;

end;

procedure TCtrSolicitarPedido.edtCodClienteChange(Sender: TObject);
begin
  Fview.btnBuscarPedido.Visible := Trim(FView.edtCodCliente.Text).IsEmpty;
  Fview.btnCancelarPedido.Visible := Trim(FView.edtCodCliente.Text).IsEmpty
end;

procedure TCtrSolicitarPedido.edtCodClienteExit(Sender: TObject);
var
  id_cliente: Integer;
begin
  FPedido.cliente.Free;
  FPedido.cliente := nil;

  if Trim(FView.edtCodCliente.Text).IsEmpty then
    Exit;

  try
    id_cliente := StrToInt(FView.edtCodCliente.Text);
  except
    raise Exception.Create('Erro, Código do cliente inválido.');
  end;


  FPedido.cliente := TDAOCliente.GetCliente(id_cliente);

  if FPedido.cliente = nil then
    raise Exception.Create('Erro, cliente não encontrado.');


end;

procedure TCtrSolicitarPedido.edtCodProdutoExit(Sender: TObject);
var
  id_produto: Integer;
  produto: TProduto;
begin


  if Trim(FView.edtCodProduto.Text).IsEmpty then
    Exit;

  try
    id_produto := StrToInt(FView.edtCodProduto.Text);
  except
    raise Exception.Create('Erro, Código do produto inválido.');
  end;


  produto := nil;
  try
    produto := TDAOProduto.GetProduto(id_produto);

    if produto = nil then
      raise Exception.Create('Erro, produto não encontrado.');

    FView.edtVlUnitario.Text := CurrToStr(produto.vl_preco_venda);

  finally
    produto.Free;
  end;


end;

procedure TCtrSolicitarPedido.GridItemEnter(Sender: TObject);
begin
  indexEditItem := FView.GridItem.Row;
end;

procedure TCtrSolicitarPedido.GridItemKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

  if (key = 13) and (FView.GridItem.Row > 0) then
  begin
    indexEditItem := FView.GridItem.Row;
    FView.edtCodProduto.Enabled := False;
    FView.edtCodProduto.Text := FPedido.lista_item[indexEditItem -1].produto.id_produto.toString();
    FView.edtQuantidade.Text := CurrToStr(FPedido.lista_item[indexEditItem -1].quantidade);
    FView.edtVlUnitario.Text := CurrToStr(FPedido.lista_item[indexEditItem -1].vl_unitario);
  end else
  if (key = 46) and (FView.GridItem.Row > 0) then
  begin

    if FView.ShowConfirma('Deseja realmente excluir esse registro?', 'Excluir Registro') then
    begin
      FPedido.lista_item.Delete(FView.GridItem.Row -1);
      CarregarListaItem;
    end;



  end;

  key := 0;

end;

function TCtrSolicitarPedido.ShowModal: Integer;
begin
  Self.CarregarListaItem;
  FView.ShowModal;
end;

end.
