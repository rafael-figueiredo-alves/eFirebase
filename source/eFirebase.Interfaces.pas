unit eFirebase.Interfaces;

interface

uses
  eFirebase.Types,
  {$IFDEF FPC}
    fpjson,
    Classes;
  {$ELSE}
    System.Classes,
    System.JSON;
  {$ENDIF}

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

 ieFirebaseRealtimeResponse = interface
   ['{ACB9DD87-63DB-4F5C-AE93-E56096560FAB}']
   function StatusCode: integer;
   function ETag: string;
   function AsJSONstr: string;
   function AsJSONObj: tJSONObject;
   function AsJSONArray: TJSONArray;
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

 ieFirebaseRealtimeFilters = interface
   ['{4457A621-512A-4AA0-A09D-258AA0AA5B59}']
   function OrderBy(const kind: eFirebaseOrderByKind): ieFirebaseRealtimeFilters; overload;
   function OrderBy(const fields: string): ieFirebaseRealtimeFilters; overload;
   function startAt(const value: string): ieFirebaseRealtimeFilters; overload;
   function starAt(const value: integer): ieFirebaseRealtimeFilters; overload;
   function endAt(const value: string): ieFirebaseRealtimeFilters; overload;
   function endAt(const value: integer): ieFirebaseRealtimeFilters; overload;
   function equalTo(const value: string): ieFirebaseRealtimeFilters; overload;
   function equalTo(const value: integer): ieFirebaseRealtimeFilters; overload;
   function limitToFirst(const value: integer): ieFirebaseRealtimeFilters;
   function limitToLast(const value: integer): ieFirebaseRealtimeFilters;
   function Search: ieFirebaseRealtimeResponse;
 end;

 ieFirebaseRealtime = interface
   ['{8B841477-098C-48A7-80C3-4EE8F43CA10B}']
   function AccessToken(const Token: string): ieFirebaseRealtime;
   function Endpoint(const url_path: string): ieFirebaseRealtime;
   function Collection(const name: string): ieFirebaseRealtime;
   function ReadWithoutFilters(const id: string = ''): ieFirebaseRealtimeResponse;
   function Read: ieFirebaseRealtimeFilters;
   function CreateRegister(const body: string): ieFirebaseRealtimeResponse;
   function UpdateRegister(const body: string; id: string = ''): ieFirebaseRealtimeResponse;
   function WriteRegister(const body: string; Etag: string = ''): ieFirebaseRealtimeResponse;
   function DeleteRegister(const id: string = ''; Etag: string = ''): ieFirebaseRealtimeResponse;
 end;

 ieFirebaseStorage = interface
   ['{FFD23146-5A08-4EE0-B648-2FA971D3FB63}']
   function Folder(const name: string) : ieFirebaseStorage;
   function FileName(const name: string) : ieFirebaseStorage;
   function Send(const AuthToken: string) : ieFirebaseStorageResponse;
 end;
{$EndRegion}

 ieFirebase = interface
   ['{A03D3BFF-4A46-41E2-A9F0-41CC2979FAF7}']
   function Auth(const API_Key: string): ieFirebaseAuth;
   function RealTimeDB(const ProjectCode: string): ieFirebaseRealtime;
   function Storage(const ProjectCode: string): ieFirebaseStorage;
 end;

implementation

end.
