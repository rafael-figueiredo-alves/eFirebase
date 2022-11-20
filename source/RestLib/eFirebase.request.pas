unit eFirebase.request;

interface

uses
  eFirebase.request.contract,
  eFirebase.response.contract,
  REST.Client;

Type
  TRequest = Class(TInterfacedObject, iRequest)
    Private
     FResponse : iResponse;
     FRestRequest : tRESTRequest;
     FRestClient  : tRESTClient;
     FRestResponse : tRESTResponse;
     Procedure DoJoinComponents;
    Public
     Constructor Create;
     Destructor Destroy; Override;
     Class function New: iRequest;
     function BaseUrl(Const BaseUrl: string): iRequest;
     function Resource(Const Resource : string): iRequest;
     function Get: iResponse;
  End;

implementation

{ TRequest }

Uses eFirebase.response, REST.Types;

function TRequest.BaseUrl(const BaseUrl: string): iRequest;
begin
  Result := self;
  FRestClient.BaseURL := BaseUrl;
end;

constructor TRequest.Create;
begin
   FRestResponse := TRESTResponse.Create(nil);
   FRestClient   := trestclient.Create(nil);
   FRestRequest  := trestrequest.Create(nil);
   FResponse     := tresponse.New(FRestResponse);
   DoJoinComponents;
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

function TRequest.Resource(const Resource: string): iRequest;
begin
  Result := self;
  FRestRequest.Resource := Resource;
end;

end.
