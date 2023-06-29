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
  End;

implementation

uses
  {$IFDEF FPC}
   eFirebase.request.lazarus;
  {$Else}
   eFirebase.request;
  {$Endif}

{ TRest }

class function TRest.New: iRequest;
begin
  {$IFDEF FPC}
  Result := TRequestLazarus.Create
  {$Else}
  Result := TRequest.create;
  {$Endif}
end;

end.
