unit unitMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls,
  ExtCtrls, Grids, IpHtml, Types, fpjson;

type

  { TFormMain }

  TFormMain = class(TForm)
    btEnviarArquivo: TButton;
    btnReadCollection: TButton;
    btnAddRecord: TButton;
    btnUpdateRecord: TButton;
    btnDeleteRecord: TButton;
    btProcurarArquivo: TButton;
    btTrocarSenha: TButton;
    btLoginEntrar: TButton;
    btAtualizarToken: TButton;
    btResetConfirmar: TButton;
    btResetResetar: TButton;
    btResetVerificar: TButton;
    btRegistroRegistrar: TButton;
    btExibirPerfil: TButton;
    btSalvarPerfil: TButton;
    btVerificarEmailEnviaCode: TButton;
    btVerificarEmailVerificaCode: TButton;
    btApagarConta: TButton;
    chFieldDone: TCheckBox;
    eStorageArquivo: TEdit;
    eRealtimeCollection: TEdit;
    eFieldTask: TEdit;
    eFieldCategory: TEdit;
    eStoragePasta: TEdit;
    eResetCode: TEdit;
    eResetNovaSenha: TEdit;
    ePerfilNome: TEdit;
    ePerfilURLFoto: TEdit;
    eRealtimeEndpoint: TEdit;
    eTrocarSenha: TEdit;
    eResetEmail: TEdit;
    eRegistroSenha: TEdit;
    eLoginUsername: TEdit;
    eLoginSenha: TEdit;
    eRegistroUsername: TEdit;
    eVerificarEmail: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    GroupLogin: TGroupBox;
    GroupLogin1: TGroupBox;
    GroupLogin2: TGroupBox;
    GroupRegistro: TGroupBox;
    GroupTokens: TGroupBox;
    GroupTokens1: TGroupBox;
    GroupTokens2: TGroupBox;
    layoutUserName19: TPanel;
    layoutUserName20: TPanel;
    layoutUserName21: TPanel;
    layoutUserName22: TPanel;
    layoutUserName23: TPanel;
    layoutUserName24: TPanel;
    layoutUserName25: TPanel;
    layoutUserName26: TPanel;
    layoutUserName27: TPanel;
    lblLoginSenha12: TLabel;
    lblLoginSenha13: TLabel;
    lblLoginSenha14: TLabel;
    lblLoginSenha15: TLabel;
    lblLoginSenha16: TLabel;
    lblLoginUsername4: TLabel;
    lblLoginUsername5: TLabel;
    lblPerfilEmailVerificado: TLabel;
    layoutUserName18: TPanel;
    lblLoginSenha11: TLabel;
    lblPerfilUltimoAcesso: TLabel;
    lblPerfiluID: TLabel;
    layoutUserName1: TPanel;
    layoutUserName10: TPanel;
    layoutUserName11: TPanel;
    layoutUserName12: TPanel;
    layoutUserName13: TPanel;
    layoutUserName14: TPanel;
    layoutUserName15: TPanel;
    layoutUserName16: TPanel;
    layoutUserName17: TPanel;
    layoutUserName2: TPanel;
    layoutUserName3: TPanel;
    layoutUserName4: TPanel;
    layoutUserName5: TPanel;
    layoutUserName6: TPanel;
    layoutUserName7: TPanel;
    layoutUserName8: TPanel;
    layoutUserName9: TPanel;
    lblLoginSenha1: TLabel;
    lblLoginSenha10: TLabel;
    lblLoginSenha2: TLabel;
    lblLoginSenha3: TLabel;
    lblLoginSenha4: TLabel;
    lblLoginSenha5: TLabel;
    lblLoginSenha6: TLabel;
    lblLoginSenha7: TLabel;
    lblLoginSenha8: TLabel;
    lblLoginSenha9: TLabel;
    lblLoginUsername1: TLabel;
    lblLoginUsername2: TLabel;
    lblLoginUsername3: TLabel;
    lblPerfilEmail: TLabel;
    lblPerfilCriado: TLabel;
    lblToken: TLabel;
    lblLoginUsername: TLabel;
    lblLoginSenha: TLabel;
    lblRefreshToken: TLabel;
    ListBox1: TListBox;
    MemoLog: TMemo;
    layoutUserName: TPanel;
    selectfile: TOpenDialog;
    Panel1: TPanel;
    DataGrid: TStringGrid;
    TabAuth: TPageControl;
    TabServices: TPageControl;
    TabFirebaseAuth: TTabSheet;
    TabFirebaseStorage: TTabSheet;
    TabFirebaseRealtimeDB: TTabSheet;
    TabLogin: TTabSheet;
    TabRegister: TTabSheet;
    TabReset: TTabSheet;
    TabPerfil: TTabSheet;
    TabVerificarEmail: TTabSheet;
    TabApagarConta: TTabSheet;
    procedure btApagarContaClick(Sender: TObject);
    procedure btAtualizarTokenClick(Sender: TObject);
    procedure btEnviarArquivoClick(Sender: TObject);
    procedure btExibirPerfilClick(Sender: TObject);
    procedure btLoginEntrarClick(Sender: TObject);
    procedure btnAddRecordClick(Sender: TObject);
    procedure btnDeleteRecordClick(Sender: TObject);
    procedure btnReadCollectionClick(Sender: TObject);
    procedure btnUpdateRecordClick(Sender: TObject);
    procedure btProcurarArquivoClick(Sender: TObject);
    procedure btRegistroRegistrarClick(Sender: TObject);
    procedure btResetConfirmarClick(Sender: TObject);
    procedure btResetResetarClick(Sender: TObject);
    procedure btResetVerificarClick(Sender: TObject);
    procedure btSalvarPerfilClick(Sender: TObject);
    procedure btTrocarSenhaClick(Sender: TObject);
    procedure btVerificarEmailEnviaCodeClick(Sender: TObject);
    procedure btVerificarEmailVerificaCodeClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure DataGridClick(Sender: TObject);
    procedure DataGridSelection(Sender: TObject; aCol, aRow: Integer);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    fToken, fRefreshToken : string;
    API_KEY               : string;
    PROJECT_ID            : string;
    fID                   : string;
    procedure Add2Log(const texto: string);
    procedure PreencheGrid(const Dados: TJSONArray);
  public

  end;

var
  FormMain: TFormMain;

implementation

{$R *.lfm}

{ TFormMain }

uses
  eFirebase,
  eFirebase.Interfaces,
  eFirebase.Types,
  DotEnv4Delphi;

{$Region 'Funções Auxiliares'}
function ErrorMessage(const msg: enumAuthErrors): string;
begin
  case msg of
    NONE:                            Result := EmptyStr;
    EMAIL_EXISTS:                    Result := 'Já existe uma conta com este e-mail. Informe um outro e-mail para criar uma conta.';
    OPERATION_NOT_ALLOWED:           Result := 'Operação não permitida! Sentimos muito, mas não é possível prosseguir.';
    TOO_MANY_ATTEMPTS_TRY_LATER:     Result := 'Sentimos muito, mas você já efetuou muitas tentativas e não poderá prosseguir. Tente novamente mais tarde.';
    INVALID_EMAIL:                   Result := 'O e-mail informado não é válido. Informe um e-mail válido patra prosseguir.';
    WEAK_PASSWORD:                   Result := 'A senha informada é muito fraca. É necessário informar uma senha com pelo menos 6 digitos. Tente novamente!';
    EMAIL_NOT_FOUND:                 Result := 'E-mail informado não encontrado, portanto não foi possível encontrar um usuário no sistema!';
    USER_DISABLED:                   Result := 'Sentimos muito, mas o seu usuário encontra-se desabilitado. Converse com o administrador.';
    TOKEN_EXPIRED:                   Result := 'O token de usuário informado encontra-se expirado. Utilize o RefreshToken para obter um novo Token ou faça o login novamente.';
    USER_NOT_FOUND:                  Result := 'Usuário informado não encontrado. Tente novamente.';
    INVALID_REFRESH_TOKEN:           Result := 'O RefreshToken informado é inválido. Impossível obter novo token com este RefreshToken.';
    INVALID_GRANT_TYPE:              Result := 'Permissões inválidas.';
    MISSING_REFRESH_TOKEN:           Result := 'Não foi possível encontrar o RefreshToken informado.';
    EXPIRED_OOB_CODE:                Result := 'Código de resgate expirou.';
    INVALID_OOB_CODE:                Result := 'Código de resgate inválido.';
    INVALID_ID_TOKEN:                Result := 'Token informado é inválido.';
    CREDENTIAL_TOO_OLD_LOGIN_AGAIN:  Result := 'Credenciais vencidas. Faça o login novamente.';
    INVALID_PASSWORD:                Result := 'Senha inválida.';
    UNKNOWN:                         Result := 'Ocorreu um erro desconhecido. Tente novamente.';
  end;
end;
procedure TFormMain.Add2Log(const texto: string);
begin
  MemoLog.Lines.Add(texto);
end;
function RemoveQuotes(const value: string): string;
begin
  Result := StringReplace(value, '"', '', [rfReplaceAll]);
end;
procedure TFormMain.PreencheGrid(const Dados: TJSONArray);
var
 Registro : TJSONObject;
 i        : Integer;
begin
  DataGrid.RowCount := 0;

  if Dados.Count > 0 then
   begin

    DataGrid.RowCount := Dados.Count + 1;

    for i := 0 to Dados.Count-1 do
     begin
       Registro := Dados.Items[i] as TJSONObject;
       DataGrid.Cells[0, i + 1] := RemoveQuotes(Registro.Find('done').AsJSON);
       DataGrid.Cells[1, i + 1] := RemoveQuotes(Registro.Find('id').AsJSON);
       DataGrid.Cells[2, i + 1] := RemoveQuotes(Registro.Find('task').AsJSON);
       DataGrid.Cells[3, i + 1] := RemoveQuotes(Registro.Find('category').AsJSON);
     end;

   end;
end;
{$EndRegion}

procedure TFormMain.FormCreate(Sender: TObject);
begin
  //Setando o título da aplicação concateando com a versão do eFirebase obtida através do comando teFirebase.Version
  Self.Caption := 'Simple Demo (LAZARUS) - eFirebase version ' + TeFirebase.Version;

  //Setando aba inicial (a de login)
  TabServices.ActivePage := TabFirebaseAuth;

  //Abrir na página de Login
  TabAuth.ActivePage := TabLogin;

  //inicializando as  variáveis que vão abrigar os tokens necessários para outras ações
  fToken        := EmptyStr;
  fRefreshToken := EmptyStr;

  //lendo variáveis de ambiente necessárias contidas no arquivo .env usando a lib DotEnv4Delphi
  API_Key    := DotEnv.Env('APIKey');     //A API Key é obtida no Firebase, necessário para maioria das funções do Firebase
  Project_ID := DotEnv.Env('ProjectId');  //O ProjectID é necessário para muitas funções do Firebase

  //Variável para guardar o ID do usuário
  fID := EmptyStr;
end;

procedure TFormMain.FormShow(Sender: TObject);
begin
  eLoginUsername.SetFocus;
end;

{$Region 'Funções Firebase Auth'}
procedure TFormMain.btLoginEntrarClick(Sender: TObject);
//Este método é para realizar o login na conta cadastrada de usuário no Firebase
var
  //Variavel para guardar o retorno dos métodos do Firebase Auth
  Login : ieFirebaseResponseAuth;
begin
  //Fazendo verificações para garantir que há os dados de Usuário e senha
  if eLoginUsername.Text = EmptyStr then
   begin
     ShowMessage('É necessário informar um e-mail para efetuar login.');
     Exit;
   end;

  if eLoginSenha.Text = EmptyStr then
   begin
     ShowMessage('É necessário informar uma senha para efetuar login.');
     Exit;
   end;

  try
    //Chamada para realizar login do Firebase Auth
    Login := TeFirebase.New
                         .Auth(API_Key)
                           .SignInWithEmailPassword(eLoginUsername.Text, eLoginSenha.Text);
  except
    Add2Log('Firebase Auth -> Login falhou!');
  end;

  //Verificação se obteve sucesso ao logar
  if Login.StatusCode = 200 then
   begin
     Add2Log('Firebase Auth -> Login efetuado com sucesso!');
     //Guardar Tokens para serem usados (extremamente importante, são o que garante que vc está "conectado"
     fToken        := Login.token;
     fRefreshToken := Login.RefreshToken;
     Add2Log(fRefreshToken);

     LblToken.Caption        := fToken;
     LblRefreshToken.Caption := fRefreshToken;
     lblToken.WordWrap := True;
     lblRefreshToken.WordWrap := True;
   end
  else
   begin
     Add2Log('Firebase Auth -> Login falhou: ' + ErrorMessage(Login.Error) + #13 + 'Status Code = ' + Login.StatusCode.ToString);
     ShowMessage('Firebase Auth -> Login falhou: ' + ErrorMessage(Login.Error) + #13 + 'Status Code = ' + Login.StatusCode.ToString);
   end;
end;

procedure TFormMain.btnAddRecordClick(Sender: TObject);
var
 Registro : TJsonObject;
 Bd       : ieFirebaseRealtimeResponse;
begin
  if fToken = EmptyStr then
   begin
     ShowMessage('Esta função só funcionará após fazer login ou criar uma conta!');
     Exit;
   end;

  Registro := TJSONObject.Create;
  try
    Registro.Add('task', eFieldTask.Text);
    Registro.Add('category', eFieldCategory.Text);
    Registro.Add('done', false);

    Bd := TeFirebase.New
                      .RealTimeDB(Project_ID)
                        .AccessToken(fToken)
                        .Endpoint(eRealtimeEndpoint.Text)
                        .Collection(eRealtimeCollection.Text)
                          .CreateRegister(Registro.AsJSON);

  finally
    Registro.Free;
  end;

  btnReadCollectionClick(nil);
end;

procedure TFormMain.btnDeleteRecordClick(Sender: TObject);
var
  fDelete : ieFirebaseRealtimeResponse;
begin
  if fToken = EmptyStr then
   begin
     ShowMessage('Esta função só funcionará após fazer login ou criar uma conta!');
     Exit;
   end;

   if MessageDlg('Deseja realmente apagar o registro selecionado?', TMsgDlgType.mtConfirmation, mbYesNo, 0) = mrNo then
    Exit;

  fDelete := TeFirebase.New
                         .RealTimeDB(Project_ID)
                          .AccessToken(fToken)
                          .Endpoint(eRealtimeEndpoint.Text)
                          .Collection(eRealtimeCollection.Text)
                            .DeleteRegister(fID);

  if fDelete.StatusCode <> 200 then
   begin
     ShowMessage('Ocorreu um erro ao tentar excluir o registro!');
     Exit;
   end;

  ShowMessage('Registro apagado com sucesso!');
  btnReadCollectionClick(nil);
end;

procedure TFormMain.btnReadCollectionClick(Sender: TObject);
var
 DataTable : ieFirebaseRealtimeResponse;
 JArray    : TJSONArray;
begin
  if fToken = EmptyStr then
   begin
     ShowMessage('Esta função só funcionará após fazer login ou criar uma conta!');
     Exit;
   end;

  DataTable := TeFirebase.New
                           .RealTimeDB(Project_ID)
                             .AccessToken(fToken)
                             .Endpoint(eRealtimeEndPoint.Text)
                             .Collection(eRealtimeCollection.Text)
                             .ReadWithoutFilters;

  if DataTable.StatusCode = 200 then
   begin
     JArray := DataTable.AsJSONArray;
     PreencheGrid(JArray);
     JArray.Free;
   end;
end;

procedure TFormMain.btnUpdateRecordClick(Sender: TObject);
var
  Body    : TJSONObject;
  fUpdate : ieFirebaseRealtimeResponse;
begin
  if fToken = EmptyStr then
   begin
     ShowMessage('Esta função só funcionará após fazer login ou criar uma conta!');
     Exit;
   end;

  if fID = EmptyStr then
   exit;

  Body := TJSONObject.Create;
  Body.Add('id', fID);
  Body.Add('task', eFieldTask.Text);
  Body.Add('category', eFieldCategory.Text);
  Body.Add('done', chFieldDone.Checked);

  fUpdate := TeFirebase.New
                         .RealTimeDB(Project_ID)
                          .AccessToken(fToken)
                          .Endpoint(eRealtimeEndpoint.Text)
                          .Collection(eRealtimeCollection.Text)
                            .UpdateRegister(Body.AsJSON, fID);

  Body.Free;

  btnReadCollectionClick(nil);
end;

procedure TFormMain.btProcurarArquivoClick(Sender: TObject);
begin
  if SelectFile.Execute then
   begin
     eStorageArquivo.Text := SelectFile.FileName;
   end;
end;

procedure TFormMain.btRegistroRegistrarClick(Sender: TObject);
//Método para criar nova conta de usuário no Firebase Auth
var
  //Variavel para guardar o retorno dos métodos do Firebase Auth
  fRegister : ieFirebaseResponseAuth;
begin
  //Fazendo verificações para garantir que há os dados de Usuário e senha
  if eRegistroUsername.Text = EmptyStr then
   begin
     ShowMessage('É necessário informar um e-mail para criar uma conta.');
     Exit;
   end;

  if eRegistroSenha.Text = EmptyStr then
   begin
     ShowMessage('É necessário informar uma senha para criar uma conta.');
     Exit;
   end;

  try
    //Chamada para efetuar criação de nova conta de usuário no Firebase Auth
    fRegister := TeFirebase.New
                         .Auth(API_Key)
                           .SignUpWithEmailPassword(eRegistroUsername.Text, eRegistroSenha.Text);
  except
    Add2Log('Firebase Auth -> SignUp falhou!');
  end;

  //Verificação se obteve sucesso ao criar conta
  if fRegister.StatusCode = 200 then
   begin
     Add2Log('Firebase Auth -> SignUp efetuado com sucesso!');
     //Guardar Tokens para serem usados (extremamente importante, são o que garante que vc está "conectado"
     fToken        := fRegister.token;
     fRefreshToken := fRegister.RefreshToken;

     MessageDlg('Conta criada com sucesso', 'Sua conta de usuário no sistema foi criada com sucesso!', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], '');

     LblToken.Caption        := fToken;
     LblRefreshToken.Caption := fRefreshToken;
     lblToken.WordWrap := True;
     lblRefreshToken.WordWrap := True;
   end
  else
   begin
     Add2Log('Firebase Auth -> SignUp falhou: ' + ErrorMessage(fRegister.Error) + #13 + 'Status Code = ' + fRegister.StatusCode.ToString);
     ShowMessage('Firebase Auth -> SignUp falhou: ' + ErrorMessage(fRegister.Error) + #13 + 'Status Code = ' + fRegister.StatusCode.ToString);
   end;
end;

procedure TFormMain.btResetConfirmarClick(Sender: TObject);
//Método para registrar nova senha, para tal precisa ser informado o código enviado para e-mail e a nova senha
var
  ResetSenha : ieFirebaseResponseAuth;
begin
  //Fazendo verificações para garantir que há os dados de Usuário e senha
  if eResetCode.Text = EmptyStr then
   begin
     ShowMessage('É necessário informar o código de resetamento enviado para o e-mail.');
     Exit;
   end;

  if eResetNovaSenha.Text = EmptyStr then
   begin
     ShowMessage('É necessário informar uma nova senha.');
     Exit;
   end;

  //Chamada para efetuar confirmação da nova senha após resetamento de senha
  ResetSenha := TeFirebase.New
                             .Auth(API_Key)
                               .ConfirmPasswordReset(eResetCode.Text, eResetNovaSenha.Text);

  if ResetSenha.StatusCode = 200 then
   begin
     Add2Log('Firebase auth -> Senha resetada com sucesso! Realize o login novamente.');
     ShowMessage('Firebase auth -> Senha resetada com sucesso! Realize o login novamente.');
     TabAuth.ActivePage := TabLogin;
     eLoginSenha.Text := EmptyStr;
     eLoginUsername.Text:= EmptyStr;
     eLoginUsername.SetFocus;
   end
  else
   Begin
     Add2Log('Firebase auth -> Ocorreu um erro ao resetar senha. Erro: ' + ErrorMessage(ResetSenha.Error));
   End;
end;

procedure TFormMain.btResetResetarClick(Sender: TObject);
//Este método é para enviar um e-mail com código para resetar a senha do usuário
var
  //Variavel para guardar o retorno dos métodos do Firebase Auth
  ResetSenha : ieFirebaseResponseAuth;
begin
    //Fazendo verificações para garantir que há o e-mail para enviar o código
  if eResetEmail.Text = EmptyStr then
   begin
     ShowMessage('É necessário informar um e-mail para poder enviar código para resetar a senha.');
     Exit;
   end;

  //Função principal
  ResetSenha := TeFirebase.New
                             .Auth(API_Key)
                               .SendPasswordResetEmail(eResetEmail.Text);

  if ResetSenha.StatusCode = 200 then
   begin
     Add2Log('Firebase auth -> E-mail de reset de senha enviado com sucesso!');
     ShowMessage('Firebase auth -> E-mail de reset de senha enviado com sucesso!');
   end
  else
   Begin
     Add2Log('Firebase auth -> Email Reset falhou. Erro: ' + ErrorMessage(ResetSenha.Error));
   End;
end;

procedure TFormMain.btResetVerificarClick(Sender: TObject);
//Este método é para verificar se código de resetamento de senha é válido
var
  //Variavel para guardar o retorno dos métodos do Firebase Auth
  ResetSenha : ieFirebaseResponseAuth;
begin
  //Fazendo verificações para garantir que há o e-mail para enviar o código
  if eResetCode.Text = EmptyStr then
  begin
   ShowMessage('É necessário informar o código de resetamento de senha enviado para o e-mail informado.');
   Exit;
  end;

   //Função principal
  ResetSenha := TeFirebase.New
                             .Auth(API_Key)
                               .VerifyPasswordResetCode(eResetCode.Text);

  if ResetSenha.StatusCode = 200 then
   begin
     Add2Log('Firebase auth -> Código verificado com sucesso!');
     ShowMessage('Firebase auth -> Código verificado com sucesso!');
   end
  else
   Begin
     Add2Log('Firebase auth -> Código inválido. Erro: ' + ErrorMessage(ResetSenha.Error));
   End;
end;

procedure TFormMain.btSalvarPerfilClick(Sender: TObject);
//Este método salva as alterações feitas ao nome de exibição e UTRL Foto do usuário
var
  //Variavel para guardar o retorno dos métodos do Firebase Auth
  Profile: ieFirebaseResponseAuth;
begin
  if fToken = EmptyStr then
   begin
     ShowMessage('Não é possível acessar o profile sem estar logado. Faça o Login ou crie uma conta.');
     Exit;
   end;

   try
     Profile := TeFirebase.New
                            .Auth(API_Key)
                              .ChangeProfile(fToken, ePerfilNome.Text, ePerfilURLFoto.Text);
  except
    Add2Log('Firebase Auth -> Change Profile falhou!');
  end;

  if Profile.StatusCode = 200 then
   begin
     Add2Log('Firebase Auth -> Change Profile efetuado com sucesso!');

     LblPerfiluID.Caption          := Profile.uID;
     LblPerfilEmail.Caption        := Profile.Email;
     ePerfilNome.Text              := Profile.DisplayName;
     ePerfilURLFoto.Text           := Profile.photoUrl;
     LblPerfilCriado.Caption       := Profile.createdAt;
     lblPerfilUltimoAcesso.Caption := Profile.lastLoginAt;

     if Profile.EmailVerified then
      lblPerfilEmailVerificado.Caption := 'E-mail verificado'
     else
      lblPerfilEmailVerificado.Caption := 'E-mail NÃO verificado!';
   end
  else
   begin
     Add2Log('Firebase Auth -> Change Profile falhou: ' + ErrorMessage(Profile.Error) + #13 + 'Status Code = ' + Profile.StatusCode.ToString);
     ShowMessage('Firebase Auth -> Change Profile falhou: ' + ErrorMessage(Profile.Error) + #13 + 'Status Code = ' + Profile.StatusCode.ToString);
   end;
end;

procedure TFormMain.btTrocarSenhaClick(Sender: TObject);
//Este método é utilizado para trocar a senha da conta
var
  //Variavel para guardar o retorno dos métodos do Firebase Auth
  TrocaSenha : ieFirebaseResponseAuth;
begin
  //Fazendo verificações para garantir que há nova senha
  if eTrocarSenha.Text = EmptyStr then
  begin
   ShowMessage('É necessário informar uma nova senha.');
   Exit;
  end;

   //Função principal
  TrocaSenha := TeFirebase.New
                             .Auth(API_Key)
                               .ChangePassword(fToken, eTrocarSenha.Text);

  if TrocaSenha.StatusCode = 200 then
   begin
     Add2Log('Firebase auth -> Nova Senha salva com sucesso! Realize o login novamente.');
     ShowMessage('Firebase auth -> Nova Senha salva com sucesso! Realize o login novamente.');
     TabAuth.ActivePage := TabLogin;
     eLoginSenha.Text := EmptyStr;
     eLoginUsername.Text:= EmptyStr;
     eLoginUsername.SetFocus;
   end
  else
   Begin
     Add2Log('Firebase auth -> Ocorreu um erro ao trocar senha. Erro: ' + ErrorMessage(TrocaSenha.Error));
   End;
end;

procedure TFormMain.btVerificarEmailEnviaCodeClick(Sender: TObject);
//Este método é para enviar o código de verificação para o e-mail cadastrado do usuário
var
  //Variavel para guardar o retorno dos métodos do Firebase Auth
  VerifyEmail : ieFirebaseResponseAuth;
begin
    if fToken = EmptyStr then
   begin
     ShowMessage('Não é possível acessar o verificar e-mail sem estar logado. Faça o Login ou crie uma conta.');
     TabAuth.ActivePage := TabLogin;
     eLoginUsername.SetFocus;
     Exit;
   end;

  VerifyEmail := TeFirebase.New
                             .Auth(API_Key)
                               .SendEmailVerification(fToken);

  if VerifyEmail.StatusCode = 200 then
   begin
     Add2Log('Firebase auth -> Código de verificação de e-mail enviado com sucesso!');
     ShowMessage('Firebase auth -> Código de verificação de e-mail enviado com sucesso!!');
   end
  else
   Begin
     Add2Log('Firebase auth -> Envio de código para verificar email falhou. Erro: ' + ErrorMessage(VerifyEmail.Error));
   End;
end;

procedure TFormMain.btVerificarEmailVerificaCodeClick(Sender: TObject);
//Este método é para validar o código de verificação do e-mail
var
  //Variavel para guardar o retorno dos métodos do Firebase Auth
  VerifyEmail : ieFirebaseResponseAuth;
begin
  if eVerificarEmail.Text = EmptyStr then
 begin
   ShowMessage('Não é possível verificar e-mail sem informar o código recebido pelo e-mail.');
   eVerificarEmail.SetFocus;
   Exit;
 end;

  VerifyEmail := TeFirebase.New
                             .Auth(API_Key)
                               .ConfirmEmailVerification(eVerificarEmail.Text);

  if VerifyEmail.StatusCode = 200 then
   begin
     Add2Log('Firebase auth -> E-mail verificado com sucesso!');
     ShowMessage('Firebase auth -> E-mail verificado com sucesso!');
   end
  else
   Begin
     Add2Log('Firebase auth -> Verificação de e-mail falhou. Erro: ' + ErrorMessage(VerifyEmail.Error));
   End;
end;

procedure TFormMain.Button1Click(Sender: TObject);
begin

end;

procedure TFormMain.DataGridClick(Sender: TObject);
begin

end;

procedure TFormMain.DataGridSelection(Sender: TObject; aCol, aRow: Integer);
begin
  if DataGrid.RowCount < 1 then
   Exit;

  eFieldTask.Text := DataGrid.Cells[2, aRow];
  eFieldCategory.Text := DataGrid.Cells[3, aRow];
  fID := DataGrid.Cells[1, aRow];
  chFieldDone.Checked := DataGrid.Cells[0, aRow].ToBoolean;
end;


procedure TFormMain.btAtualizarTokenClick(Sender: TObject);
//Este método é para pegar um novo token válido usando o Refresh Token (não precisa usar o Usuário e Senha novamente)
var
  //Variavel para guardar o retorno dos métodos do Firebase Auth
  RefreshUser : ieFirebaseResponseAuth;
begin
  //Verifica se há RefreshToken, se não tiver, sai, pois função não funcionaria sem RefreshToken
  if fRefreshToken = EmptyStr then
   Exit;

  //Chamada para executar / atualizar o RefreshToken
  RefreshUser := TeFirebase.New
                             .Auth(API_Key)
                               .ExchangeRefreshToken4idToken(fRefreshToken);

  //Obtendo o resultado
  if RefreshUser.StatusCode = 200 then
   begin
     fToken        := RefreshUser.token;
     fRefreshToken := RefreshUser.RefreshToken;

     LblToken.Caption        := fToken;
     LblRefreshToken.Caption := fRefreshToken;
     lblToken.WordWrap := True;
     lblRefreshToken.WordWrap := True;
   end;
end;

procedure TFormMain.btEnviarArquivoClick(Sender: TObject);
//Este método é para enviar arquivos para o Firebase Storage
var
  Storage : ieFirebaseStorageResponse;
begin
  if fToken = EmptyStr then
   ShowMessage('Não é possível enviar arquivo sem estar logado. Realize o login e tente novamente.');

  if eStorageArquivo.Text = EmptyStr then
   Exit;

  Storage := TeFirebase.New
                         .Storage(Project_ID)
                           .Folder(eStoragePasta.Text)
                           .FileName(eStorageArquivo.Text)
                             .Send(fToken);

  if Storage.StatusCode = 200 then
   begin
     Add2Log('Firebase Storage -> Arquivo enviado com sucesso!');
     ShowMessage('Firebase Storage -> Arquivo enviado com sucesso!');
     ListBox1.Items.Add(Storage.Link);
   end
  else
   begin
     Add2Log('Firebase Storage -> Falha ao tentar enviar arquivo.');
   end;
end;

procedure TFormMain.btApagarContaClick(Sender: TObject);
//Este método apaga conta do usuário
var
  //Variavel para guardar o retorno dos métodos do Firebase Auth
  Profile: ieFirebaseResponseAuth;
begin
  if fToken = EmptyStr then
   begin
     ShowMessage('Não é possível apagar conta sem estar logado. Faça o Login ou crie uma conta.');
     Exit;
   end;

   if MessageDlg('Deseja realmente apagar sua conta?', TMsgDlgType.mtConfirmation, mbYesNo, 0) = mrNo then
    Exit;

   try
     Profile := TeFirebase.New
                            .Auth(API_Key)
                              .DeleteAccount(fToken);
  except
    Add2Log('Firebase Auth -> Apagar Conta falhou!');
  end;

  if Profile.StatusCode = 200 then
   begin
     Add2Log('Firebase Auth -> Apagar Conta efetuado com sucesso!');

     ShowMessage('Conta excluída com sucesso.');
   end
  else
   begin
     Add2Log('Firebase Auth -> Apagar Conta falhou: ' + ErrorMessage(Profile.Error) + #13 + 'Status Code = ' + Profile.StatusCode.ToString);
     ShowMessage('Firebase Auth -> Apagar Conta falhou: ' + ErrorMessage(Profile.Error) + #13 + 'Status Code = ' + Profile.StatusCode.ToString);
   end;
end;

procedure TFormMain.btExibirPerfilClick(Sender: TObject);
//Este método irá exibir as informações da conta do usuário logado
var
  //Variavel para guardar o retorno dos métodos do Firebase Auth
  Profile : ieFirebaseResponseAuth;
begin
  if fToken = EmptyStr then
   begin
     ShowMessage('Não é possível acessar o profile sem estar logado. Faça o Login ou crie uma conta.');
     TabAuth.ActivePage := TabLogin;
     eLoginUsername.SetFocus;
     Exit;
   end;

   try
     Profile := TeFirebase.New
                            .Auth(API_Key)
                              .GetProfile(fToken);
  except
    Add2Log('Firebase Auth -> Get Profile falhou!');
  end;

  if Profile.StatusCode = 200 then
   begin
     Add2Log('Firebase Auth -> Get Profile efetuado com sucesso!');

     LblPerfiluID.Caption          := Profile.uID;
     LblPerfilEmail.Caption        := Profile.Email;
     ePerfilNome.Text              := Profile.DisplayName;
     ePerfilURLFoto.Text           := Profile.photoUrl;
     LblPerfilCriado.Caption       := Profile.createdAt;
     lblPerfilUltimoAcesso.Caption := Profile.lastLoginAt;

     if Profile.EmailVerified then
      lblPerfilEmailVerificado.Caption := 'E-mail verificado'
     else
      lblPerfilEmailVerificado.Caption := 'E-mail NÃO verificado!';
   end
  else
   begin
     Add2Log('Firebase Auth -> Get Profile falhou: ' + ErrorMessage(Profile.Error) + #13 + 'Status Code = ' + Profile.StatusCode.ToString);
     ShowMessage('Firebase Auth -> Get Profile falhou: ' + ErrorMessage(Profile.Error) + #13 + 'Status Code = ' + Profile.StatusCode.ToString);
   end;
end;

{$EndRegion}

end.

