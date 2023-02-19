unit eFirebase.Interfaces;

interface

uses
  eFirebase.Types;

type

{$region 'Response Interfaces'}
 ieFirebaseResponseAuth = interface
   ['{0C91022C-E81B-4F8F-8849-129AA30D44E0}']
   function uID: string;
   function token: string;
   function RefreshToken: string;
   function ExpiresIn: integer;
   function Registered: Boolean;
   function Error: enumErrors;
   function StatusCode: integer;
   function DisplayName: string;
   function Email: string;
   function EmailVerified: Boolean;
   function photoUrl: string;
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
 end;
{$EndRegion}

 ieFirebase = interface
   ['{A03D3BFF-4A46-41E2-A9F0-41CC2979FAF7}']
   function Auth(const API_Key: string): ieFirebaseAuth;
   function Version: string;
 end;

implementation

end.
