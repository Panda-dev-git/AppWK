unit DAO.Produto;

interface
uses Model.Produto, dtm_Principal, System.SysUtils;

type
  TDAOProduto = class
  public
    class function Insert(Value: TProduto): Integer;
    class function GetProduto(id: Integer): TProduto;
    class procedure CreateOrRaplaceTable;
    constructor Create();
  end;

implementation
uses FireDAC.Comp.Client, System.Math;

{ TDAOProduto }

constructor TDAOProduto.Create;
begin

end;

class procedure TDAOProduto.CreateOrRaplaceTable;
var
  Select: TFDQuery;
  i: Integer;
  produto: TProduto;
begin

    dtmPrincipal.LFBConnection.ExecSQL(

  'CREATE TABLE IF NOT EXISTS TB_PRODUTO (' + sLineBreak +
   'ID_PRODUTO INT(11) NOT NULL AUTO_INCREMENT,' + sLineBreak +

   'DS_PRODUTO VARCHAR(60) NOT NULL,' + sLineBreak +
   'VL_PRECO_VENDA REAL, ' + sLineBreak +

   'INDEX idx_produto_ds (DS_PRODUTO),' + sLineBreak +
   'CONSTRAINT pk_tb_produto PRIMARY KEY (id_produto)' + sLineBreak +
   ');');

  produto := nil;
  Select := TFDQuery.Create(nil);
  try

    Select.Connection := dtmPrincipal.LFBConnection;
    Select.SQL.Text := 'SELECT * FROM TB_PRODUTO ' + sLineBreak +
                       'LIMIT 1 ';
    Select.Open;
    if Select.IsEmpty then
    begin
      produto := TProduto.Create;
      for i := 1 to 50 do
      begin
        produto.id_produto := i;
        produto.ds_produto := 'Produto '+ i.ToString();
        produto.vl_preco_venda := RandomRange(5, 100);
        Insert(produto);
      end;

    end;


  finally
    Select.Free;
    produto.Free;
  end;

end;

class function TDAOProduto.GetProduto(id: Integer): TProduto;
var
  Select: TFDQuery;
begin
  Result := nil;
  Select := TFDQuery.Create(nil);
  try

    Select.Connection := dtmPrincipal.LFBConnection;
    Select.SQL.Text := 'SELECT ID_PRODUTO, DS_PRODUTO, VL_PRECO_VENDA FROM TB_PRODUTO ' + sLineBreak +
                       'WHERE ID_PRODUTO = ' + id.ToString();
    Select.Open;
    if Select.IsEmpty then
      Exit;

    Result := TProduto.Create;
    Result.id_produto := Select.Fields[0].AsInteger;
    Result.ds_produto := Select.Fields[1].AsString;
    Result.vl_preco_venda := Select.Fields[2].AsCurrency;

    Select.Close;

  finally
    Select.Free;
  end;


end;

class function TDAOProduto.Insert(Value: TProduto): Integer;
var
  lFormatCurr: TFormatSettings;
  sExe: String;
begin

  lFormatCurr := TFormatSettings.Create;
  lFormatCurr.DecimalSeparator := '.';

  sExe := 'insert into TB_PRODUTO (DS_PRODUTO, VL_PRECO_VENDA) VALUES (';



  sExe := sExe + QuotedStr(Value.ds_produto) + ', ';

  sExe := sExe + CurrToStr(Value.vl_preco_venda, lFormatCurr) + ');';

  Result := dtmPrincipal.LFBConnection.ExecSQL(sExe);

end;

end.
