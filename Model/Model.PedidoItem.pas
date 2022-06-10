unit Model.PedidoItem;

interface
uses Model.Base, Model.Produto;

type
  TPedidoItem = class(TBase)
  private
    Fproduto: TProduto;
    Fpedido: TBase;
    Fnu_item: Integer;
    Fquantidade: Currency;
    Fvl_unitario: Currency;
    procedure Setnu_item(const Value: Integer);
    procedure Setpedido(const Value: TBase);
    procedure Setproduto(const Value: TProduto);
    procedure Setquantidade(const Value: Currency);
    procedure Setvl_unitario(const Value: Currency);
    function GetVlTotal(): Currency;

  public
    property nu_item: Integer read Fnu_item write Setnu_item;
    property pedido: TBase read Fpedido write Setpedido;
    property produto: TProduto read Fproduto write Setproduto;
    property quantidade: Currency read Fquantidade write Setquantidade;
    property vl_unitario: Currency read Fvl_unitario write Setvl_unitario;
    property vl_total: Currency read GetVlTotal;

    procedure Assign(Value: TPedidoItem);
    procedure Validar; override;
    function Insert(): Integer; override;
    function Delete(): Integer; override;

    constructor Create(pedido :TBase);
    destructor Destroy(); override;

  end;

implementation
uses DAO.PedidoItem;

{ TPedidoItem }

procedure TPedidoItem.Assign(Value: TPedidoItem);
begin

  Fproduto.Free;
  Fproduto := nil;
  if Value.produto <> nil then
  begin
    Fproduto := TProduto.Create;
    Fproduto.Assign(Value.produto);
  end;

  Self.Fnu_item := Value.nu_item;
  Self.Fquantidade := Value.quantidade;
  Self.Fvl_unitario := Value.vl_unitario;

end;

constructor TPedidoItem.Create(pedido: TBase);
begin
  Self.Fpedido := pedido;
end;

function TPedidoItem.Delete: Integer;
begin
  TDAOPedidoItem.Delete(Self);
end;

destructor TPedidoItem.Destroy;
begin
  Fproduto.Free;
  Fproduto := nil;
  inherited;
end;

function TPedidoItem.GetVlTotal: Currency;
begin
  Result := Self.vl_unitario * Self.Fquantidade;
end;

function TPedidoItem.Insert: Integer;
begin
  Validar();
  TDAOPedidoItem.Insert(Self);

end;

procedure TPedidoItem.Setnu_item(const Value: Integer);
begin
  Fnu_item := Value;
end;

procedure TPedidoItem.Setpedido(const Value: TBase);
begin
  Fpedido := Value;
end;

procedure TPedidoItem.Setproduto(const Value: TProduto);
begin
  Fproduto := Value;
end;

procedure TPedidoItem.Setquantidade(const Value: Currency);
begin
  Fquantidade := Value;
end;

procedure TPedidoItem.Setvl_unitario(const Value: Currency);
begin
  Fvl_unitario := Value;
end;


procedure TPedidoItem.Validar;
begin
  inherited;

end;

end.
