unit Model.Base;

interface

  type
  TBase = class

  public

    function Update(): Integer; virtual; abstract;
    function Insert(): Integer; virtual; abstract;
    function Delete(): Integer; virtual; abstract;
    function Salvar(): Integer; virtual; abstract;
    procedure Validar; virtual; abstract;


  end;

implementation

end.
