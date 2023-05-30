unit UnitMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Memo.Types,
  FMX.ScrollBox, FMX.Memo, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Edit,
  FMX.Objects, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  System.Rtti, FMX.Grid.Style, Data.Bind.EngExt, Fmx.Bind.DBEngExt,
  Fmx.Bind.Grid, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.Components, Data.Bind.Grid, Data.Bind.DBScope, FMX.Grid, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Datasnap.DBClient;

type
  TForm2 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    Button2: TButton;
    Edit1: TEdit;
    OpenDialog1: TOpenDialog;
    Image1: TImage;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Label1: TLabel;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses
  eFirebase, eFirebase.Interfaces, eFirebase.Types, System.JSON;

{$R *.fmx}

procedure TForm2.Button1Click(Sender: TObject);
var
  auth: ieFirebaseResponseAuth;
begin
  auth := TeFirebase.New.Auth('AIzaSyCeUiXhD5rL0QgHoV1C8WkCg17n9n5teew').SignInWithEmailPassword('familia.alves2013@outlook.com', 'Roblox2023');


  if auth.StatusCode = 200 then
   ShowMessage('Conta apagada com sucesso!');
  if auth.Error = enumAuthErrors.NONE then
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

procedure TForm2.Button2Click(Sender: TObject);
var
 Storage : ieFirebaseStorageResponse;
begin
    Storage := TeFirebase
                       .New
                       .Storage('etasks-d6988')
                          .Folder('MeuTeste')
                          .FileName(OpenDialog1.FileName)
                          .Send(Edit1.Text);

  Memo1.Lines.Clear;
  Memo1.Lines.Add(Storage.Link);
  Memo1.Lines.Add(Storage.StatusCode.ToString);
end;

procedure TForm2.Button3Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
   begin
     Image1.Bitmap.LoadFromFile(OpenDialog1.FileName);
   end;
end;

procedure TForm2.Button4Click(Sender: TObject);
var
 RealTime: ieFirebaseRealtimeResponse;
begin
  RealTime := TeFirebase.New
                          .RealTimeDB('etasks-d6988')
                          .Endpoint('/etasks/v1')
                          .Collection('version')
                          .ReadWithoutFilters;
  Memo1.Lines.Add(RealTime.StatusCode.ToString);
  Memo1.Lines.Add(RealTime.ETag);
  Memo1.Lines.Add(RealTime.AsJSONstr);
end;

procedure TForm2.Button5Click(Sender: TObject);
var
 RealTime: ieFirebaseRealtimeResponse;
 arrJSON: tjsonarray;
 teste: string;
begin
  RealTime := TeFirebase.New
                          .RealTimeDB('etasks-d6988')
                          .AccessToken(Edit1.Text)
                          .Endpoint('etasks/v1/categories')
                          .Collection('X6xl2bc50rTBTjEevxySh1SQaMb2')
                          .Read
                          .OrderBy('categoria')
                          .startAt('c')
                          .Search;
  Memo1.Lines.Add(RealTime.StatusCode.ToString);
  Memo1.Lines.Add(RealTime.ETag);
  Memo1.Lines.Add(RealTime.AsJSONstr);
  arrJSON := RealTime.AsJSONArray;
  Memo1.Lines.Add(arrJSON.ToString);
  if arrJSON.Items[0].TryGetValue<string>('id', teste) then
   Memo1.Lines.Add(teste);
  if arrJSON.Items[0].TryGetValue<string>('cat_icon', teste) then
   Memo1.Lines.Add(teste);
  if arrJSON.Items[0].TryGetValue<string>('categoria', teste) then
   Memo1.Lines.Add(teste);
  arrJSON.DisposeOf;

end;

procedure TForm2.FormCreate(Sender: TObject);
begin
   Label2.Text := TeFirebase.Version;
end;

end.
