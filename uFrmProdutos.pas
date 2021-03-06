unit uFrmProdutos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, uProdutos, ExtDlgs, uFuncoes;

type
  TFrmProdutos = class(TForm)
    BtnCancelar: TBitBtn;
    BtnGravar: TBitBtn;
    Label1: TLabel;
    EdtCodigo: TEdit;
    EdtDescricao: TEdit;
    Label2: TLabel;
    EdtCategoria: TEdit;
    Label3: TLabel;
    EdtValor: TEdit;
    Label4: TLabel;
    BtnSelecionarImagem: TBitBtn;
    opdImagem: TOpenPictureDialog;
    Bevel1: TBevel;
    ImgProduto: TImage;
    procedure BtnGravarClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnSelecionarImagemClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EdtValorKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    EmEdicao: Boolean;
    procedure LimparTela;
  end;

var
  FrmProdutos: TFrmProdutos;

implementation

{$R *.dfm}

procedure TFrmProdutos.BtnGravarClick(Sender: TObject);
var
   Produto: TProdutos;
begin
   if Trim(EdtDescricao.Text) = EmptyStr then
   begin
      ShowMessage('Informe a Descri��o do produto.');
      Abort;
   end;

   if Trim(EdtValor.Text) = EmptyStr then
   begin
      ShowMessage('Informe o Valor do produto');
      Abort;
   end;

   Produto := TProdutos.Create;

   try
      try
         if not (Trim(EdtCodigo.Text) = EmptyStr) then
         begin
            Produto.SetCodigo(StrToInt(EdtCodigo.Text));
         end;

         Produto.SetDescricao(EdtDescricao.Text);
         Produto.SetValor(StrToFloat(EdtValor.Text));
         Produto.SetCategoria(EdtCategoria.Text);
         Produto.SetImagem(ImgProduto.Picture);

         TProdutos.Gravar(Produto);
         ShowMessage('Registro gravado com sucesso!');
         LimparTela;
         EmEdicao := False;
         Close;
      except
         on E: Exception do
         begin
            ShowMessage('Falha na grava��o do registro: ' + E.Message);
         end;
      end;
   finally
      Produto.Free;
   end;
end;

procedure TFrmProdutos.BtnCancelarClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmProdutos.BtnSelecionarImagemClick(Sender: TObject);
begin
   if opdImagem.Execute then
   begin
      ImgProduto.Picture.LoadFromFile(opdImagem.FileName);
   end;
end;

procedure TFrmProdutos.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if Key = VK_ESCAPE then
   begin
      Close;
   end;
end;

procedure TFrmProdutos.EdtValorKeyPress(Sender: TObject; var Key: Char);
begin
   if not (Key in ['0'..'9', #8, ',']) then
   begin
      Key := #0;
   end;
end;

procedure TFrmProdutos.LimparTela;
begin
   EdtCodigo.Clear;
   EdtDescricao.Clear;
   EdtValor.Clear;
   EdtCategoria.Clear;
   ImgProduto.Picture := nil;
end;

procedure TFrmProdutos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   if EmEdicao then
      if MessageDlg('Todas as altera��es ser�o perdidas. Deseja continuar ?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
      begin
         Abort;
      end;

   LimparTela;
end;

procedure TFrmProdutos.FormShow(Sender: TObject);
begin
   if ImgProduto.Picture.Bitmap.Empty then
      ImgProduto.Picture := RetornarImagemPadrao;
end;

end.
