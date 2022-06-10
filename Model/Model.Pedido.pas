unit Model.Pedido;

interface
uses Model.Base, Model.Cliente, Model.PedidoItem, System.Generics.Collections;

type
  TPedido = class(TBase)
  private
    Fcliente: TCliente;
    Fdt_emissao: TDateTime;
    Fnu_pedido: Integer;
    Flista_item: TObjectList<TPedidoItem>;

    procedure Setcliente(const Value: TCliente);
    procedure Setdt_emissao(const Value: TDateTime);
    procedure Setnu_pedido(const Value: Integer);
    procedure Setlista_item(const Value: TObjectList<TPedidoItem>);
    function GetTotal: Currency;
  public
    property nu_pedido: Integer read Fnu_pedido write Setnu_pedido;
    property dt_emissao: TDateTime read Fdt_emissao write Setdt_emissao;
    property cliente: TCliente read Fcliente write Setcliente;
    property vl_total: Currency read GetTotal;
    property lista_item: TObjectList<TPedidoItem> read Flista_item write Setlista_item;

    procedure Assign(Value: TPedido);
    procedure Validar; override;
    function Update(): Integer; override;
    function Insert(): Integer; override;
    function Delete(): Integer; override;
    function Salvar(): Integer; override;

    destructor Destroy(); override;


    constructor Create();

  end;

implementation
uses System.Classes, System.SysUtils, DAO.Pedido, DAO.PedidoItem;


{ TPedido }


procedure TPedido.Assign(Value: TPedido);
var
  i: Integer;
  iTem: TPedidoItem;
begin

  Fnu_pedido := Value.nu_pedido;
  Fdt_emissao := Value.dt_emissao;

  Fcliente.Free;
  Fcliente := nil;

  if Value.cliente <> nil then
  begin
    Fcliente := TCliente.Create;
    Fcliente.Assign(Value.cliente);
  end;



  Flista_item.Clear;
  for i := 0 to Value.lista_item.Count -1 do
  begin
    item := TPedidoItem.Create(Self);
    Self.Flista_item.Add(iTem);
    item.Assign(Value.lista_item[i]);

  end;


end;

constructor TPedido.Create;
begin
  inherited Create();

  Flista_item := TObjectList<TPedidoItem>.Create;

end;

function TPedido.Delete: Integer;
begin

  TDAOPedidoItem.DeleteFromPedido(Self.nu_pedido);
  Result := TDAOPedido.Delete(Self);

end;

destructor TPedido.Destroy;
begin
  Fcliente.Free;
  Fcliente := nil;

  Flista_item.Free;
  Flista_item := nil;

  inherited;
end;


function TPedido.GetTotal: Currency;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to Flista_item.Count -1 do
  begin

    Result := Result + (Flista_item[i].vl_unitario * Flista_item[i].quantidade);
  end;
end;

function TPedido.Insert: Integer;
var
  i: Integer;
begin
  Validar;

  Result := TDAOPedido.Insert(Self);
  for i := 0 to Flista_item.Count-1 do
  begin

    Flista_item[i].nu_item := i + 1;
    Flista_item[i].Insert;
  end;


end;

function TPedido.Salvar: Integer;
begin
  if Self.nu_pedido > 0 then
    Result := Update()
  else
    Result := Insert();

end;

procedure TPedido.Setcliente(const Value: TCliente);
begin
  Fcliente := Value;
end;

procedure TPedido.Setdt_emissao(const Value: TDateTime);
begin
  Fdt_emissao := Value;
end;

procedure TPedido.Setlista_item(const Value: TObjectList<TPedidoItem>);
begin
  Flista_item := Value;
end;

procedure TPedido.Setnu_pedido(const Value: Integer);
begin
  Fnu_pedido := Value;
end;

function TPedido.Update: Integer;
var
  i: Integer;
begin
  Validar;

  Result := TDAOPedido.Update(Self);
  TDAOPedidoItem.DeleteFromPedido(Self.Fnu_pedido);

  for i := 0 to Flista_item.Count-1 do
  begin

   Flista_item[i].nu_item := i + 1;
   Flista_item[i].Insert;
  end;

end;

procedure TPedido.Validar;
begin
  inherited;
  if vl_total <= 0 then
    raise Exception.Create('Erro, valor total do pedido deve ser maior que zero.');

  if Self.Fdt_emissao = 0 then
    Self.Fdt_emissao := Now();


end;

end.
