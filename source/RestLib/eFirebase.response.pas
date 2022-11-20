unit eFirebase.response;

interface

uses
  eFirebase.response.contract,
  rest.Client,
  System.Classes;

Type
  TResponse = Class(TInterfacedObject, iResponse)
    Private
     FRestResponse : tRESTResponse;
    Public
     Constructor Create(ARestResponse: TRESTResponse);
     Destructor Destroy; Override;
     Class function New(ARestResponse: TRESTResponse): iResponse;
     function Content: string;
     function StatusCode: integer;
     function Headers: TStrings;
  End;

implementation

{ TResponse }

function TResponse.Content: string;
begin
  Result := FRestResponse.Content;
end;

constructor TResponse.Create(ARestResponse: TRESTResponse);
begin
  FRestResponse := ARestResponse;
end;

destructor TResponse.Destroy;
begin

  inherited;
end;

function TResponse.Headers: TStrings;
begin
  Result := FRestResponse.Headers;
end;

class function TResponse.New(ARestResponse: TRESTResponse): iResponse;
begin
  Result := Self.Create(ARestResponse);
end;

function TResponse.StatusCode: integer;
begin
  Result := FRestResponse.StatusCode;
end;

end.
