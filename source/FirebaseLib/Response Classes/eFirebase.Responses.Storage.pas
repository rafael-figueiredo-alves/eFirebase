unit eFirebase.Responses.Storage;

interface

uses
  eFirebase.Interfaces;

Type
  TeFirebaseStorageResponse = Class(TInterfacedObject, ieFirebaseStorageResponse)
    Private
     fdownloadTokens : string;
     fLink           : string;
     fStatusCode     : Integer;
    Public
     Constructor Create(const Response_content, url: string; StatusCode: integer);
     Destructor Destroy; Override;
     Class function New(const Response_content, url: string; StatusCode: integer): ieFirebaseStorageResponse;
     function Link           : string;
     function StatusCode     : Integer;
  End;

implementation

uses
  {$IFDEF FPC}
    fpjson;
  {$ELSE}
    System.JSON;
  {$ENDIF}

{ TeFirebaseStorageResponse }

constructor TeFirebaseStorageResponse.Create(const Response_content, url: string; StatusCode: integer);
var
  vJSON : TJSONValue;
begin
  fStatusCode     := StatusCode;
  fLink           := '';
  fdownloadTokens := '';

  vJSON := TJSONObject.ParseJSONValue(Response_content);

  if (not Assigned(vJSON)) or (not (vJSON is TJSONObject)) then
   begin
     if Assigned(vJSON) then
      vJSON.DisposeOf;
     exit
   end;

   vJSON := vJSON as TJSONObject;

   vJSON.TryGetValue('downloadTokens', fDownloadTokens);

   if fStatusCode = 200 then
    fLink := url + '?alt=media&token=' + fdownloadTokens
   else
    fLink := '';

   if Assigned(vJSON) then
    vJSON.DisposeOf;
end;

destructor TeFirebaseStorageResponse.Destroy;
begin

  inherited;
end;

function TeFirebaseStorageResponse.Link: string;
begin
  Result := fLink;
end;

class function TeFirebaseStorageResponse.New(const Response_content, Url: string; StatusCode: integer): ieFirebaseStorageResponse;
begin
  Result := Self.Create(Response_content, Url, StatusCode);
end;

function TeFirebaseStorageResponse.StatusCode: Integer;
begin
  Result := fStatusCode;
end;

end.
