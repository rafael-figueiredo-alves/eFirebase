unit unitMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls,
  ExtCtrls;

type

  { TFormMain }

  TFormMain = class(TForm)
    btAtualizarToken1: TButton;
    btLoginEntrar: TButton;
    btAtualizarToken: TButton;
    btLoginEntrar1: TButton;
    btLoginEntrar2: TButton;
    btLoginEntrar3: TButton;
    btRegistroRegistrar: TButton;
    eLoginSenha1: TEdit;
    eLoginSenha2: TEdit;
    eLoginSenha3: TEdit;
    eLoginUsername1: TEdit;
    eRegistroSenha: TEdit;
    eLoginUsername: TEdit;
    eLoginSenha: TEdit;
    eRegistroUsername: TEdit;
    GroupBox1: TGroupBox;
    GroupLogin: TGroupBox;
    GroupLogin1: TGroupBox;
    GroupRegistro: TGroupBox;
    GroupTokens: TGroupBox;
    GroupTokens1: TGroupBox;
    layoutUserName1: TPanel;
    layoutUserName10: TPanel;
    layoutUserName11: TPanel;
    layoutUserName12: TPanel;
    layoutUserName2: TPanel;
    layoutUserName3: TPanel;
    layoutUserName4: TPanel;
    layoutUserName5: TPanel;
    layoutUserName6: TPanel;
    layoutUserName7: TPanel;
    layoutUserName8: TPanel;
    layoutUserName9: TPanel;
    lblLoginSenha1: TLabel;
    lblLoginSenha2: TLabel;
    lblLoginSenha3: TLabel;
    lblLoginSenha4: TLabel;
    lblLoginSenha5: TLabel;
    lblLoginSenha7: TLabel;
    lblLoginUsername1: TLabel;
    lblLoginUsername2: TLabel;
    lblToken: TLabel;
    lblLoginUsername: TLabel;
    lblLoginSenha: TLabel;
    lblRefreshToken: TLabel;
    MemoLog: TMemo;
    layoutUserName: TPanel;
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
    procedure btAtualizarTokenClick(Sender: TObject);
    procedure btLoginEntrarClick(Sender: TObject);
    procedure btRegistroRegistrarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    fToken, fRefreshToken : string;
    API_KEY               : string;
    PROJECT_ID            : string;
    fID                   : string;
    procedure Add2Log(const texto: string);
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
{$EndRegion}

end.

