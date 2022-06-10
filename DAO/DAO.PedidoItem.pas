unit DAO.PedidoItem;

interface

uses Model.PedidoItem, Model.Pedido, dtm_Principal, System.SysUtils;

type
  TDAOPedidoItem = class
  public
    class function Insert(Value: TPedidoItem): Integer;
    class function Update(Value: TPedidoItem): Integer;
    class function Delete(Value: TPedidoItem): Integer;
    class function DeleteFromPedido(nu_pedido: Integer): Integer;
    class procedure CreateOrRaplaceTable;
    constructor Create();
  end;

implementation

{ TDAOPedidoItem }

constructor TDAOPedidoItem.Create;
begin

end;

class procedure TDAOPedidoItem.CreateOrRaplaceTable;
begin

    dtmPrincipal.LFBConnection.ExecSQL(

  'CREATE TABLE IF NOT EXISTS TB_PEDIDO_ITEM (' + sLineBreak +
   'NU_PEDIDO INT(11) NOT NULL,' + sLineBreak +
   'NU_ITEM INT(5) NOT NULL,' + sLineBreak +
   'ID_PRODUTO INT(11) NOT NULL,' + sLineBreak +
   'QUANTIDADE REAL NOT NULL,' + sLineBreak +
   'VL_UNITARIO REAL NOT NULL,' + sLineBreak +
   'VL_TOTAL REAL NOT NULL,' + sLineBreak +

   'CONSTRAINT pk_tb_pedido_item PRIMARY KEY (nu_pedido, nu_item), ' + sLineBreak +
   'CONSTRAINT fk_tb_pedido_produto FOREIGN KEY (ID_PRODUTO) REFERENCES TB_PRODUTO (ID_PRODUTO),' + sLineBreak +
   'CONSTRAINT fk_tb_pedido_pedido_item FOREIGN KEY (NU_PEDIDO) REFERENCES TB_PEDIDO (NU_PEDIDO)' + sLineBreak +

   ');');

end;

class function TDAOPedidoItem.Delete(Value: TPedidoItem): Integer;
begin

  Result := dtmPrincipal.LFBConnection.ExecSQL('delete from TB_PEDIDO_ITEM where NU_PEDIDO = ' + TPedido(Value.pedido).nu_pedido.ToString() + ' ' +
                                               'AND NU_ITEM = ' + Value.nu_item.ToString());

end;

class function TDAOPedidoItem.DeleteFromPedido(nu_pedido: Integer): Integer;
begin

  Result := dtmPrincipal.LFBConnection.ExecSQL('delete from TB_PEDIDO_ITEM where NU_PEDIDO = ' + nu_pedido.ToString());

end;

class function TDAOPedidoItem.Insert(Value: TPedidoItem): Integer;
var
  sExe: String;
  lFormatCurr: TFormatSettings;
  id: Integer;
begin
  lFormatCurr := TFormatSettings.Create;
  lFormatCurr.DecimalSeparator := '.';
  sExe := 'insert into TB_PEDIDO_ITEM (NU_PEDIDO';
  sExe := sExe + ', NU_ITEM, ID_PRODUTO, QUANTIDADE, VL_UNITARIO, VL_TOTAL) VALUES ( ';


  sExe := sExe + TPedido(Value.pedido).nu_pedido.ToString()+ ', ';
  sExe := sExe + Value.nu_item.ToString()+ ', ';
  sExe := sExe + Value.produto.id_produto.ToString()+ ', ';
  sExe := sExe + CurrToStr(Value.quantidade, lFormatCurr) + ', ';
  sExe := sExe + CurrToStr(Value.vl_unitario, lFormatCurr) + ', ';
  sExe := sExe + CurrToStr(Value.vl_total, lFormatCurr) + ');';

  Result := dtmPrincipal.LFBConnection.ExecSQL(sExe);

end;

class function TDAOPedidoItem.Update(Value: TPedidoItem): Integer;
begin

end;

end.
