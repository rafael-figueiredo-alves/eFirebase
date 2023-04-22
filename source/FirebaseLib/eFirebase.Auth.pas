unit eFirebase.Auth;

interface

uses
 eFirebase.Interfaces;

type

  TeFirebaseAuth = Class(TInterfacedObject, ieFirebaseAuth)
    Private
     fAPI_Key: string;
    Public
     Constructor Create(const API_Key: string);
     Destructor Destroy; Override;
     Class function New(const API_Key: string): ieFirebaseAuth;
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
  End;

  const
   SignUp_URL        = 'https://identitytoolkit.googleapis.com/v1/accounts:signUp';
   SignIn_URL        = 'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword';
   SendPassRestEmail = 'https://identitytoolkit.googleapis.com/v1/accounts:sendOobCode';
   SendEmailVerURL   = 'https://identitytoolkit.googleapis.com/v1/accounts:sendOobCode';
   SecureToken_URL   = 'https://securetoken.googleapis.com/v1/token';
   PasswordReset     = 'https://identitytoolkit.googleapis.com/v1/accounts:resetPassword';
   ConfirmEmail      = 'https://identitytoolkit.googleapis.com/v1/accounts:update';
   DeleteAccountURL  = 'https://identitytoolkit.googleapis.com/v1/accounts:delete';
   ChangePasswordURL = 'https://identitytoolkit.googleapis.com/v1/accounts:update';
   UpdateProfileURL  = 'https://identitytoolkit.googleapis.com/v1/accounts:update';
   GetProfileURL     = 'https://identitytoolkit.googleapis.com/v1/accounts:lookup';

implementation

uses
  eFirebase.Responses.Auth,
  System.JSON,
  eFirebase.rest;

{ TeFirebaseAuth }

function TeFirebaseAuth.ChangePassword(const Token, newPassword: string): ieFirebaseResponseAuth;
var
 ResponseJSON: string;
 RequestBody: TJSONObject;
 RequestBodySTR: string;
 Response: iResponse;
begin
  RequestBody := TJSONObject.Create;
  try
    RequestBody.AddPair('idToken', Token);
    RequestBody.AddPair('password', newPassword);
    RequestBody.AddPair('returnSecureToken', TJSONBool.Create(True));
    RequestBodySTR := RequestBody.ToString;
  finally
    RequestBody.DisposeOf;
  end;

  Response := TRest.New
                      .BaseUrl(ChangePasswordURL)
                        .AddParameter('key', fAPI_Key)
                        .Body(RequestBodySTR)
                        .Post;

  ResponseJSON := Response.Content;
  Result := TeFirebaseResponseAuth.New(ResponseJSON, Response.StatusCode);
end;

function TeFirebaseAuth.ChangeProfile(const Token, DisplayName,PhotoURL: string): ieFirebaseResponseAuth;
var
 ResponseJSON: string;
 RequestBody: TJSONObject;
 RequestBodySTR: string;
 Response: iResponse;
begin
  RequestBody := TJSONObject.Create;
  try
    RequestBody.AddPair('idToken', Token);
    RequestBody.AddPair('displayName', DisplayName);
    RequestBody.AddPair('photoUrl', PhotoURL);
    RequestBody.AddPair('returnSecureToken', TJSONBool.Create(True));
    RequestBodySTR := RequestBody.ToString;
  finally
    RequestBody.DisposeOf;
  end;

  Response := TRest.New
                      .BaseUrl(UpdateProfileUrl)
                        .AddParameter('key', fAPI_Key)
                        .Body(RequestBodySTR)
                        .Post;

  ResponseJSON := Response.Content;
  Result := TeFirebaseResponseAuth.New(ResponseJSON, Response.StatusCode);
end;

function TeFirebaseAuth.ConfirmEmailVerification(const oobCode: string): ieFirebaseResponseAuth;
var
 ResponseJSON: string;
 RequestBody: TJSONObject;
 RequestBodySTR: string;
 Response: iResponse;
begin
  RequestBody := TJSONObject.Create;
  try
    RequestBody.AddPair('oobCode', oobCode);
    RequestBodySTR := RequestBody.ToString;
  finally
    RequestBody.DisposeOf;
  end;

  Response := TRest.New
                      .BaseUrl(ConfirmEmail)
                        .AddParameter('key', fAPI_Key)
                        .Body(RequestBodySTR)
                        .Post;

  ResponseJSON := Response.Content;
  Result := TeFirebaseResponseAuth.New(ResponseJSON, Response.StatusCode);
end;

function TeFirebaseAuth.ConfirmPasswordReset(const oobCode, newPassword: string): ieFirebaseResponseAuth;
var
 ResponseJSON: string;
 RequestBody: TJSONObject;
 RequestBodySTR: string;
 Response: iResponse;
begin
  RequestBody := TJSONObject.Create;
  try
    RequestBody.AddPair('oobCode', oobCode);
    RequestBody.AddPair('newPassword', newPassword);
    RequestBodySTR := RequestBody.ToString;
  finally
    RequestBody.DisposeOf;
  end;

  Response := TRest.New
                      .BaseUrl(PasswordReset)
                        .AddParameter('key', fAPI_Key)
                        .Body(RequestBodySTR)
                        .Post;

  ResponseJSON := Response.Content;
  Result := TeFirebaseResponseAuth.New(ResponseJSON, Response.StatusCode);
end;

constructor TeFirebaseAuth.Create(const API_Key: string);
begin
  fAPI_Key := API_Key;
end;

function TeFirebaseAuth.DeleteAccount(const Token: string): ieFirebaseResponseAuth;
var
 ResponseJSON: string;
 RequestBody: TJSONObject;
 RequestBodySTR: string;
 Response: iResponse;
begin
  RequestBody := TJSONObject.Create;
  try
    RequestBody.AddPair('idToken', token);
    RequestBodySTR := RequestBody.ToString;
  finally
    RequestBody.DisposeOf;
  end;

  Response := TRest.New
                      .BaseUrl(DeleteAccountURL)
                        .AddParameter('key', fAPI_Key)
                        .Body(RequestBodySTR)
                        .Post;

  ResponseJSON := Response.Content;
  Result := TeFirebaseResponseAuth.New(ResponseJSON, Response.StatusCode);
end;

destructor TeFirebaseAuth.Destroy;
begin

  inherited;
end;

function TeFirebaseAuth.ExchangeRefreshToken4idToken(const RefreshToken: string): ieFirebaseResponseAuth;
var
 ResponseJSON: string;
 RequestBody: TJSONObject;
 RequestBodySTR: string;
 Response: iResponse;
begin
  RequestBody := TJSONObject.Create;
  try
    RequestBody.AddPair('grant_type', 'refresh_token');
    RequestBody.AddPair('refresh_token', RefreshToken);
    RequestBodySTR := RequestBody.ToString;
  finally
    RequestBody.DisposeOf;
  end;

  Response := TRest.New
                      .BaseUrl(SecureToken_URL)
                        .AddParameter('key', fAPI_Key)
                        .Body(RequestBodySTR)
                        .Post;

  ResponseJSON := Response.Content;
  Result := TeFirebaseResponseAuth.New(ResponseJSON, Response.StatusCode);
end;

function TeFirebaseAuth.GetProfile(const Token: string): ieFirebaseResponseAuth;
var
 ResponseJSON: string;
 RequestBody: TJSONObject;
 RequestBodySTR: string;
 Response: iResponse;
begin
  RequestBody := TJSONObject.Create;
  try
    RequestBody.AddPair('idToken', token);
    RequestBodySTR := RequestBody.ToString;
  finally
    RequestBody.DisposeOf;
  end;

  Response := TRest.New
                      .BaseUrl(GetProfileURL)
                        .AddParameter('key', fAPI_Key)
                        .Body(RequestBodySTR)
                        .Post;

  ResponseJSON := Response.Content;
  Result := TeFirebaseResponseAuth.New(ResponseJSON, Response.StatusCode);
end;

class function TeFirebaseAuth.New(const API_Key: string): ieFirebaseAuth;
begin
  Result := Self.Create(API_Key);
end;

function TeFirebaseAuth.SendEmailVerification(const token: string): ieFirebaseResponseAuth;
var
 ResponseJSON: string;
 RequestBody: TJSONObject;
 RequestBodySTR: string;
 Response: iResponse;
begin
  RequestBody := TJSONObject.Create;
  try
    RequestBody.AddPair('requestType', 'VERIFY_EMAIL');
    RequestBody.AddPair('idToken', token);
    RequestBodySTR := RequestBody.ToString;
  finally
    RequestBody.DisposeOf;
  end;

  Response := TRest.New
                      .BaseUrl(SendEmailVerURL)
                        .AddParameter('key', fAPI_Key)
                        .Body(RequestBodySTR)
                        .Post;

  ResponseJSON := Response.Content;
  Result := TeFirebaseResponseAuth.New(ResponseJSON, Response.StatusCode);
end;

function TeFirebaseAuth.SendPasswordResetEmail(const email: string): ieFirebaseResponseAuth;
var
 ResponseJSON: string;
 RequestBody: TJSONObject;
 RequestBodySTR: string;
 Response: iResponse;
begin
  RequestBody := TJSONObject.Create;
  try
    RequestBody.AddPair('requestType', 'PASSWORD_RESET');
    RequestBody.AddPair('email', email);
    RequestBodySTR := RequestBody.ToString;
  finally
    RequestBody.DisposeOf;
  end;

  Response := TRest.New
                      .BaseUrl(SendPassRestEmail)
                        .AddParameter('key', fAPI_Key)
                        .Body(RequestBodySTR)
                        .Post;

  ResponseJSON := Response.Content;
  Result := TeFirebaseResponseAuth.New(ResponseJSON, Response.StatusCode);
end;

function TeFirebaseAuth.SignInWithEmailPassword(const email, password: string): ieFirebaseResponseAuth;
var
 ResponseJSON: string;
 RequestBody: TJSONObject;
 RequestBodySTR: string;
 Response: iResponse;
begin
  RequestBody := TJSONObject.Create;
  try
    RequestBody.AddPair('email', email);
    RequestBody.AddPair('password', password);
    RequestBody.AddPair('returnSecureToken', TJSONBool.Create(True));
    RequestBodySTR := RequestBody.ToString;
  finally
    RequestBody.DisposeOf;
  end;

  Response := TRest.New
                      .BaseUrl(SignIn_URL)
                        .AddParameter('key', fAPI_Key)
                        .Body(RequestBodySTR)
                        .Post;

  ResponseJSON := Response.Content;
  Result := TeFirebaseResponseAuth.New(ResponseJSON, Response.StatusCode);
end;

function TeFirebaseAuth.SignUpWithEmailPassword(const email, password: string): ieFirebaseResponseAuth;
var
 ResponseJSON: string;
 RequestBody: TJSONObject;
 RequestBodySTR: string;
 Response: iResponse;
begin
  RequestBody := TJSONObject.Create;
  try
    RequestBody.AddPair('email', email);
    RequestBody.AddPair('password', password);
    RequestBody.AddPair('returnSecureToken', TJSONBool.Create(True));
    RequestBodySTR := RequestBody.ToString;
  finally
    RequestBody.DisposeOf;
  end;

  Response := TRest.New
                      .BaseUrl(SignUp_URL)
                        .AddParameter('key', fAPI_Key)
                        .Body(RequestBodySTR)
                        .Post;

  ResponseJSON := Response.Content;
  Result := TeFirebaseResponseAuth.New(ResponseJSON, Response.StatusCode);
end;

function TeFirebaseAuth.VerifyPasswordResetCode(const oobCode: string): ieFirebaseResponseAuth;
var
 ResponseJSON: string;
 RequestBody: TJSONObject;
 RequestBodySTR: string;
 Response: iResponse;
begin
  RequestBody := TJSONObject.Create;
  try
    RequestBody.AddPair('oobCode', oobCode);
    RequestBodySTR := RequestBody.ToString;
  finally
    RequestBody.DisposeOf;
  end;

  Response := TRest.New
                      .BaseUrl(PasswordReset)
                        .AddParameter('key', fAPI_Key)
                        .Body(RequestBodySTR)
                        .Post;

  ResponseJSON := Response.Content;
  Result := TeFirebaseResponseAuth.New(ResponseJSON, Response.StatusCode);
end;

end.
