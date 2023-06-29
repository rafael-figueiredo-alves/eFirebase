unit eFirebase.request;

interface

uses
  eFirebase.request.contract,
  eFirebase.response.contract,
  REST.Client,
  System.Classes,
  eFirebase.Types,
  REST.Types;

Type
  TRequest = Class(TInterfacedObject, iRequest)
    Private
     FResponse      : iResponse;
     FRestRequest   : tRESTRequest;
     FRestClient    : tRESTClient;
     FRestResponse  : tRESTResponse;
     FBody          : string;
     Procedure DoJoinComponents;
    private
     function GetContentType(const ContentType: string): TRESTContentType;
    Public
     Constructor Create;
     Destructor Destroy; Override;
     Class function New: iRequest;
     function BaseUrl(Const BaseUrl: string): iRequest;
     function Resource(Const Resource : string): iRequest;
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

{ TRequest }

Uses eFirebase.response;

function TRequest.AddHeaders(const key, value: string): iRequest;
begin
  Result := Self;
//  FRestRequest.Params.AddHeader(key, value);
   FRestRequest.Params.AddHeader(key, value);
   FRestRequest.Params.ParameterByName(key).Options := [poDoNotEncode];
  //FRestClient.AddParameter(key, value, TRESTRequestParameterKind.pkHTTPHEADER);
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

function TRequest.Body(const pbody: TStream; const AOwns: Boolean): iRequest;
begin
  Result := Self;
  if not Assigned(body) then
    Exit;
  {$IF COMPILERVERSION <= 29}
    FRESTRequest.AddBody(pbody, TRESTContentType.ctAPPLICATION_OCTET_STREAM);
  {$ELSE}
    FRESTRequest.Body.Add(pbody, TRESTContentType.ctAPPLICATION_OCTET_STREAM);
  {$ENDIF}
  if AOwns then
  begin
    {$IFDEF MSWINDOWS}
      body.Free;
    {$ELSE}
      body.DisposeOf;
    {$ENDIF}
  end;
end;

function TRequest.Body(const pbody: string): iRequest;
begin
  Result := Self;
  FBody := pbody;
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

function TRequest.GetContentType(const ContentType: string): TRESTContentType;
begin
  if (ContentType = 'image/png') then
   Result := TRESTContentType.ctIMAGE_PNG
  else
  if (ContentType = 'image/gif') then
   Result := TRESTContentType.ctIMAGE_GIF
  else
  if (ContentType = 'image/jpg') or (ContentType = 'image/jpeg') then
   Result := TRESTContentType.ctIMAGE_JPEG
  else
  if (ContentType = 'text/plain') then
   Result := TRESTContentType.ctTEXT_PLAIN
  else
  if (ContentType = 'text/csv') then
   Result := TRESTContentType.ctTEXT_CSV
  else
  if (ContentType = 'text/css') then
   Result := TRESTContentType.ctTEXT_CSS
  else
  if (ContentType = 'application/pdf') then
   Result := TRESTContentType.ctAPPLICATION_PDF
  else
  if (ContentType = 'audio/mp3') then
   Result := TRESTContentType.ctAUDIO_MPEG
  else
  if (ContentType = 'audio/ogg') then
   Result := TRESTContentType.ctAUDIO_OGG
  else
   Result := TRESTContentType.ctAPPLICATION_OCTET_STREAM;
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

function TRequest.SendFile(const FileName, ContentType: string): iRequest;
begin
  Result := Self;
  FRestRequest.AddFile(FileName, GetContentType(ContentType));
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
