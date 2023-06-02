unit UnitMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.TabControl, FMX.Memo.Types,
  FMX.ScrollBox, FMX.Memo, FMX.Layouts, FMX.Edit;

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
    GroupBox1: TGroupBox;
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
    GroupBox2: TGroupBox;
    Layout1: TLayout;
    Label1: TLabel;
    Layout3: TLayout;
    Label2: TLabel;
    bRefreshToken: TButton;
    LToken: TLabel;
    LRefreshToken: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure bEntrarClick(Sender: TObject);
    procedure bRefreshTokenClick(Sender: TObject);
  private
    { Private declarations }
    API_Key       : string;
    Project_ID    : string;
    fToken        : string;
    fRefreshToken : string;
    procedure Add2Log(const log: string);
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
  dotenv4delphi;

procedure TFormMain.Add2Log(const log: string);
begin
  MemoLog.Lines.Add(log);
end;

procedure TFormMain.bEntrarClick(Sender: TObject);
var
  Login : ieFirebaseResponseAuth;
begin
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
   end
  else
   begin
     Add2Log('Firebase Auth -> Login falhou!');
   end;
end;

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
   end;
end;

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
end;

end.
