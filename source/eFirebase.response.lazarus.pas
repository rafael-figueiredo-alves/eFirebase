unit eFirebase.response.lazarus;

interface

uses
  eFirebase.response.contract, IdHTTP;

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
  End;

implementation

uses
  System.Classes;

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

class function TResponseLazarus.New(const response: TIdHTTP): iResponse;
begin
  Result := Self.Create(response);
end;

function TResponseLazarus.StatusCode: integer;
begin
  Result := FidHTTP.Response.ResponseCode;
end;

end.
