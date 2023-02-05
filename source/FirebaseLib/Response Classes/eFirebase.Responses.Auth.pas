unit eFirebase.Responses.Auth;

interface

uses
  eFirebase.Interfaces,
  System.json,
  eFirebase.Types;

Type
  TeFirebaseResponseAuth = Class(TInterfacedObject, ieFirebaseResponseAuth)
  //Classe responsável por tratar as respostas do Firebase Auth
    Private
     fuID          : string;
     fToken        : string;
     fRefreshToken : string;
     fExpiresIn    : integer;
     fRegistered   : Boolean;
     fError        : enumErrors;
    Public
     Constructor Create(const Response_content: string);
     Destructor Destroy; Override;
     Class function New(const Response_content: string): ieFirebaseResponseAuth;
     function uID: string;
     function token: string;
     function RefreshToken: string;
     function ExpiresIn: integer;
     function Registered: Boolean;
     function Error: enumErrors;
  End;

implementation

{ TeFirebaseResponseAuth }

function GetError(const Err_MSG: string): enumErrors;
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
end;

constructor TeFirebaseResponseAuth.Create(const Response_content: string);
var
 vJSON        : TJSONValue;
 oJSON        : TJSONObject;
 ObjError     : TJSONObject;
 ErrorMessage : string;
begin
  vJSON := TJSONObject.ParseJSONValue(Response_content);

  if (not Assigned(vJSON)) or (not (vJSON is TJSONObject)) then
   begin
     if Assigned(vJSON) then
      vJSON.DisposeOf;
     exit
   end;

   oJSON := vJSON as TJSONObject;

   oJSON.TryGetValue('idToken', fToken);

   oJSON.TryGetValue('refreshToken', fRefreshToken);

   oJSON.TryGetValue('localId', fuID);

   oJSON.TryGetValue('ExpiresIn', fExpiresIn);

   oJSON.TryGetValue('registered', fRegistered);

   fError := NONE;

   if oJSON.TryGetValue('error', ObjError) then
    begin
      ObjError.TryGetValue('message', ErrorMessage);

      if ErrorMessage <> '' then
       fError := GetError(ErrorMessage);
    end;

   if Assigned(vJSON) then
    vJSON.DisposeOf;

  if Assigned(oJSON) then
   oJSON.DisposeOf;
end;

destructor TeFirebaseResponseAuth.Destroy;
begin

  inherited;
end;

function TeFirebaseResponseAuth.Error: enumErrors;
begin
  Result := fError;
end;

function TeFirebaseResponseAuth.ExpiresIn: integer;
begin
  Result := ExpiresIn;
end;

class function TeFirebaseResponseAuth.New(const Response_content: string): ieFirebaseResponseAuth;
begin
  Result := Self.Create(Response_content);
end;

function TeFirebaseResponseAuth.RefreshToken: string;
begin
  Result := fRefreshToken;
end;

function TeFirebaseResponseAuth.Registered: Boolean;
begin
  Result := fRegistered;
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
