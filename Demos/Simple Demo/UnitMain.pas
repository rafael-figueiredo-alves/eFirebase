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
  //auth := TeFirebase.New.Auth('AIzaSyCeUiXhD5rL0QgHoV1C8WkCg17n9n5teew').SignInWithEmailPassword('familia.alves2013@outlook.com', 'BloxFruit2023');
  //auth := TeFirebase.New.Auth('AIzaSyCeUiXhD5rL0QgHoV1C8WkCg17n9n5teew').ExchangeRefreshToken4idToken('APJWN8cmrRa-t47ZZn2Q39Uq_Wh-L8jp18d7nsb1XR127M3XWX0v1vMEi-_R5xBkAJJqv1OFUmvpqBJkOVu0VCwZ4V2o9q-vWKoG4h2xYaN2hN4cjuWLVeRO4bkRHLfeooXqlgO3Azq4l_EN4lWzn8EGv8EMS6QOKxIoqnxKIr_ibDphsi-rYBUPPXg9wXYJSEBJIZKG1w1f4YGxfeuSWW5DkGdf9WbIqQ');
  //auth := TeFirebase.New.Auth('AIzaSyCeUiXhD5rL0QgHoV1C8WkCg17n9n5teew').SendPasswordResetEmail('familia.alves2013@outlook.com');
  //auth := TeFirebase.New.Auth('AIzaSyCeUiXhD5rL0QgHoV1C8WkCg17n9n5teew').ConfirmPasswordReset('9qsTlKSOwL2jMcUATDfhjlpZ7ZGCjHM5TamDQvIs3gYAAAGGa4MZ8Q', 'BloxFruit2023');
  auth := TeFirebase.New.Auth('AIzaSyCeUiXhD5rL0QgHoV1C8WkCg17n9n5teew').DeleteAccount('eyJhbGciOiJSUzI1NiIsImtpZCI6ImFlYjMxMjdiMjRjZTg2MDJjO' + 'DEyNDUxZThmZTczZDU4MjkyMDg4N2MiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmd' + 'vb2dsZS5jb20vZXRhc2tzLWQ2OTg4IiwiYXVkIjoiZXRhc2tzLWQ2OTg4IiwiYXV0aF90aW1lIjoxNjc2ODQ2NzM3LC' + 'J1c2VyX2lkIjoiaUxEWHdrdGlxVFZRYzVoNnN2Z3Fyb0tDeUJ3MiIsInN1YiI6ImlMRFh3a3RpcVRWUWM1aDZzdmdxcm9LQ3lCdzIiLCJpYXQiOjE2' + 'NzY4NDY3MzcsImV4cCI6MTY3Njg1MDMzNywiZW1haWwiOiJmYW1pbGlhLmFsdmVzMjA' + 'xM0BvdXRsb29rLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJmaXJlYmFzZSI6eyJpZGVudGl0aWVzIjp7ImVtYWlsIjpbImZhbWlsaWEuYWx2ZXMyMDEzQG91dGxvb2suY29tIl19LCJzaWduX2luX3Byb3ZpZGVyIjoicGFzc3dvcmQifX0.' + 'jslNqiMS3zgnJg9KdVANvstHhvxbYiJoTMHg-iVKjYcUS-l4U46QCgY1ng39UeJM' + 'uWs4U4KCkKhM5VBQmv-ZIs1MEEvCiIl53-LPjA0L272TTWa5ylEwytMIkOTx6P3tvd4TUjNqdVXQ3L7PqdtyUsxwOP3pETuo5Rd8yg-mPHa89o08P4XlvwvzzzYLEOgTTYGXhklK75LGU3uJxdNvke_Sva_TAcXYPFQnx45VAHuQ3RCA_A5WD7N60gAANrqTdJ5Zw1ucChot1I-' + 'ti9YWMfZ76exPEHWfxIKu9hWvv5rFfydwKPZq-URHez9kggk0vCktlmlIVvH7wWH3-GYPkg');
  //auth := TeFirebase.New.Auth('AIzaSyCeUiXhD5rL0QgHoV1C8WkCg17n9n5teew').ConfirmEmailVerification('LsHEEJCAoSs8NoLp3PcmvjW5LpYv_uWhPFAHIpS2-VIAAAGGa6KLyw');

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
     Memo1.Lines.add('Verifivcado')
    else
     Memo1.Lines.Add('Não Verificado');
    memo1.Lines.Add(auth.photoUrl);
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
      UNKNOWN: ShowMessage('Erro desconhecido');
     end;
   end;
end;

end.
