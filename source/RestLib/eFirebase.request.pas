unit eFirebase.request;

interface

uses
  eFirebase.request.contract,
  eFirebase.response.contract,
  REST.Client;

Type
  TRequest = Class(TInterfacedObject, iRequest)
    Private
     FResponse      : iResponse;
     FRestRequest   : tRESTRequest;
     FRestClient    : tRESTClient;
     FRestResponse  : tRESTResponse;
     FBody          : string;
     Procedure DoJoinComponents;
    Public
     Constructor Create;
     Destructor Destroy; Override;
     Class function New: iRequest;
     function BaseUrl(Const BaseUrl: string): iRequest;
     function Resource(Const Resource : string): iRequest;
     function Body(const body: string): iRequest;
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

{ TRequest }

Uses eFirebase.response, REST.Types;

function TRequest.AddHeaders(const key, value: string): iRequest;
begin
  Result := Self;
  FRestRequest.AddParameter(key, value, TRESTRequestParameterKind.pkHTTPHEADER);
end;

function TRequest.AddParameter(const Key, Value: string): iRequest;
begin
  Result := Self;
  FRestRequest.AddParameter(key, value, TRESTRequestParameterKind.pkQUERY);
end;

function TRequest.BaseUrl(const BaseUrl: string): iRequest;
begin
  Result := self;
  FRestClient.BaseURL := BaseUrl;
end;

function TRequest.Body(const body: string): iRequest;
begin
  Result := Self;
  FBody := body;
end;

constructor TRequest.Create;
begin
   FRestResponse := TRESTResponse.Create(nil);
   FRestClient   := trestclient.Create(nil);
   FRestRequest  := trestrequest.Create(nil);
   FResponse     := tresponse.New(FRestResponse);
   DoJoinComponents;
end;

function TRequest.Delete: iResponse;
begin
  Result := FResponse;

  FRestRequest.Method := trestrequestMethod.rmDELETE;
  FRestRequest.Execute;
end;

destructor TRequest.Destroy;
begin
  FRestRequest.DisposeOf;
  FRestClient.DisposeOf;
  FRestResponse.DisposeOf;
  inherited;
end;

procedure TRequest.DoJoinComponents;
begin
  FRestRequest.Client   := FRestClient;
  FRestRequest.Response := FRestResponse;
end;

function TRequest.Get: iResponse;
begin
  Result := FResponse;

  FRestRequest.Method := trestrequestMethod.rmGET;
  FRestRequest.Execute;
end;

class function TRequest.New: iRequest;
begin
  Result := Self.Create;
end;

function TRequest.Patch: iResponse;
begin
  Result := FResponse;

  FRestRequest.AddBody(FBody, TRESTContentType.ctAPPLICATION_JSON);

  FRestRequest.Method := trestrequestMethod.rmPATCH;
  FRestRequest.Execute;
end;

function TRequest.Post: iResponse;
var
 teste: string;
begin
  FRestRequest.AddBody(FBody, TRESTContentType.ctAPPLICATION_JSON);

  FRestRequest.Method := trestrequestMethod.rmPOST;
  teste := FRestRequest.GetFullRequestURL(true);
  FRestRequest.Execute;

  Result := FResponse;
end;

function TRequest.Put: iResponse;
begin
  Result := FResponse;

  FRestRequest.AddBody(FBody, TRESTContentType.ctAPPLICATION_JSON);

  FRestRequest.Method := trestrequestMethod.rmPUT;
  FRestRequest.Execute;
end;

function TRequest.Resource(const Resource: string): iRequest;
begin
  Result := self;
  FRestRequest.Resource := Resource;
end;

function TRequest.Token(const pToken: string): iRequest;
begin
  if pToken <> '' then
   begin
    FRestRequest.AddParameter('auth', pToken, TRESTRequestParameterKind.pkQUERY);
    Result := Self;
   end
  else
   Result := Self;
end;

end.
