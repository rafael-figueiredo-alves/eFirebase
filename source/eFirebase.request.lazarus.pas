unit eFirebase.request.lazarus;

{$IFDEF FPC}
{$mode delphi}
{$ENDIF}

interface

uses
  eFirebase.request.contract,
  eFirebase.response.contract,
  idHTTP;

Type
  TMethodRequest = (mrGET, mrPOST, mrPUT, mrPATCH, mrDELETE);

  TRequestLazarus = Class(TInterfacedObject, iRequest)
  Private
    FidHTTP   : tidHTTP;
    FBaseURL  : string;
    FResource : string;
    FResponse : iResponse;
    function BaseUrl(Const BaseUrl: string): iRequest;
    function Resource(Const Resource: string): iRequest;
    function Get: iResponse;
    Function ExecuteRequest(Method: tMethodRequest): iRequest;
  Public
    Constructor Create;
    Destructor Destroy; Override;
    Class function New: iRequest;
  End;

implementation

uses
  eFirebase.response.lazarus;

{ TRequestLazarus }

function TRequestLazarus.BaseUrl(const BaseUrl: string): iRequest;
begin

end;

constructor TRequestLazarus.Create;
begin
  FidHTTP := TIdHTTP.Create(nil);
  FidHTTP.Request.Connection := 'Keep-Alive';
  FidHTTP.Request.UserAgent := 'User-Agent:Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.96 Safari/537.36';
  FidHTTP.HandleRedirects := true;

  FResponse := tResponseLazarus.new(FidHTTP);


end;

destructor TRequestLazarus.Destroy;
begin

  inherited;
end;

function TRequestLazarus.ExecuteRequest(Method: tMethodRequest): iRequest;
begin
  Result := Self;
  case Method of
    mrGET: ;
    mrPOST: ;
    mrPUT: ;
    mrPATCH: ;
    mrDELETE: ;
  end;
end;

function TRequestLazarus.Get: iResponse;
begin

end;

class function TRequestLazarus.New: iRequest;
begin
  Result := Self.Create;
end;

function TRequestLazarus.Resource(const Resource: string): iRequest;
begin

end;

end.
