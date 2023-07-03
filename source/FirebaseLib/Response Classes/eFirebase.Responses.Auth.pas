unit eFirebase.Responses.Auth;

interface

uses
  eFirebase.Interfaces,
  {$IFDEF FPC}
    fpjson,
  {$ELSE}
    System.JSON,
  {$ENDIF}
  eFirebase.Types;

Type
  TeFirebaseResponseAuth = Class(TInterfacedObject, ieFirebaseResponseAuth)
  //Classe responsável por tratar as respostas do Firebase Auth
    Private
     fuID           : string;
     fToken         : string;
     fRefreshToken  : string;
     fExpiresIn     : integer;
     fRegistered    : Boolean;
     fError         : enumAuthErrors;
     fStatusCode    : Integer;
     fDisplayName   : string;
     femail         : string;
     fEmailVerified : Boolean;
     fphotoURL      : string;
     flastLoginAt   : string;
     fcreatedAt     : string;
    Public
     Constructor Create(const Response_content: string; StatusCode: integer);
     Destructor Destroy; Override;
     Class function New(const Response_content: string; StatusCode: integer): ieFirebaseResponseAuth;
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
  End;

implementation

{ TeFirebaseResponseAuth }

Uses
  {$IFDEF FPC}
    DateUtils, SysUtils, jsonparser;
  {$ELSE}
    System.DateUtils, System.SysUtils;
  {$ENDIF}

{$IFDEF FPC}
function GetJSONData(const aJSON: UTF8String): TJSONData;
var
  jParser: TJSONParser;
begin
  Result := nil;
  jParser := TJSONParser.Create(aJSON, True);
  try
    Result := jParser.Parse;
  finally
    jParser.Free;
  end;
end;
{$ENDIF}

function GetError(const Err_MSG: string): enumAuthErrors;
//Função para verificar o tipo de erro e retornar o tipo corretamente
begin
 Result := UNKNOWN;

 if Err_MSG = 'EMAIL_EXISTS' then
  Result := EMAIL_EXISTS;

 if Err_MSG = 'OPERATION_NOT_ALLOWED' then
  Result := OPERATION_NOT_ALLOWED;

 if Err_MSG = 'TOO_MANY_ATTEMPTS_TRY_LATER' then
  Result := TOO_MANY_ATTEMPTS_TRY_LATER;

 if Err_MSG = 'INVALID_EMAIL' then
  Result := INVALID_EMAIL;

 if Err_MSG = 'WEAK_PASSWORD' then
  Result := WEAK_PASSWORD;

 if Err_MSG = 'EMAIL_NOT_FOUND' then
  Result := EMAIL_NOT_FOUND;

 if Err_MSG = 'USER_DISABLED' then
  Result := USER_DISABLED;

 if Err_MSG = 'TOKEN_EXPIRED' then
  Result := TOKEN_EXPIRED;

 if Err_MSG = 'USER_NOT_FOUND' then
  Result := USER_NOT_FOUND;

 if Err_MSG = 'INVALID_REFRESH_TOKEN' then
  Result := INVALID_REFRESH_TOKEN;

 if Err_MSG = 'INVALID_GRANT_TYPE' then
  Result := INVALID_GRANT_TYPE;

 if Err_MSG = 'MISSING_REFRESH_TOKEN' then
  Result := MISSING_REFRESH_TOKEN;

 if Err_MSG = 'EXPIRED_OOB_CODE' then
  Result := EXPIRED_OOB_CODE;

 if Err_MSG = 'INVALID_OOB_CODE' then
  Result := INVALID_OOB_CODE;

 if Err_MSG = 'INVALID_ID_TOKEN' then
  Result := INVALID_ID_TOKEN;

 if Err_MSG = 'CREDENTIAL_TOO_OLD_LOGIN_AGAIN' then
  Result := CREDENTIAL_TOO_OLD_LOGIN_AGAIN;

 if Err_MSG = 'INVALID_PASSWORD' then
  Result := INVALID_PASSWORD;
end;

constructor TeFirebaseResponseAuth.Create(const Response_content: string; StatusCode: integer);
var
 ErrorMessage : string;
 {$IFDEF FPC}
  vJSON        : TJSONData;
  vLastLog     : TJSONString;
  vCreated     : TJSONString;
  vIDToken     : TJSONString;
  vUID         : TJSONString;
  vRefreToken  : TJSONString;
  vErrMsg      : TJSONString;
  vExpIn       : TJSONString;
  vRegistered  : TJSONString;
  vDisplay     : TJSONString;
  vEmail       : TJSONString;
  vPhoto       : TJSONString;
  vVerEmail    : TJSONString;
 {$ELSE}
  vJSON        : TJSONValue;
 {$ENDIF}
 oJSON        : TJSONObject;
 ObjError     : TJSONObject;
 aJSON        : TJSONArray;
 item         : TJSONObject;
begin
   ErrorMessage := '';
   fStatusCode := StatusCode;

  {$IFDEF FPC}
   vJSON := GetJSONData(Response_content);

  if (not Assigned(vJSON)) or (not (vJSON is TJSONObject)) then
   begin
     if Assigned(vJSON) then
      vJSON.Free;
     exit
   end;

   oJSON := vJSON as TJSONObject;

   if oJSON.Find('users', aJSON) then
    begin
      //Clono o obj para um item para evitar AccessViolation
      item := (aJSON.Items[0] as TJSONObject).Clone as TJSONObject;
      //Limpo o objeto anterior
      oJSON.Free;
      //copio o item para dentro do objeto Json vazio
      oJSON := item.Clone as TJSONObject;
      //Libero o item da memória
      //Esta foi a melhor solução para evitar os memoryleaks
      item.Free;
      if oJSON.Find('lastLoginAt', vLastLog) then
       flastLoginAt := vLastLog.AsString;
      if oJSON.Find('createdAt', vCreated) then
       fcreatedAt := vCreated.AsString;
    end;

   if oJSON.Find('lastLoginAt', vLastLog) then
    flastLoginAt := vLastLog.AsString;
   if oJSON.Find('createdAt', vCreated) then
    fcreatedAt := vCreated.AsString;

   if oJSON.Find('idToken', vIDToken) then
    fToken := vIDToken.AsString;

   if fToken = '' then
    if oJSON.Find('id_token', vIDToken) then
     fToken := vIDToken.AsString;

   if oJSON.Find('refreshToken', vRefreToken) then
    fRefreshToken := vRefreToken.AsString;

   if fRefreshToken = '' then
    if oJSON.Find('refresh_token', vRefreToken) then
     fRefreshToken := vRefreToken.AsString;

   if oJSON.Find('localId', vUID) then
    fuID := vUID.AsString;

   if fuID = '' then
    if oJSON.Find('user_id', vUID) then
     fuID := vUID.AsString;

   if not oJSON.Find('expiresIn', vExpIn) then
    if oJSON.Find('expires_in', vExpIn) then
     fExpiresIn := vExpIn.AsInteger;

   if oJSON.Find('registered', vRegistered) then
    fRegistered := vRegistered.AsBoolean;

   if oJSON.Find('displayName', vDisplay) then
    fDisplayName := vDisplay.AsString;

   if oJSON.Find('email', vEmail) then
    femail := vEmail.AsString;

   if oJSON.Find('photoUrl', vPhoto) then
    fphotoURL := vPhoto.AsString;

   if oJSON.Find('emailVerified', vVerEmail) then
    fEmailVerified := vVerEmail.AsBoolean;

   fError := NONE;

   if oJSON.Find('error', ObjError) then
    begin
      if ObjError.Find('message', vErrMsg) then
       ErrorMessage := vErrMsg.AsString;

      if ErrorMessage <> '' then
       fError := GetError(ErrorMessage);
    end;

   if Assigned(oJSON) then
    oJSON.Free;
  {$ELSE}
   vJSON := TJSONObject.ParseJSONValue(Response_content);

  if (not Assigned(vJSON)) or (not (vJSON is TJSONObject)) then
   begin
     if Assigned(vJSON) then
      vJSON.DisposeOf;
     exit
   end;

   oJSON := vJSON as TJSONObject;

   if oJSON.TryGetValue('users', aJSON) then
    begin
      //Clono o obj para um item para evitar AccessViolation
      item := (aJSON.Items[0] as TJSONObject).Clone as TJSONObject;
      //Limpo o objeto anterior
      oJSON.DisposeOf;
      //copio o item para dentro do objeto Json vazio
      oJSON := item.Clone as TJSONObject;
      //Libero o item da memória
      //Esta foi a melhor solução para evitar os memoryleaks
      item.DisposeOf;
      oJSON.TryGetValue('lastLoginAt', flastLoginAt);
      oJSON.TryGetValue('createdAt', fcreatedAt);
    end;

   oJSON.TryGetValue('lastLoginAt', flastLoginAt);
   oJSON.TryGetValue('createdAt', fcreatedAt);

   oJSON.TryGetValue('idToken', fToken);

   if fToken = '' then
    oJSON.TryGetValue('id_token', fToken);

   oJSON.TryGetValue('refreshToken', fRefreshToken);

   if fRefreshToken = '' then
    oJSON.TryGetValue('refresh_token', fRefreshToken);

   oJSON.TryGetValue('localId', fuID);

   if fuID = '' then
    oJSON.TryGetValue('user_id', fuID);

   if not oJSON.TryGetValue('expiresIn', fExpiresIn) then
    oJSON.TryGetValue('expires_in', fExpiresIn);

   oJSON.TryGetValue('registered', fRegistered);

   oJSON.TryGetValue('displayName', fDisplayName);

   oJSON.TryGetValue('email', femail);

   oJSON.TryGetValue('photoUrl', fphotoURL);

   oJSON.TryGetValue('emailVerified', fEmailVerified);

   fError := NONE;

   if oJSON.TryGetValue('error', ObjError) then
    begin
      ObjError.TryGetValue('message', ErrorMessage);

      if ErrorMessage <> '' then
       fError := GetError(ErrorMessage);
    end;

   if Assigned(oJSON) then
    oJSON.DisposeOf;
  {$ENDIF}
end;

function TeFirebaseResponseAuth.createdAt: string;
begin
  if fcreatedAt <> '' then
   Result := DateTimeToStr(UnixToDateTime(Copy(fcreatedAt, 1, length(fcreatedAt) - 3).ToInt64, False))
  else
   Result := '';
end;

destructor TeFirebaseResponseAuth.Destroy;
begin

  inherited;
end;

function TeFirebaseResponseAuth.DisplayName: string;
begin
  Result := fDisplayName;
end;

function TeFirebaseResponseAuth.Email: string;
begin
  Result := femail;
end;

function TeFirebaseResponseAuth.EmailVerified: Boolean;
begin
  Result := fEmailVerified;
end;

function TeFirebaseResponseAuth.Error: enumAuthErrors;
begin
  Result := fError;
end;

function TeFirebaseResponseAuth.ExpiresIn: integer;
begin
  Result := fExpiresIn;
end;

function TeFirebaseResponseAuth.lastLoginAt: string;
begin
  if flastLoginAt <> '' then
   Result := DateTimeToStr(UnixToDateTime(Copy(flastLoginAt, 1, length(flastLoginAt) - 3).ToInt64, False))
  else
   Result := '';
end;

class function TeFirebaseResponseAuth.New(const Response_content: string; StatusCode: integer): ieFirebaseResponseAuth;
begin
  Result := Self.Create(Response_content, StatusCode);
end;

function TeFirebaseResponseAuth.photoUrl: string;
begin
  Result := fphotoURL;
end;

function TeFirebaseResponseAuth.RefreshToken: string;
begin
  Result := fRefreshToken;
end;

function TeFirebaseResponseAuth.Registered: Boolean;
begin
  Result := fRegistered;
end;

function TeFirebaseResponseAuth.StatusCode: integer;
begin
  Result := fStatusCode;
end;

function TeFirebaseResponseAuth.token: string;
begin
  Result := fToken;
end;

function TeFirebaseResponseAuth.uID: string;
begin
  Result := fuID;
end;

end.
