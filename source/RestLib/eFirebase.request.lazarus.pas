unit eFirebase.request.lazarus;

{$IFDEF FPC}
{$mode delphi}
{$ENDIF}

interface

uses
  eFirebase.request.contract,
  eFirebase.response.contract,
  idHTTP,
  Classes,
  IdSSLOpenSSL,
  IdSSLOpenSSLHeaders,
  IdMultipartFormData;

Type
  TMethodRequest = (mrGET, mrPOST, mrPUT, mrPATCH, mrDELETE);

  TRequestLazarus = Class(TInterfacedObject, iRequest)
  Private
    FidHTTP       : tidHTTP;
    FIdMultiPartFormDataStream: TIdMultiPartFormDataStream;
    FBaseURL      : string;
    FResource     : string;
    FResponse     : iResponse;
    FStreamResult : tstringStream;
    FParams       : TStrings;
    FBody         : TStream;
    FIdSSLIOHandlerSocketOpenSSL : TIdSSLIOHandlerSocketOpenSSL;
    Function ExecuteRequest(Method: tMethodRequest): iRequest;
    function MakeUrl: string;
  Public
    Constructor Create;
    Destructor Destroy; Override;
    Class function New: iRequest;
    function BaseUrl(Const BaseUrl: string): iRequest;
    function Resource(Const Resource: string): iRequest;
    function Body(const pbody: string): iRequest; overload;
    function Body(const pbody: TStream; const AOwns: Boolean): iRequest; overload;
    function SendFile(const FileName, ContentType: string):iRequest;
    function Token(Const pToken: string): iRequest;
    function AddParameter(const Key, Value: string):iRequest;
    function AddHeaders(const key, value: string):iRequest;
    function Get    : iResponse;
    function Post   : iResponse;
    function Patch  : iResponse;
    function Delete : iResponse;
    function Put    : iResponse;
  End;

implementation

uses
  eFirebase.response.lazarus, SysUtils, idURI;

{ TRequestLazarus }

function TRequestLazarus.AddHeaders(const key, value: string): iRequest;
begin
  Result := Self;
  if FidHTTP.Request.CustomHeaders.indexof(key) < 0 then
   FidHTTP.Request.CustomHeaders.AddValue(key, value);
end;

function TRequestLazarus.AddParameter(const Key, Value: string): iRequest;
begin
  Result := Self;
  FParams.Add(Key + '=' + Value);
end;

function TRequestLazarus.BaseUrl(const BaseUrl: string): iRequest;
begin
  Result := Self;
  FBaseURL := BaseUrl;
end;

function TRequestLazarus.Body(const pbody: TStream; const AOwns: Boolean): iRequest;
begin
  Result := Self;
  try
    if not Assigned(FBody) then
      FBody := TStringStream.Create;
    TStringStream(FBody).CopyFrom(pbody, pbody.Size);
    FBody.Position := 0;
  finally
    if AOwns then
    begin
      {$IF DEFINED(MSWINDOWS) OR DEFINED(FPC)}
        pbody.Free;
      {$ELSE}
        pbody.DisposeOf;
      {$ENDIF}
    end;
  end;
end;

function TRequestLazarus.Body(const pbody: string): iRequest;
begin
  Result := Self;
  if not Assigned(FBody) then
   FBody := TStringStream.Create(pbody, TEncoding.UTF8)
  else
   TStringStream(FBody).WriteString(pbody);
  FBody.Position := 0;
end;

constructor TRequestLazarus.Create;
begin
  FidHTTP := TIdHTTP.Create(nil);
  FidHTTP.Request.Connection := 'Keep-Alive';
  FidHTTP.Request.UserAgent := 'User-Agent:Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.96 Safari/537.36';
  FidHTTP.HandleRedirects := true;

  FIdSSLIOHandlerSocketOpenSSL := TIdSSLIOHandlerSocketOpenSSL.Create;
  FIdHTTP.IOHandler := FIdSSLIOHandlerSocketOpenSSL;
  FIdSSLIOHandlerSocketOpenSSL.SSLOptions.SSLVersions := [sslvTLSv1, sslvTLSv1_1, sslvTLSv1_2];

  FResponse := tResponseLazarus.new(FidHTTP);

  FStreamResult := TStringStream.Create;

  Self.AddHeaders('Content-Type', 'application/json');

  FIdMultiPartFormDataStream := TIdMultiPartFormDataStream.Create;

  FParams := TStringList.Create;

  FIdHTTP.HTTPOptions:= [hoKeepOrigProtocol];
end;

function TRequestLazarus.Delete: iResponse;
begin
  Result := FResponse;
  ExecuteRequest(mrDELETE);
end;

destructor TRequestLazarus.Destroy;
begin
  FreeAndNil(FidHTTP);
  FreeAndNil(FIdSSLIOHandlerSocketOpenSSL);
  FreeAndNil(FParams);
  FreeAndNil(FStreamResult);
  if Assigned(FBody) then
   FreeAndNil(FBody);
  if Assigned(FIdMultiPartFormDataStream) then
   FreeAndNil(FIdMultiPartFormDataStream);
  inherited;
end;

function TRequestLazarus.ExecuteRequest(Method: tMethodRequest): iRequest;
begin
  Result := Self;
  case Method of
    mrGET:
          begin
            FidHTTP.Get(tidURI.URLEncode(MakeURL), FStreamResult);
          end;
    mrPOST:
          begin
          if (Assigned(FIdMultiPartFormDataStream) and (FIdMultiPartFormDataStream.Size > 0)) then
            FIdHTTP.Post(TIdURI.URLEncode(MakeURL), FIdMultiPartFormDataStream, FStreamResult)
          else
            FidHTTP.Post(tidURI.URLEncode(MakeURL), FBody, FStreamResult);
          end;
    mrPUT:
          begin
            FidHTTP.Put(tidURI.URLEncode(MakeURL), FBody, FStreamResult);
          end;
    mrPATCH:
          begin
            FidHTTP.Patch(tidURI.URLEncode(MakeURL), FBody, FStreamResult);
          end;
    mrDELETE:
          begin
            FidHTTP.Delete(tidURI.URLEncode(MakeURL), FStreamResult);
          end;
  end;
end;

function TRequestLazarus.Get: iResponse;
begin
  Result := FResponse;
  ExecuteRequest(mrGET);
end;

function TRequestLazarus.MakeUrl: string;
var Param: integer;
begin
  Result := FBaseURL + '/' + FResource;

  if FParams.Count > 0 then
   begin
     Result := Result + '?';
     for Param := 0 to Pred(FParams.Count) do
      begin
        if Param > 0 then
         Result := Result + '&';
        Result := Result + FParams.Strings[Param];
      end;
   end;
end;

class function TRequestLazarus.New: iRequest;
begin
  Result := Self.Create;
end;

function TRequestLazarus.Patch: iResponse;
begin
  Result := FResponse;
  ExecuteRequest(mrPATCH);
end;

function TRequestLazarus.Post: iResponse;
begin
  Result := FResponse;
  ExecuteRequest(mrPOST);
end;

function TRequestLazarus.Put: iResponse;
begin
  Result := FResponse;
  ExecuteRequest(mrPUT);
end;

function TRequestLazarus.Resource(const Resource: string): iRequest;
begin
  Result := Self;
  FResource := Resource;
end;

function TRequestLazarus.SendFile(const FileName, ContentType: string): iRequest;
begin
  Result := Self;
  if not FileExists(FileName) then
   Exit;
  FIdMultiPartFormDataStream.AddFile('data', FileName, ContentType);
end;

function TRequestLazarus.Token(const pToken: string): iRequest;
begin
  Result := Self;
  FParams.Add('auth=' + pToken);
end;

end.
