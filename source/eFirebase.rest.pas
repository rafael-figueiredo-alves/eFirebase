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
     class function GetVersion: string;
  End;

implementation

uses
  eFirebase.request, eFirebase.request.lazarus;

{ TMinhaClasse }

class function TRest.New: iRequest;
begin
  {$IF defined(FPC_FULLVERSION)}
  Result := TRequestLazarus.Create;
  {$Endif}
  Result := TRequest.create;
end;

class function TRest.GetVersion: string;
begin
  Result := '0.0.3-a';
end;

end.
