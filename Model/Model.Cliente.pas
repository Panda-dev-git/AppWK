unit Model.Cliente;

interface
uses Model.Base;

type
  TCliente = class(TBase)
  private
    Fsg_uf: String;
    Fno_cliente: String;
    Fid_cliente: Integer;
    Fno_cidade: String;
    procedure Setid_cliente(const Value: Integer);
    procedure Setno_cidade(const Value: String);
    procedure Setno_cliente(const Value: String);
    procedure Setsg_uf(const Value: String);

  public
    property id_cliente: Integer read Fid_cliente write Setid_cliente;
    property no_cliente: String read Fno_cliente write Setno_cliente;
    property no_cidade: String read Fno_cidade write Setno_cidade;
    property sg_uf: String read Fsg_uf write Setsg_uf;

    procedure Assign(Value: TCliente);

  end;

implementation

{ TCliente }

procedure TCliente.Assign(Value: TCliente);
begin
  Self.Fid_cliente := Value.id_cliente;
  Self.Fno_cliente := Value.no_cliente;
  Self.Fno_cidade := Value.no_cidade;
  Self.Fsg_uf := Value.sg_uf;
end;

procedure TCliente.Setid_cliente(const Value: Integer);
begin
  Fid_cliente := Value;
end;

procedure TCliente.Setno_cidade(const Value: String);
begin
  Fno_cidade := Value;
end;

procedure TCliente.Setno_cliente(const Value: String);
begin
  Fno_cliente := Value;
end;

procedure TCliente.Setsg_uf(const Value: String);
begin
  Fsg_uf := Value;
end;

end.
