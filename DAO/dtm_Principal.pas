unit dtm_Principal;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Phys.MySQLDef, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys,
  FireDAC.Phys.MySQL, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Comp.DataSet;

type
  TdtmPrincipal = class(TDataModule)
    LFBQuery: TFDQuery;
    LFBConnection: TFDConnection;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function getLastId(): Integer;
  end;

var
  dtmPrincipal: TdtmPrincipal;

implementation
uses DAO.Pedido, DAO.PedidoItem, DAO.Cliente, DAO.Produto;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdtmPrincipal.DataModuleCreate(Sender: TObject);
begin

  LFBConnection.Params.Clear;
  LFBConnection.Params.Add('Server=LocalHost');
  LFBConnection.Params.Add('Password=HBM_SYS_WEB2019@');
  LFBConnection.Params.Add('User_Name=HBM_SYS_WEB');
  LFBConnection.Params.Add('LoginTimeout=3');
  LFBConnection.Params.Add('DriverID=MySQL');
  LFBConnection.Params.Add('Database=hbm_web');
  LFBConnection.Params.Add('Port=3306');
  LFBConnection.Connected := true;

  TDAOProduto.CreateOrRaplaceTable;
  TDAOCliente.CreateOrRaplaceTable;
  TDAOPedido.CreateOrRaplaceTable;
  TDAOPedidoItem.CreateOrRaplaceTable;

end;

function TdtmPrincipal.getLastId: Integer;
var
  SelectID: TFDQuery;
begin
  Result := 0;
  SelectID := TFDQuery.Create(nil);
  try

    SelectID.Connection := LFBConnection;
    SelectID.SQL.Text := 'SELECT LAST_INSERT_ID() AS ID';
    SelectID.Open;
    Result := SelectID.Fields[0].AsInteger;
    SelectID.Close;

  finally
    SelectID.Free;
  end;

end;

end.
