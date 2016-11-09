unit uFrmPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, Grids, DBGrids, StdCtrls, Buttons, DB, DBClient, uFrmProdutos,
  uProdutos, ExtCtrls, uFuncoes;

type
  TFrmPrincipal = class(TForm)
    DbgProdutos: TDBGrid;
    BtnIncluir: TBitBtn;
    BtnAlterar: TBitBtn;
    BtnExcluir: TBitBtn;
    CdsProdutos: TClientDataSet;
    DtsProdutos: TDataSource;
    CdsProdutosCODIGO: TIntegerField;
    CdsProdutosDESCRICAO: TStringField;
    CdsProdutosVALOR: TFloatField;
    CdsProdutosCATEGORIA: TStringField;
    CdsProdutosIMAGEM: TBlobField;
    Bevel1: TBevel;
    ImgProdutos: TImage;
    procedure BtnIncluirClick(Sender: TObject);
    procedure BtnAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CdsProdutosAfterScroll(DataSet: TDataSet);
    procedure BtnExcluirClick(Sender: TObject);
  private
    { Private declarations }
    procedure AtualizarTela;
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.dfm}

procedure TFrmPrincipal.BtnIncluirClick(Sender: TObject);
var
   FrmProdutos: TFrmProdutos;
begin
   FrmProdutos := TFrmProdutos.Create(Application);
   FrmProdutos.EmEdicao := False;
   FrmProdutos.ShowModal;
   AtualizarTela;
   FreeAndNil(FrmProdutos);
end;

procedure TFrmPrincipal.BtnAlterarClick(Sender: TObject);
var
   FrmProdutos: TFrmProdutos;
begin
   if CdsProdutos.IsEmpty then
   begin
      Exit;
   end;

   FrmProdutos := TFrmProdutos.Create(Application);
   FrmProdutos.EmEdicao := True;

   with FrmProdutos do
   begin
      EdtCodigo.Text := CdsProdutos.FieldByName('CODIGO').AsString;
      EdtDescricao.Text := CdsProdutos.FieldByName('DESCRICAO').AsString;
      EdtValor.Text := FormatFloat('0,.00', CdsProdutos.FieldByName('VALOR').AsFloat);
      EdtCategoria.Text := CdsProdutos.FieldByName('CATEGORIA').AsString;
      ImgProduto.Picture.Bitmap.Assign(CdsProdutosIMAGEM);
   end;

   FrmProdutos.ShowModal;
   AtualizarTela;
   FreeAndNil(FrmProdutos);
end;

procedure TFrmPrincipal.FormShow(Sender: TObject);
begin
   AtualizarTela;
end;

procedure TFrmPrincipal.CdsProdutosAfterScroll(DataSet: TDataSet);
begin
   if not (CdsProdutos.IsEmpty) then
   begin
      if CdsProdutosIMAGEM.BlobSize <> 0 then
         ImgProdutos.Picture.Bitmap.Assign(CdsProdutosIMAGEM)
      else
         ImgProdutos.Picture := RetornarImagemPadrao;
   end
   else
      ImgProdutos.Picture := nil;
end;

procedure TFrmPrincipal.AtualizarTela;
var
   Lista: TList;
   Contador: Integer;
begin
   Lista := TList.Create;
   try
      Lista := TProdutos.ListarTodos;

      CdsProdutos.Close;
      CdsProdutos.Open;
      CdsProdutos.EmptyDataSet;

      for Contador := 0 to Lista.Count - 1 do
      begin
         CdsProdutos.Append;
         CdsProdutos.FieldByName('CODIGO').AsInteger := TProdutos(Lista.Items[Contador]).GetCodigo;
         CdsProdutos.FieldByName('DESCRICAO').AsString := TProdutos(Lista.Items[Contador]).GetDescricao;
         CdsProdutos.FieldByName('VALOR').AsFloat := TProdutos(Lista.Items[Contador]).GetValor;
         CdsProdutos.FieldByName('CATEGORIA').AsString := TProdutos(Lista.Items[Contador]).GetCategoria;
         CdsProdutos.FieldByName('IMAGEM').Assign(TProdutos(Lista.Items[Contador]).GetImagem);

         CdsProdutos.Post;
      end;

      CdsProdutos.First;
   except
      raise Exception.Create('Erro ao carregar os produtos');
   end;
end;

procedure TFrmPrincipal.BtnExcluirClick(Sender: TObject);
begin
   if CdsProdutos.IsEmpty then
   begin
      Exit;
   end;

   if MessageDlg('Deseja realmente excluir o produto ' +
                 CdsProdutosDESCRICAO.AsString + ' ?', mtConfirmation, [mbYes, mbCancel], 0) = mrCancel then
   begin
      Abort;
   end;

   TProdutos.Excluir(CdsProdutosCODIGO.AsInteger);
   AtualizarTela;
end;

end.
