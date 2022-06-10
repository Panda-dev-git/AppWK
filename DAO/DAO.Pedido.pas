unit DAO.Pedido;

interface
uses Model.Pedido, Model.Cliente, Model.Produto, Model.PedidoItem, dtm_Principal, System.SysUtils;

type
  TDAOPedido = class
  private
    procedure carregarPedido(Value: TPedido);
  public
    class function Insert(Value: TPedido): Integer;
    class function Update(Value: TPedido): Integer;
    class function Delete(Value: TPedido): Integer;
    class function GetPedido(nu_pedido: Integer): TPedido;
    class procedure CreateOrRaplaceTable;
    constructor Create();
  end;

implementation
uses FireDAC.Comp.Client;

{ TDAOPedido }

procedure TDAOPedido.carregarPedido(Value: TPedido);
begin

end;

constructor TDAOPedido.Create;
begin

end;

class procedure TDAOPedido.CreateOrRaplaceTable;
begin

  dtmPrincipal.LFBConnection.ExecSQL(

  'CREATE TABLE IF NOT EXISTS TB_PEDIDO (' + sLineBreak +
   'NU_PEDIDO INT(11) NOT NULL AUTO_INCREMENT,' + sLineBreak +
   'ID_CLIENTE INT(11),' + sLineBreak +
   'DT_EMISSAO DATETIME NOT NULL,' + sLineBreak +
   'VL_TOTAL REAL NOT NULL,' + sLineBreak +

   'CONSTRAINT pk_tb_pedido PRIMARY KEY (nu_pedido),' + sLineBreak +
   'CONSTRAINT fk_tb_pedido_cliente FOREIGN KEY (ID_CLIENTE) REFERENCES TB_CLIENTE (ID_CLIENTE)' + sLineBreak +

   ');');


end;

class function TDAOPedido.Delete(Value: TPedido): Integer;
begin

  Result := dtmPrincipal.LFBConnection.ExecSQL('delete from TB_PEDIDO where NU_PEDIDO = ' + Value.nu_pedido.ToString());

end;

class function TDAOPedido.GetPedido(nu_pedido: Integer): TPedido;
var
  Select: TFDQuery;
  iTem: TPedidoItem;
begin
  Result := nil;
  Select := TFDQuery.Create(nil);
  try

    Select.Connection := dtmPrincipal.LFBConnection;
    Select.SQL.Text := 'SELECT PE.NU_PEDIDO, PE.DT_EMISSAO, PE.ID_CLIENTE, PE.VL_TOTAL VL_TOTAL_PEDIDO,' + sLineBreak +
                       'PI.NU_ITEM, PI.ID_PRODUTO, PI.QUANTIDADE, PI.VL_UNITARIO, ' + sLineBreak +
                       'PR.DS_PRODUTO ' + sLineBreak +
                       '  FROM TB_PEDIDO PE' + sLineBreak +
                       '  JOIN TB_PEDIDO_ITEM PI ON PE.NU_PEDIDO = PI.NU_PEDIDO ' + sLineBreak +
                       '  JOIN TB_PRODUTO PR ON PR.ID_PRODUTO = PI.ID_PRODUTO ' + sLineBreak +
                       'WHERE PE.NU_PEDIDO = ' + nu_pedido.ToString();
    Select.Open;
    if Select.IsEmpty then
      Exit;

    Result := TPedido.Create;
    Result.nu_pedido := Select.FieldByName('NU_PEDIDO').AsInteger;
    Result.dt_emissao := Select.FieldByName('DT_EMISSAO').AsDateTime;
    if Select.FieldByName('ID_CLIENTE').AsInteger <> 0 then
    begin
      Result.cliente := TCliente.Create;
      Result.cliente.id_cliente := Select.FieldByName('ID_CLIENTE').AsInteger;
    end;

    while not Select.Eof do
    begin

      iTem := TPedidoItem.Create(Result);
      Result.lista_item.Add(Item);

      item.nu_item := Select.FieldByName('NU_ITEM').AsInteger;
      if Select.FieldByName('ID_PRODUTO').AsInteger > 0 then
      begin
        item.produto := TProduto.Create;
        item.produto.id_produto := Select.FieldByName('ID_PRODUTO').AsInteger;
        item.produto.ds_produto := Select.FieldByName('DS_PRODUTO').AsString;
      end;

      item.quantidade := Select.FieldByName('QUANTIDADE').AsCurrency;
      iTem.vl_unitario := Select.FieldByName('VL_UNITARIO').AsCurrency;

      Select.Next;
    end;



    Select.Close;

  finally
    Select.Free;
  end;
end;

class function TDAOPedido.Insert(Value: TPedido): Integer;
var
  sExe: String;
  lFormatCurr: TFormatSettings;
  id: Integer;
begin
  lFormatCurr := TFormatSettings.Create;
  lFormatCurr.DecimalSeparator := '.';
  sExe := 'insert into TB_PEDIDO (ID_CLIENTE';
  sExe := sExe + ', DT_EMISSAO, VL_TOTAL) VALUES ( ';

  if (Value.cliente <> nil) and (Value.cliente.id_cliente > 0) then
    sExe := sExe + Value.cliente.id_cliente.ToString()+ ', '
  else
    sExe := sExe + 'NULL, ';

  sExe := sExe + QuotedStr(FormatDateTime('YYYY-MM-DD HH:MM:SS', Value.dt_emissao)) + ', ';

  sExe := sExe + CurrToStr(Value.vl_total, lFormatCurr) + ');';

  Result := dtmPrincipal.LFBConnection.ExecSQL(sExe);

  id := dtmPrincipal.getLastId();

  if id = 0 then
    raise Exception.Create('Erro, não foi possível recuperar o ID TDAOPedido.Insert');

  Value.nu_pedido := id;

end;

class function TDAOPedido.Update(Value: TPedido): Integer;

  var
  sExe: String;
  lFormatCurr: TFormatSettings;
  id: Integer;
begin
  lFormatCurr := TFormatSettings.Create;
  lFormatCurr.DecimalSeparator := '.';
  sExe := 'UPDATE TB_PEDIDO SET ID_CLIENTE = ';

  if (Value.cliente <> nil) and (Value.cliente.id_cliente > 0) then
    sExe := sExe + Value.cliente.id_cliente.ToString()+ ', '
  else
    sExe := sExe + 'NULL, ';

  sExe := sExe + 'DT_EMISSAO = ' + QuotedStr(FormatDateTime('YYYY-MM-DD HH:MM:SS', Value.dt_emissao)) + ', ' +
    'VL_TOTAL = ' + CurrToStr(Value.vl_total, lFormatCurr) + ' WHERE NU_PEDIDO = ' + Value.nu_pedido.ToString();

  Result := dtmPrincipal.LFBConnection.ExecSQL(sExe);

end;

end.
