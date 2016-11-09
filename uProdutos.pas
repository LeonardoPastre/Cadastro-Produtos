unit uProdutos;

interface

uses Graphics, Classes, SysUtils, uDataModule, DB;

type
   TProdutos = class
   private
      Codigo: Integer;
      Descricao: string;
      Valor: Double;
      Categoria: string;
      Imagem: TPicture;
   public
      constructor Create;

      class procedure Gravar(Produto: TProdutos);
      class procedure Excluir(Codigo: Integer);

      class function ListarTodos: TList;

      //Getters e Setters
      function GetCodigo: Integer;
      function GetDescricao: string;
      function GetValor: Double;
      function GetCategoria: string;
      function GetImagem: TPicture;

      procedure SetCodigo(Codigo: Integer);
      procedure SetDescricao(Descricao: string);
      procedure SetValor(Valor: Double);
      procedure SetCategoria(Categoria: string);
      procedure SetImagem(Imagem: TPicture);
   end;

implementation

{ TProdutos }

constructor TProdutos.Create;
begin
   Self.Imagem := TPicture.Create;
end;

class procedure TProdutos.Gravar(Produto: TProdutos);
var
   StreamImagem: TMemoryStream;
begin
   if Produto <> nil then
   begin
      StreamImagem := TMemoryStream.Create;

      try
         Produto.GetImagem().Bitmap.SaveToStream(StreamImagem);
         StreamImagem.Seek(0,0);

         with Dm.QryProdutos do
         begin
            Close;
            SQL.Clear;
            SQL.Add('EXEC SP_GRAVA_PRODUTOS :CODIGO, :DESCRICAO, :VALOR, :CATEGORIA, :IMAGEM');

            Parameters.ParamByName('CODIGO').Value := Produto.GetCodigo;
            Parameters.ParamByName('DESCRICAO').Value := Produto.GetDescricao;
            Parameters.ParamByName('VALOR').Value := Produto.GetValor;
            Parameters.ParamByName('CATEGORIA').Value := Produto.GetCategoria;
            Parameters.ParamByName('IMAGEM').LoadFromStream(StreamImagem, ftBlob);

            Dm.QryProdutos.ExecSQL;
         end;
      finally
         StreamImagem.Free;
      end;
   end;
end;

class procedure TProdutos.Excluir(Codigo: Integer);
begin
   with Dm.QryProdutos do
   begin
      Close;
      SQL.Clear;
      SQL.Add('EXEC SP_EXCLUIR_PRODUTOS :CODIGO');

      Parameters.ParamByName('CODIGO').Value := Codigo;
      Dm.QryProdutos.ExecSQL;
   end;
end;

class function TProdutos.ListarTodos: TList;
var
   Produto: TProdutos;
   Lista: TList;
   StreamImagem: TStream;
   Imagem: TPicture;
begin
   Lista := TList.Create;

   with Dm.QryProdutos do
   begin
      Close;
      SQL.Clear;
      SQL.Add('EXEC SP_LISTA_PRODUTOS');
      Open;
   end;

   if not (Dm.QryProdutos.IsEmpty) then
   begin
      Dm.QryProdutos.First;
      while not (Dm.QryProdutos.Eof) do
      begin
         Produto := TProdutos.Create;
         StreamImagem := TStream.Create;
         Imagem := TPicture.Create;

         Produto.SetCodigo(Dm.QryProdutos.FieldByName('CODIGO').AsInteger);
         Produto.SetDescricao(Dm.QryProdutos.FieldByName('DESCRICAO').AsString);
         Produto.SetValor(Dm.QryProdutos.FieldByName('VALOR').AsFloat);
         Produto.SetCategoria(Dm.QryProdutos.FieldByName('CATEGORIA').AsString);

         StreamImagem := Dm.QryProdutos.CreateBlobStream(Dm.QryProdutos.FieldByName('IMAGEM'), bmRead);

         if StreamImagem.Size <> 0 then
         begin
           Imagem.Bitmap.LoadFromStream(StreamImagem);
         end
         else
         begin
           Imagem := nil;
         end;

         Produto.SetImagem(Imagem);

         Lista.Add(Produto);

         Dm.QryProdutos.Next;
      end;
   end;

   Result := Lista;
end;

function TProdutos.GetCodigo: Integer;
begin
   Result := Self.Codigo;
end;

function TProdutos.GetDescricao: string;
begin
   Result := Self.Descricao;
end;

function TProdutos.GetValor: Double;
begin
   Result := Self.Valor;
end;

procedure TProdutos.SetDescricao(Descricao: string);
begin
   Self.Descricao := Descricao;
end;

procedure TProdutos.SetValor(Valor: Double);
begin
   Self.Valor := Valor;
end;

function TProdutos.GetCategoria: string;
begin
   Result := Self.Categoria;
end;

procedure TProdutos.SetCategoria(Categoria: string);
begin
   Self.Categoria := Categoria;
end;

function TProdutos.GetImagem: TPicture;
begin
   Result := Self.Imagem;
end;

procedure TProdutos.SetImagem(Imagem: TPicture);
begin
   Self.Imagem := Imagem;
end;

procedure TProdutos.SetCodigo(Codigo: Integer);
begin
   Self.Codigo := Codigo;
end;

end.
