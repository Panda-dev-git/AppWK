unit Model.Produto;

interface
uses Model.Base;

type
  TProduto = class(TBase)
  private
    Fid_produto: Integer;
    Fvl_preco_venda: Currency;
    Fds_produto: String;
    procedure Setds_produto(const Value: String);
    procedure Setid_produto(const Value: Integer);
    procedure Setvl_preco_venda(const Value: Currency);
  public
    property id_produto: Integer read Fid_produto write Setid_produto;
    property ds_produto: String read Fds_produto write Setds_produto;
    property vl_preco_venda: Currency read Fvl_preco_venda write Setvl_preco_venda;

    procedure Assign(Value: TProduto);


  end;

implementation

{ TProduto }

procedure TProduto.Assign(Value: TProduto);
begin
  Fid_produto := Value.id_produto;
  Fds_produto := Value.ds_produto;
  Fvl_preco_venda := Value.vl_preco_venda;
end;

procedure TProduto.Setds_produto(const Value: String);
begin
  Fds_produto := Value;
end;

procedure TProduto.Setid_produto(const Value: Integer);
begin
  Fid_produto := Value;
end;

procedure TProduto.Setvl_preco_venda(const Value: Currency);
begin
  Fvl_preco_venda := Value;
end;

end.
