unit UnitMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Memo.Types,
  FMX.ScrollBox, FMX.Memo, FMX.Controls.Presentation, FMX.StdCtrls;

type
  TForm2 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses
  eFirebase, eFirebase.Interfaces, eFirebase.Types;

{$R *.fmx}

procedure TForm2.Button1Click(Sender: TObject);
var
  auth: ieFirebaseResponseAuth;
begin
  //auth := TeFirebase.New.Auth('AIzaSyCeUiXhD5rL0QgHoV1C8WkCg17n9n5teew').SignInWithEmailPassword('familia.alves2013@outlook.com', 'Roblox2023');
  //auth := TeFirebase.New.Auth('AIzaSyCeUiXhD5rL0QgHoV1C8WkCg17n9n5teew').ChangeProfile('eyJhbGciOiJSUzI1NiIsImtpZCI6ImY4NzZiNzIxNDAwYmZhZmEyOWQ0MTFmZTYwODE2YmRhZWMyM2Iz' + 'ODIiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vZXRhc2' + 'tzLWQ2OTg4IiwiYXVkIjoiZXRhc2tzLWQ2OTg4IiwiYXV0aF90aW1lIjoxNjc3NDU1NTEzLCJ1c2VyX2lkIjoiWDZ4bDJ' + 'iYzUwclRCVGpFZXZ4eVNoMVNRYU1iMiIsInN1YiI6Ilg2eGwyYmM1MHJUQlRqRWV2eHlTaDFTUWFNYjIiLCJ' + 'pYXQiOjE2Nzc0NTU1MTMsImV4cCI6MTY3NzQ1OTExMywiZW1haWwiOiJmYW1pbGlhLmFsdmVzMjAxM0BvdX' + 'Rsb29rLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJlbWFpbCI6WyJmYW1p' + 'bGlhLmFsdmVzMjAxM0BvdXRsb29rLmNvbSJdfSwic2lnbl9pbl9wcm92aWRlciI6InBhc3N3b3JkIn19.V-ERTuN' + 'WPquSwO-LqRSeF_sUsboLOaKdFm7esq1A_8eSmXHBZIp1YlDWHJuxcylcbgSwn2vrQP5xJEQ_AqPIZ' + 'ZGLOLU0khIoW2VM90VZRdYWNbpbnaTr2Du3RswyvXFpOhguEsgehD45Q0NEmwvSauo0YKZgbr-RGdYiF1TeGrAczAQwAXrdG' + 'ga-RCYjTCbW9uJMIKPOU5rhtkrghnhIIKGhxBupXhMyMos3TFXX1Y0EuL4OncI8xRRTLIY91CG-BD5VW9x6GOJf258BCQXSUgV6BJ0HcvOhTK2mi1EPT8YBiRvN-QPk-AOTITfSBnj7zli9JkbA-1UkQNb17-S37Q', 'Developers Account', '');
  auth := TeFirebase.New.Auth('AIzaSyCeUiXhD5rL0QgHoV1C8WkCg17n9n5teew').GetProfile('eyJhbGciOiJSUzI1NiIsImtpZCI6' + 'ImY4NzZiNzIxNDAwYmZhZmEyOWQ0MTFmZTYwODE2YmRhZWMyM2IzODIiLCJ0eXAiOiJKV1QifQ.eyJuYW1lIjoiRGV2ZWxvcGVycyBBY2NvdW50IiwicGljdHVyZSI6IiIsImlzcyI6Imh' + '0dHBzOi8vc2VjdXJldG9rZW4uZ29vZ2xlLmNvbS9ldGFza3MtZDY5ODgiLCJhdWQiOiJldGFza3MtZDY5ODgiLCJhdXRoX3RpbWUiOjE2Nzc0NTk0OTgsInVzZXJfaWQiOiJYNnhsM' + 'mJjNTByVEJUakVldnh5U2gxU1FhTWIyIiwic3ViIjoiWDZ4bDJiYzUwclRCVGpFZXZ4eVNoMVNRYU1iMiIsImlhdCI6MTY3NzQ1OTQ5OCwiZX' + 'hwIjoxNjc3NDYzMDk4LCJlbWFpbCI6ImZhbWlsaWEuYWx2ZXMyMDEzQG91dGxvb2suY29tIiwiZW1haWxfdmVyaWZ' + 'pZWQiOmZhbHNlLCJmaXJlYmFzZSI6eyJpZGVudGl0aWVzIjp7ImVtYWlsIjpbImZhbWlsaWEuYWx2ZXMyMDEzQG91dGxvb2suY' + '29tIl19LCJzaWduX2luX3Byb3ZpZGVyIjoicGFzc3dvcmQifX0.QoQE64_V9xymor8JthD7RdnnBVdV7R' + 'raMxCn-XV35sAMhR6hX8pOw0tLu__8_FHEHmBvHTSVoGwBqu1z65sb7yMynxXTyTUsDTJbQcJ4XNQOO2da7PVhyZXp-0aL1xhQBeIxRlwxxeu-IjJu' + '8dh04htZ0P7Z1ci0D8BHdNpc7fcFUcbYMnheJ6tp93JKyFYwnmBUeo0LVp3iZ2nJ_oA19whjrQHAuQREoI5wcCUaD8FAHo0wOhZDpAhlugb1RhhftgQnwK1SHchGdUuEHbkqUUj8jX_iaNU9IeWlKSX6qYX-fNXVlYBHpSZEQICXwFZWTGpSgkeFE0ZA2alaKBhopA');

  if auth.StatusCode = 200 then
   ShowMessage('Conta apagada com sucesso!');
  if auth.Error = enumErrors.NONE then
   begin
    memo1.Lines.Add(auth.uID);
    Memo1.Lines.Add(auth.token);
    Memo1.Lines.Add(auth.RefreshToken);
    Memo1.Lines.Add(auth.ExpiresIn.ToString);
    if auth.Registered then
     Memo1.Lines.Add('Registrado')
    else
     Memo1.Lines.Add('Não Registrado');
    Memo1.Lines.Add(auth.DisplayName);
    Memo1.Lines.Add(auth.Email);
    if auth.EmailVerified then
     Memo1.Lines.add('Verificado')
    else
     Memo1.Lines.Add('Não Verificado');
    memo1.Lines.Add(auth.photoUrl);
    Memo1.Lines.Add(auth.lastLoginAt);
    Memo1.Lines.Add(auth.createdAt);
   end
  else
   begin
     ShowMessage('Ocorreu um erro! - ' + auth.StatusCode.ToString);
     case auth.Error of
      EMAIL_EXISTS: ShowMessage('Email já existente');
      OPERATION_NOT_ALLOWED: ShowMessage('Operação não permitida');
      TOO_MANY_ATTEMPTS_TRY_LATER: ShowMessage('Muitas tentativas, tente mais tarde');
      INVALID_EMAIL: ShowMessage('Email inválido');
      WEAK_PASSWORD: ShowMessage('Senha fraca');
      TOKEN_EXPIRED: ShowMessage('Token Expirado');
      INVALID_REFRESH_TOKEN: ShowMessage('Refresh Token inválido');
      EMAIL_NOT_FOUND: ShowMessage('Email não encontrado');
      INVALID_OOB_CODE: ShowMessage('Código inválido');
      INVALID_ID_TOKEN: ShowMessage('idToken inválido');
      USER_NOT_FOUND: ShowMessage('Usuário não encontrado');
      CREDENTIAL_TOO_OLD_LOGIN_AGAIN: ShowMessage('Credencial muito antiga. Faça login novamente');
      INVALID_PASSWORD: ShowMessage('Senha inválida');
      UNKNOWN: ShowMessage('Erro desconhecido');
     end;
   end;
end;

end.
