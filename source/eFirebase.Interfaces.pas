unit eFirebase.Interfaces;

interface

uses
  eFirebase.Types, System.Classes;

type

{$region 'Response Interfaces'}
 ieFirebaseResponseAuth = interface
   ['{0C91022C-E81B-4F8F-8849-129AA30D44E0}']
   function uID: string;
   function token: string;
   function RefreshToken: string;
   function ExpiresIn: integer;
   function Registered: Boolean;
   function Error: enumAuthErrors;
   function StatusCode: integer;
   function DisplayName: string;
   function Email: string;
   function EmailVerified: Boolean;
   function photoUrl: string;
   function lastLoginAt: string;
   function createdAt: string;
 end;

 ieFirebaseStorageResponse = interface
   ['{0E922EFE-715B-4848-8A43-B9F4C41E3AD4}']
   function Link           : string;
   function StatusCode     : Integer;
 end;
{$Endregion}

{$Region 'Firebase Services'}
 ieFirebaseAuth = interface
   ['{FC27DC8A-3244-4384-880E-DCD0E5FC6F3E}']
   function SignUpWithEmailPassword(const email, password: string): ieFirebaseResponseAuth;
   function SignInWithEmailPassword(const email, password: string): ieFirebaseResponseAuth;
   function ExchangeRefreshToken4idToken(const RefreshToken: string): ieFirebaseResponseAuth;
   function SendPasswordResetEmail(const email: string): ieFirebaseResponseAuth;
   function VerifyPasswordResetCode(const oobCode: string): ieFirebaseResponseAuth;
   function ConfirmPasswordReset(const oobCode, newPassword: string): ieFirebaseResponseAuth;
   function SendEmailVerification(const token: string): ieFirebaseResponseAuth;
   function ConfirmEmailVerification(const oobCode: string): ieFirebaseResponseAuth;
   function DeleteAccount(const Token: string): ieFirebaseResponseAuth;
   function ChangePassword(const Token, newPassword: string): ieFirebaseResponseAuth;
   function ChangeProfile(const Token, DisplayName, PhotoURL: string): ieFirebaseResponseAuth;
   function GetProfile(const Token: string): ieFirebaseResponseAuth;
 end;

 ieFirebaseRealtime = interface
   ['{8B841477-098C-48A7-80C3-4EE8F43CA10B}']
 end;

 ieFirebaseStorage = interface
   ['{FFD23146-5A08-4EE0-B648-2FA971D3FB63}']
   function Folder(const name: string) : ieFirebaseStorage;
   function FileName(const name: string) : ieFirebaseStorage;
   function Send(const AuthToken: string) : ieFirebaseStorageResponse;
 end;

 ieFirebaseFirestore = interface
   ['{37115E16-A873-4C71-B658-8AFA09B84BEA}']
 end;
{$EndRegion}

 ieFirebase = interface
   ['{A03D3BFF-4A46-41E2-A9F0-41CC2979FAF7}']
   function Auth(const API_Key: string): ieFirebaseAuth;
   function RealTimeDB(const API_Key: string): ieFirebaseRealtime;
   function Storage(const ProjectCode: string): ieFirebaseStorage;
   function Firestore(const API_Key: string): ieFirebaseFirestore;
   function Version: string;
 end;

implementation

end.
