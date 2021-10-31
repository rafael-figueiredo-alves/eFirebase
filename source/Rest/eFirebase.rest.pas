unit eFirebase.rest;

interface

Type
  TRest = Class
    Public
     Class function New: iRestRequest;
  End;

implementation

{ TMinhaClasse }

class function TRest.New: iRestRequest;
begin
  Result := TFRestRequest.create;
end;

end.
