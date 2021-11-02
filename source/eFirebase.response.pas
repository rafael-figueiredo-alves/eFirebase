unit eFirebase.response;

interface

uses
  eFirebase.response.contract, rest.Client;

Type
  TResponse = Class(TInterfacedObject, iResponse)
    Private
     FRestResponse : tRESTResponse;
    Public
     Constructor Create(ARestResponse: TRESTResponse);
     Destructor Destroy; Override;
     Class function New(ARestResponse: TRESTResponse): iResponse;
     function Content: string;
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

class function TResponse.New(ARestResponse: TRESTResponse): iResponse;
begin
  Result := Self.Create(ARestResponse);
end;

end.
