unit eFirebase.response.lazarus;

interface

uses
  eFirebase.response.contract,
  IdHTTP,
  System.Classes;

Type
  TResponseLazarus = Class(TInterfacedObject, iResponse)
  Private
    FidHTTP: TIdHTTP;
  Public
    Constructor Create(Const response: TIdHTTP);
    Destructor Destroy; Override;
    Class function New(const response: TIdHTTP): iResponse;
    function Content: string;
    function StatusCode: integer;
    function Headers: TStrings;
    function StatusMsg: string;
    function ErrorMessage: string;
  End;

implementation

{ TResponseLazarus }

function TResponseLazarus.Content: string;
begin
  Result := tStringStream(FidHTTP.Response.ContentStream).DataString;
end;

Constructor TResponseLazarus.Create(Const response: TIdHTTP);
begin
  FidHTTP := response;
end;

destructor TResponseLazarus.Destroy;
begin

  inherited;
end;

function TResponseLazarus.ErrorMessage: string;
begin
  Result := FidHTTP.Response.ResponseText;
end;

function TResponseLazarus.Headers: TStrings;
begin
  Result := FidHTTP.Response.RawHeaders;
end;

class function TResponseLazarus.New(const response: TIdHTTP): iResponse;
begin
  Result := Self.Create(response);
end;

function TResponseLazarus.StatusCode: integer;
begin
  Result := FidHTTP.Response.ResponseCode;
end;

function TResponseLazarus.StatusMsg: string;
begin
  Result := FidHTTP.Response.ResponseText;
end;

end.
