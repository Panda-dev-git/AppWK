unit DAO.Cliente;

interface

uses Model.Cliente, dtm_Principal, System.SysUtils;

type
  TDAOCliente = class
  public
    class function Insert(Value: TCliente): Integer;
    class function GetCliente(id: Integer): TCliente;
    class procedure CreateOrRaplaceTable;
    constructor Create();
  end;

implementation
uses FireDAC.Comp.Client;

{ TDAOCliente }

constructor TDAOCliente.Create;
begin

end;

class procedure TDAOCliente.CreateOrRaplaceTable;
var
  Select: TFDQuery;
  i: Integer;
  cliente: TCliente;
begin

    dtmPrincipal.LFBConnection.ExecSQL(

  'CREATE TABLE IF NOT EXISTS TB_CLIENTE (' + sLineBreak +
   'ID_CLIENTE INT(11) NOT NULL AUTO_INCREMENT,' + sLineBreak +

   'NO_CLIENTE VARCHAR(60) NOT NULL,' + sLineBreak +
   'NO_CIDADE VARCHAR(30), ' + sLineBreak +
   'SG_UF VARCHAR(2), ' + sLineBreak +
   'INDEX idx_cliente_no (NO_CLIENTE),' + sLineBreak +
   'CONSTRAINT pk_tb_cliente PRIMARY KEY (id_cliente)' + sLineBreak +
   ');');

  cliente := nil;
  Select := TFDQuery.Create(nil);
  try

    Select.Connection := dtmPrincipal.LFBConnection;
    Select.SQL.Text := 'SELECT ID_CLIENTE, NO_CLIENTE, NO_CIDADE, SG_UF FROM TB_CLIENTE ' + sLineBreak +
                       'LIMIT 1 ';
    Select.Open;
    if Select.IsEmpty then
    begin
      cliente := TCliente.Create;
      for i := 1 to 50 do
      begin
        cliente.id_cliente := i;
        cliente.no_cliente := 'Cliente '+ i.ToString();
        cliente.no_cidade := 'Brasília';
        cliente.sg_uf := 'DF';
        Insert(cliente);
      end;

    end;


  finally
    Select.Free;
    cliente.Free;
  end;

end;

class function TDAOCliente.GetCliente(id: Integer): TCliente;
var
  Select: TFDQuery;
begin
  Result := nil;
  Select := TFDQuery.Create(nil);
  try

    Select.Connection := dtmPrincipal.LFBConnection;
    Select.SQL.Text := 'SELECT ID_CLIENTE, NO_CLIENTE, NO_CIDADE, SG_UF FROM TB_CLIENTE ' + sLineBreak +
                       'WHERE ID_CLIENTE = ' + id.ToString();
    Select.Open;
    if Select.IsEmpty then
      Exit;

    Result := TCliente.Create;
    Result.id_cliente := Select.Fields[0].AsInteger;
    Result.no_cliente := Select.Fields[1].AsString;
    Result.no_cidade := Select.Fields[2].AsString;
    Result.sg_uf := Select.Fields[3].AsString;

    Select.Close;

  finally
    Select.Free;
  end;

end;

class function TDAOCliente.Insert(Value: TCliente): Integer;
var
  sExe: String;
begin

  sExe := 'insert into TB_CLIENTE (NO_CLIENTE';
  sExe := sExe + ', NO_CIDADE, SG_UF) VALUES ( ';


  sExe := sExe + QuotedStr(Value.no_cliente);

  if Value.no_cidade.IsEmpty then
    sExe := sExe + ', NULL'
  else
    sExe := sExe + ', ' + QuotedStr(Value.no_cidade);

  if Value.sg_uf.IsEmpty then
    sExe := sExe + ', NULL'
  else
    sExe := sExe + ', ' + QuotedStr(Value.sg_uf);


  sExe := sExe +  ');';

  Result := dtmPrincipal.LFBConnection.ExecSQL(sExe);

end;


end.
