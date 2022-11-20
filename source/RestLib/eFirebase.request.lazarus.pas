unit eFirebase.request.lazarus;

{$IFDEF FPC}
{$mode delphi}
{$ENDIF}

interface

uses
  eFirebase.request.contract,
  eFirebase.response.contract,
  idHTTP,
  System.Classes,
  IdSSLOpenSSL,
  IdSSLOpenSSLHeaders;

Type
  TMethodRequest = (mrGET, mrPOST, mrPUT, mrPATCH, mrDELETE);

  TRequestLazarus = Class(TInterfacedObject, iRequest)
  Private
    FidHTTP   : tidHTTP;
    FBaseURL  : string;
    FResource : string;
    FResponse : iResponse;
    FStreamResult : tstringStream;
    FIdSSLIOHandlerSocketOpenSSL : TIdSSLIOHandlerSocketOpenSSL;
    function BaseUrl(Const BaseUrl: string): iRequest;
    function Resource(Const Resource: string): iRequest;
    function Get: iResponse;
    Function ExecuteRequest(Method: tMethodRequest): iRequest;
    function MakeUrl: string;
  Public
    Constructor Create;
    Destructor Destroy; Override;
    Class function New: iRequest;
  End;

implementation

uses
  eFirebase.response.lazarus, System.SysUtils, idURI;

{ TRequestLazarus }

function TRequestLazarus.BaseUrl(const BaseUrl: string): iRequest;
begin
  Result := Self;
  FBaseURL := BaseUrl;
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
end;

destructor TRequestLazarus.Destroy;
begin
  FreeAndNil(FidHTTP);
  FreeAndNil(FStreamResult);
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
    mrPOST: ;
    mrPUT: ;
    mrPATCH: ;
    mrDELETE: ;
  end;
end;

function TRequestLazarus.Get: iResponse;
begin
  Result := FResponse;
  ExecuteRequest(mrGET);
end;

function TRequestLazarus.MakeUrl: string;
begin
  Result := FBaseURL + '/' + FResource;
end;

class function TRequestLazarus.New: iRequest;
begin
  Result := Self.Create;
end;

function TRequestLazarus.Resource(const Resource: string): iRequest;
begin
  Result := Self;
  FResource := Resource;
end;

end.
