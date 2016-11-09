unit uFuncoes;

interface

uses Graphics, Forms, SysUtils;

function RetornarImagemPadrao: TPicture;

implementation

function RetornarImagemPadrao: TPicture;
var
   Imagem: TPicture;
   CaminhoImagemPadrao: string;
begin
   Imagem := TPicture.Create;
   CaminhoImagemPadrao := ExtractFilePath(Application.ExeName) + 'Imagens/sem_imagem.bmp';

   if FileExists(CaminhoImagemPadrao) then
      Imagem.Bitmap.LoadFromFile(CaminhoImagemPadrao)
   else
      Imagem := nil;

   Result := Imagem;
end;

end.
