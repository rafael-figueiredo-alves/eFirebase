unit eFirebase.rest;

interface

uses
  eFirebase.request.contract,
  eFirebase.response.contract;

Type
  iRequest = eFirebase.request.contract.iRequest;
  iResponse = eFirebase.response.contract.iResponse;

  TRest = Class
    Public
     Class function New: iRequest;
     class function New2: iRequest;
  End;

implementation

uses
  eFirebase.request, eFirebase.request.lazarus;

{ TMinhaClasse }

class function TRest.New: iRequest;
begin
  Result := TRequest.create;
end;

class function TRest.New2: iRequest;
begin
  Result := TRequestLazarus.Create;
end;

end.
