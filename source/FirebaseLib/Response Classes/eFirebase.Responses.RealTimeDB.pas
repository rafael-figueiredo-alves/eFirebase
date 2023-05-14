unit eFirebase.Responses.RealTimeDB;

interface

uses
  eFirebase.Interfaces,
  System.JSON,
  Data.DB;

Type
  TeFirebaseRealtimeResponse = Class(TInterfacedObject, ieFirebaseRealtimeResponse)
    Private
     fResponse   : string;
     fETag       : string;
     fStatusCode : integer;
    Public
     Constructor Create(const Response: string; StatusCode: integer; eTag: string = '');
     Destructor Destroy; Override;
     Class function New(const Response: string; StatusCode: integer; eTag: string = ''): ieFirebaseRealtimeResponse;
     function StatusCode: integer;
     function ETag: string;
     function AsJSONstr: string;
     function AsJSONObj: tJSONObject;
     function AsJSONArray: TJSONArray;
     function AsDataSet: tDataSet;
  End;

implementation

{ TeFirebaseRealtimeResponse }

constructor TeFirebaseRealtimeResponse.Create(const Response: string; StatusCode: integer; eTag: string = '');
begin
  fResponse   := Response;
  fStatusCode := StatusCode;
  fETag       := ETag;
end;

destructor TeFirebaseRealtimeResponse.Destroy;
begin

  inherited;
end;

class function TeFirebaseRealtimeResponse.New(const Response: string; StatusCode: integer; eTag: string = ''): ieFirebaseRealtimeResponse;
begin
  Result := Self.Create(Response, StatusCode, eTag);
end;

function TeFirebaseRealtimeResponse.StatusCode: integer;
begin
  Result := fStatusCode;
end;

function TeFirebaseRealtimeResponse.ETag: string;
begin
  Result := fETag;
end;

function TeFirebaseRealtimeResponse.AsJSONstr: string;
begin
  Result := fResponse;
end;

function TeFirebaseRealtimeResponse.AsJSONObj: tJSONObject;
begin
  Result := TJSONObject.ParseJSONValue(fResponse) As TJSONObject;
end;

function TeFirebaseRealtimeResponse.AsJSONArray: TJSONArray;
begin
  Result := TJSONArray.Create();
end;

function TeFirebaseRealtimeResponse.AsDataSet: tDataSet;
begin
  Result := TDataSet.Create(nil);
end;

end.
