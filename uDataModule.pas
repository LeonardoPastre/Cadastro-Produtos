unit uDataModule;

interface

uses
  SysUtils, Classes, DB, ADODB;

type
  TDm = class(TDataModule)
    AdoConexao: TADOConnection;
    QryProdutos: TADOQuery;
    QryProdutosCODIGO: TAutoIncField;
    QryProdutosDESCRICAO: TStringField;
    QryProdutosVALOR: TFloatField;
    QryProdutosCATEGORIA: TStringField;
    QryProdutosIMAGEM: TBlobField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Dm: TDm;

implementation

{$R *.dfm}

end.
