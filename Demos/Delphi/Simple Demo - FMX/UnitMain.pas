unit UnitMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.TabControl, FMX.Memo.Types,
  FMX.ScrollBox, FMX.Memo, FMX.Layouts, FMX.Edit, FMX.WebBrowser, FMX.ListBox,
  System.Rtti, FMX.Grid.Style, FMX.Grid, System.JSON, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.Bind.EngExt, Fmx.Bind.DBEngExt,
  Fmx.Bind.Grid, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.Components, Data.Bind.Grid, Data.Bind.DBScope, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFormMain = class(TForm)
    TabServices: TTabControl;
    TabFirebaseAuth: TTabItem;
    TabFirebaseStorage: TTabItem;
    TabFirebaseRealtime: TTabItem;
    grLog: TGroupBox;
    MemoLog: TMemo;
    TabControl1: TTabControl;
    TabLogin: TTabItem;
    TabRegistrar: TTabItem;
    TabPass: TTabItem;
    TabProfile: TTabItem;
    TabVerEmail: TTabItem;
    TabDelAccount: TTabItem;
    grEfetuarLogin: TGroupBox;
    LayUser: TLayout;
    LabelUser: TLabel;
    eUserEmail: TEdit;
    LaySenha: TLayout;
    LabelPass: TLabel;
    ePassword: TEdit;
    bLimparSenha: TClearEditButton;
    bExibeSenha: TPasswordEditButton;
    Layout2: TLayout;
    bEntrar: TButton;
    grToken: TGroupBox;
    Layout1: TLayout;
    Label1: TLabel;
    Layout3: TLayout;
    Label2: TLabel;
    bRefreshToken: TButton;
    LToken: TLabel;
    LRefreshToken: TLabel;
    GrRegistrar: TGroupBox;
    Layout4: TLayout;
    lUserEmailReg: TLabel;
    eEmailRegistro: TEdit;
    Layout5: TLayout;
    LSenhaReg: TLabel;
    ESenhaRegistro: TEdit;
    ClearEditButton1: TClearEditButton;
    PasswordEditButton1: TPasswordEditButton;
    Layout6: TLayout;
    bRegistrar: TButton;
    GroupBox1: TGroupBox;
    Layout7: TLayout;
    Label5: TLabel;
    LTokenReg: TLabel;
    Layout8: TLayout;
    Label7: TLabel;
    Button1: TButton;
    LRefTokenReg: TLabel;
    GrPerfil: TGroupBox;
    Layout9: TLayout;
    Layout10: TLayout;
    Label4: TLabel;
    Layout11: TLayout;
    bLerProfile: TButton;
    Button3: TButton;
    Layout12: TLayout;
    Label3: TLabel;
    eDisplayName: TEdit;
    Layout13: TLayout;
    Label6: TLabel;
    Label8: TLabel;
    Layout14: TLayout;
    Label9: TLabel;
    LLastAccess: TLabel;
    Label11: TLabel;
    LCreatedAt: TLabel;
    LuID: TLabel;
    LEmail: TLabel;
    eURLphoto: TEdit;
    bApagarConta: TButton;
    GroupBox2: TGroupBox;
    Layout15: TLayout;
    Label10: TLabel;
    eEmailReset: TEdit;
    Layout16: TLayout;
    Label12: TLabel;
    eSenhaReset: TEdit;
    ClearEditButton2: TClearEditButton;
    PasswordEditButton2: TPasswordEditButton;
    bResetarSenha: TButton;
    bConfNovaSenhaReset: TButton;
    Layout17: TLayout;
    Label13: TLabel;
    eOOBCodeReset: TEdit;
    bVerificarOOBCodeResetar: TButton;
    GroupBox3: TGroupBox;
    Layout19: TLayout;
    Label15: TLabel;
    eNovaSenhaTroca: TEdit;
    ClearEditButton3: TClearEditButton;
    PasswordEditButton3: TPasswordEditButton;
    Layout20: TLayout;
    bTrocaSenha: TButton;
    GroupBox4: TGroupBox;
    Layout18: TLayout;
    Label14: TLabel;
    eCodeEmailVerify: TEdit;
    Layout22: TLayout;
    bEnviarcodigo: TButton;
    lEmailVerificado: TLabel;
    bVerificarEmail: TButton;
    GroupBox5: TGroupBox;
    Layout21: TLayout;
    Label16: TLabel;
    ePastaStorage: TEdit;
    Layout23: TLayout;
    Label17: TLabel;
    eArquivoStorage: TEdit;
    Layout24: TLayout;
    bEnviarArquivo: TButton;
    BSearchFile: TSearchEditButton;
    GroupBox6: TGroupBox;
    Layout25: TLayout;
    SelectFile: TOpenDialog;
    ListBox1: TListBox;
    WebBrowser1: TWebBrowser;
    ListBoxHeader1: TListBoxHeader;
    bNavegar: TButton;
    GroupBox7: TGroupBox;
    Layout26: TLayout;
    Label18: TLabel;
    eEndPoint: TEdit;
    Layout27: TLayout;
    Label19: TLabel;
    eCollection: TEdit;
    Layout28: TLayout;
    bReadCollection: TButton;
    bDeleteRecord: TButton;
    bUpdateRecord: TButton;
    Layout29: TLayout;
    Label20: TLabel;
    eTask: TEdit;
    Label21: TLabel;
    eCategory: TEdit;
    chDone: TCheckBox;
    bAddRecord: TButton;
    GroupBox8: TGroupBox;
    Layout30: TLayout;
    DataGrid: TStringGrid;
    CheckColumn1: TCheckColumn;
    StringColumn1: TStringColumn;
    StringColumn2: TStringColumn;
    StringColumn3: TStringColumn;
    ePesquisa: TEdit;
    bReadWithFilter: TSearchEditButton;
    procedure FormCreate(Sender: TObject);
    procedure bEntrarClick(Sender: TObject);
    procedure bRefreshTokenClick(Sender: TObject);
    procedure bRegistrarClick(Sender: TObject);
    procedure bLerProfileClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure bApagarContaClick(Sender: TObject);
    procedure bResetarSenhaClick(Sender: TObject);
    procedure bVerificarOOBCodeResetarClick(Sender: TObject);
    procedure bConfNovaSenhaResetClick(Sender: TObject);
    procedure bTrocaSenhaClick(Sender: TObject);
    procedure bEnviarcodigoClick(Sender: TObject);
    procedure bVerificarEmailClick(Sender: TObject);
    procedure BSearchFileClick(Sender: TObject);
    procedure bEnviarArquivoClick(Sender: TObject);
    procedure bNavegarClick(Sender: TObject);
    procedure bReadCollectionClick(Sender: TObject);
    procedure bAddRecordClick(Sender: TObject);
    procedure DataGridSelectCell(Sender: TObject; const ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure DataGridCellClick(const Column: TColumn; const Row: Integer);
    procedure bUpdateRecordClick(Sender: TObject);
    procedure bDeleteRecordClick(Sender: TObject);
    procedure bReadWithFilterClick(Sender: TObject);
  private
    { Private declarations }
    API_Key       : string;
    Project_ID    : string;
    fToken        : string;
    fRefreshToken : string;
    fID           : string;
    procedure Add2Log(const log: string);
    procedure PreencheGrid(const Dados: TJSONArray);
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation

{$R *.fmx}

uses
  eFirebase,
  eFirebase.Interfaces,
  eFirebase.Types,
  dotenv4delphi,
  System.DateUtils;

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

procedure TFormMain.Add2Log(const log: string);
begin
  MemoLog.Lines.Add(log);
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

    DataGrid.RowCount := Dados.Count;

    for i := 0 to Dados.Count-1 do
     begin
       Registro := Dados.Items[i] as TJSONObject;
       DataGrid.Cells[0, i] := RemoveQuotes(Registro.GetValue('done').ToString);
       DataGrid.Cells[1, i] := RemoveQuotes(Registro.GetValue('id').ToString);
       DataGrid.Cells[2, i] := RemoveQuotes(Registro.GetValue('task').ToString);
       DataGrid.Cells[3, i] := RemoveQuotes(Registro.GetValue('category').ToString);
     end;

   end;
end;
{$EndRegion}

//-----------------------------------------------------------------------------------------------------------

//Operações relativas ao Firebase Auth
//=================================================

{$Region 'Firebase Auth Functionalities'}
//Logar na conta
procedure TFormMain.bEntrarClick(Sender: TObject);
var
  Login : ieFirebaseResponseAuth;
begin
  if eUserEmail.Text = EmptyStr then
   begin
     ShowMessage('É necessário informar um e-mail para efetuar login.');
     Exit;
   end;

  if ePassword.Text = EmptyStr then
   begin
     ShowMessage('É necessário informar uma senha para efetuar login.');
     Exit;
   end;

  try
    Login := TeFirebase.New
                         .Auth(API_Key)
                           .SignInWithEmailPassword(eUserEmail.Text, ePassword.Text);
  except
    Add2Log('Firebase Auth -> Login falhou!');
  end;

  if Login.StatusCode = 200 then
   begin
     Add2Log('Firebase Auth -> Login efetuado com sucesso!');
     fToken        := Login.token;
     fRefreshToken := Login.RefreshToken;

     LToken.Text        := fToken;
     LRefreshToken.Text := fRefreshToken;
     LTokenReg.Text        := fToken;
     LRefTokenReg.Text := fRefreshToken;
   end
  else
   begin
     Add2Log('Firebase Auth -> Login falhou: ' + ErrorMessage(Login.Error) + #13 + 'Status Code = ' + Login.StatusCode.ToString);
     ShowMessage('Firebase Auth -> Login falhou: ' + ErrorMessage(Login.Error) + #13 + 'Status Code = ' + Login.StatusCode.ToString);
   end;
end;

//Confirmar nova senha após resetamento de senha
procedure TFormMain.bConfNovaSenhaResetClick(Sender: TObject);
var
  ResetSenha : ieFirebaseResponseAuth;
begin
  ResetSenha := TeFirebase.New
                             .Auth(API_Key)
                               .ConfirmPasswordReset(eOOBCodeReset.Text, eSenhaReset.Text);

  if ResetSenha.StatusCode = 200 then
   begin
     Add2Log('Firebase auth -> Senha resetada com sucesso! Realize o login novamente.');
     ShowMessage('Firebase auth -> Senha resetada com sucesso! Realize o login novamente.');
   end
  else
   Begin
     Add2Log('Firebase auth -> Ocorreu um erro ao resetar senha. Erro: ' + ErrorMessage(ResetSenha.Error));
   End;
end;

procedure TFormMain.bDeleteRecordClick(Sender: TObject);
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
                          .Endpoint(eEndPoint.Text)
                          .Collection(eCollection.Text)
                            .DeleteRegister(fID);

  if fDelete.StatusCode <> 200 then
   begin
     ShowMessage('Ocorreu um erro ao tentar excluir o registro!');
     Exit;
   end;

  ShowMessage('Registro apagado com sucesso!');
  bReadCollectionClick(nil);
end;

//Apagar Conta
procedure TFormMain.bApagarContaClick(Sender: TObject);
var
  Profile: ieFirebaseResponseAuth;
begin
  if fToken = EmptyStr then
   begin
     ShowMessage('Não é possível acessar o profile sem estar logado. Faça o Login ou crie uma conta.');
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

//Envio de código de verificação de e-mail


procedure TFormMain.bEnviarcodigoClick(Sender: TObject);
var
  VerifyEmail : ieFirebaseResponseAuth;
begin
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

//Ler profile do usuário
procedure TFormMain.bLerProfileClick(Sender: TObject);
var
  Profile : ieFirebaseResponseAuth;
begin
  if fToken = EmptyStr then
   begin
     ShowMessage('Não é possível acessar o profile sem estar logado. Faça o Login ou crie uma conta.');
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

     LuID.Text         := Profile.uID;
     LEmail.Text       := Profile.Email;
     eDisplayName.Text := Profile.DisplayName;
     eURLphoto.Text    := Profile.photoUrl;
     LCreatedAt.Text   := Profile.createdAt;
     LLastAccess.Text  := Profile.lastLoginAt;
     //LCreatedAt.Text   := DateTimeToStr(UnixToDateTime(Copy(Profile.createdAt, 1, length(Profile.createdAt) - 3).ToInt64, False));
     //LLastAccess.Text  := DateTimeToStr(UnixToDateTime(Copy(Profile.lastLoginAt, 1, length(Profile.createdAt) - 3).ToInt64, False));
     if Profile.EmailVerified then
      lEmailVerificado.Text := 'E-mail verificado'
     else
      lEmailVerificado.Text := 'E-mail NÃO verificado!';
   end
  else
   begin
     Add2Log('Firebase Auth -> Get Profile falhou: ' + ErrorMessage(Profile.Error) + #13 + 'Status Code = ' + Profile.StatusCode.ToString);
     ShowMessage('Firebase Auth -> Get Profile falhou: ' + ErrorMessage(Profile.Error) + #13 + 'Status Code = ' + Profile.StatusCode.ToString);
   end;
end;

//Atualizar Token através do RefreshToken
procedure TFormMain.bRefreshTokenClick(Sender: TObject);
var
  RefreshUser : ieFirebaseResponseAuth;
begin
  if fRefreshToken = EmptyStr then
   Exit;

  RefreshUser := TeFirebase.New
                             .Auth(API_Key)
                               .ExchangeRefreshToken4idToken(fRefreshToken);

  if RefreshUser.StatusCode = 200 then
   begin
     fToken        := RefreshUser.token;
     fRefreshToken := RefreshUser.RefreshToken;

     LToken.Text        := fToken;
     LRefreshToken.Text := fRefreshToken;
     LTokenReg.Text     := fToken;
     LRefTokenReg.Text  := fRefreshToken;
   end;
end;

//Criar uma nova conta
procedure TFormMain.bRegistrarClick(Sender: TObject);
var
  fRegister : ieFirebaseResponseAuth;
begin
  if eEmailRegistro.Text = EmptyStr then
   begin
     ShowMessage('É necessário informar um e-mail para criar uma conta.');
     Exit;
   end;

  if ESenhaRegistro.Text = EmptyStr then
   begin
     ShowMessage('É necessário informar uma senha para criar uma conta.');
     Exit;
   end;

  try
    fRegister := TeFirebase.New
                         .Auth(API_Key)
                           .SignUpWithEmailPassword(eEmailRegistro.Text, ESenhaRegistro.Text);
  except
    Add2Log('Firebase Auth -> SignUp falhou!');
  end;

  if fRegister.StatusCode = 200 then
   begin
     Add2Log('Firebase Auth -> SignUp efetuado com sucesso!');
     fToken        := fRegister.token;
     fRefreshToken := fRegister.RefreshToken;

     LToken.Text        := fToken;
     LRefreshToken.Text := fRefreshToken;
     LTokenReg.Text        := fToken;
     LRefTokenReg.Text := fRefreshToken;
   end
  else
   begin
     Add2Log('Firebase Auth -> SignUp falhou: ' + ErrorMessage(fRegister.Error) + #13 + 'Status Code = ' + fRegister.StatusCode.ToString);
     ShowMessage('Firebase Auth -> SignUp falhou: ' + ErrorMessage(fRegister.Error) + #13 + 'Status Code = ' + fRegister.StatusCode.ToString);
   end;
end;

//Resetar senha (enviar e-mail com código)
procedure TFormMain.bResetarSenhaClick(Sender: TObject);
var
  ResetSenha : ieFirebaseResponseAuth;
begin
  ResetSenha := TeFirebase.New
                             .Auth(API_Key)
                               .SendPasswordResetEmail(eEmailReset.Text);

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

//Efetuar troca de senha
procedure TFormMain.bTrocaSenhaClick(Sender: TObject);
var
  TrocaSenha : ieFirebaseResponseAuth;
begin
  TrocaSenha := TeFirebase.New
                             .Auth(API_Key)
                               .ChangePassword(fToken, eNovaSenhaTroca.Text);

  if TrocaSenha.StatusCode = 200 then
   begin
     Add2Log('Firebase auth -> Nova Senha salva com sucesso! Realize o login novamente.');
     ShowMessage('Firebase auth -> Nova Senha salva com sucesso! Realize o login novamente.');
   end
  else
   Begin
     Add2Log('Firebase auth -> Ocorreu um erro ao trocar senha. Erro: ' + ErrorMessage(TrocaSenha.Error));
   End;
end;

//Modificar informações do Profile (nome e URL da foto)
procedure TFormMain.Button3Click(Sender: TObject);
var
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
                              .ChangeProfile(fToken, eDisplayName.Text, eURLphoto.Text);
  except
    Add2Log('Firebase Auth -> Change Profile falhou!');
  end;

  if Profile.StatusCode = 200 then
   begin
     Add2Log('Firebase Auth -> Change Profile efetuado com sucesso!');

     LuID.Text         := Profile.uID;
     LEmail.Text       := Profile.Email;
     eDisplayName.Text := Profile.DisplayName;
     eURLphoto.Text    := Profile.photoUrl;
     LCreatedAt.Text   := Profile.createdAt;
     LLastAccess.Text  := Profile.lastLoginAt;
   end
  else
   begin
     Add2Log('Firebase Auth -> Change Profile falhou: ' + ErrorMessage(Profile.Error) + #13 + 'Status Code = ' + Profile.StatusCode.ToString);
     ShowMessage('Firebase Auth -> Change Profile falhou: ' + ErrorMessage(Profile.Error) + #13 + 'Status Code = ' + Profile.StatusCode.ToString);
   end;
end;

procedure TFormMain.bUpdateRecordClick(Sender: TObject);
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
  Body.AddPair('id', fID);
  Body.AddPair('task', eTask.Text);
  Body.AddPair('category', eCategory.Text);
  Body.AddPair('done', chDone.IsChecked);

  fUpdate := TeFirebase.New
                         .RealTimeDB(Project_ID)
                          .AccessToken(fToken)
                          .Endpoint(eEndPoint.Text)
                          .Collection(eCollection.Text)
                            .UpdateRegister(Body.ToString, fID);

  Body.DisposeOf;

  bReadCollectionClick(nil);
end;

//Confirmar e-mail (verificação de e-mail)
procedure TFormMain.bVerificarEmailClick(Sender: TObject);
var
  VerifyEmail : ieFirebaseResponseAuth;
begin
  VerifyEmail := TeFirebase.New
                             .Auth(API_Key)
                               .ConfirmEmailVerification(eCodeEmailVerify.Text);

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

//Verificar código oob para resetar senha
procedure TFormMain.bVerificarOOBCodeResetarClick(Sender: TObject);
var
  ResetSenha : ieFirebaseResponseAuth;
begin
  ResetSenha := TeFirebase.New
                             .Auth(API_Key)
                               .VerifyPasswordResetCode(eOOBCodeReset.Text);

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

procedure TFormMain.DataGridCellClick(const Column: TColumn;
  const Row: Integer);
begin
  if DataGrid.RowCount = 0 then
   Exit;

  eTask.Text := DataGrid.Cells[2, Row];
  eCategory.Text := DataGrid.Cells[3, Row];
  fID := DataGrid.Cells[1, Row];
  chDone.IsChecked := DataGrid.Cells[0, Row].ToBoolean;
end;

procedure TFormMain.DataGridSelectCell(Sender: TObject; const ACol,
  ARow: Integer; var CanSelect: Boolean);
begin

end;

{$EndRegion}
//-----------------------------------------------------------------------------------------------------------

{$Region 'Firebase Storage functionalities'}
procedure TFormMain.bNavegarClick(Sender: TObject);
begin
  WebBrowser1.Navigate(ListBox1.Selected.Text);
end;

procedure TFormMain.bEnviarArquivoClick(Sender: TObject);
var
  Storage : ieFirebaseStorageResponse;
begin
  if fToken = EmptyStr then
   ShowMessage('Não é possível enviar arquivo sem estar logado. Realize o login e tente novamente.');

  if eArquivoStorage.Text = EmptyStr then
   Exit;

  Storage := TeFirebase.New
                         .Storage(Project_ID)
                           .Folder(ePastaStorage.Text)
                           .FileName(eArquivoStorage.Text)
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

procedure TFormMain.BSearchFileClick(Sender: TObject);
begin
  if SelectFile.Execute then
   begin
     eArquivoStorage.Text := SelectFile.FileName;
   end;
end;
{$EndRegion}

procedure TFormMain.bAddRecordClick(Sender: TObject);
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
    Registro.AddPair('task', eTask.Text);
    Registro.AddPair('category', eCategory.Text);
    Registro.AddPair('done', false);

    Bd := TeFirebase.New
                      .RealTimeDB(Project_ID)
                        .AccessToken(fToken)
                        .Endpoint(eEndPoint.Text)
                        .Collection(eCollection.Text)
                          .CreateRegister(Registro.ToString);

  finally
    Registro.DisposeOf;
  end;

  bReadCollectionClick(nil);
end;

procedure TFormMain.bReadCollectionClick(Sender: TObject);
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
                             .Endpoint(eEndPoint.Text)
                             .Collection(eCollection.Text)
                             .ReadWithoutFilters;

  if DataTable.StatusCode = 200 then
   begin
     JArray := DataTable.AsJSONArray;
     PreencheGrid(JArray);
     JArray.DisposeOf;
   end;
end;

procedure TFormMain.bReadWithFilterClick(Sender: TObject);
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
                             .Endpoint(eEndPoint.Text)
                             .Collection(eCollection.Text)
                             .Read
                               .OrderBy('task')
                                 .startAt(ePesquisa.Text)
                                   .Search;

  if DataTable.StatusCode = 200 then
   begin
     JArray := DataTable.AsJSONArray;
     PreencheGrid(JArray);
     JArray.DisposeOf;
   end;
end;

//Configutrações de inicialização do sistema
procedure TFormMain.FormCreate(Sender: TObject);
begin
  //Setando o título da aplicação concateando com a versão do eFirebase obtida através do comando teFirebase.Version
  Self.Caption := 'Simple Demo (FMX) - eFirebase version ' + TeFirebase.Version;

  //Setando aba inicial (a de login)
  TabServices.ActiveTab := TabFirebaseAuth;

  //inicializando as  variáveis que vão abrigar os tokens necessários para outras ações
  fToken        := EmptyStr;
  fRefreshToken := EmptyStr;

  //lendo variáveis de ambiente necessárias contidas no arquivo .env usando a lib DotEnv4Delphi
  API_Key    := DotEnv.Env('APIKey');
  Project_ID := DotEnv.Env('ProjectId');

  fID := EmptyStr;
end;

end.
