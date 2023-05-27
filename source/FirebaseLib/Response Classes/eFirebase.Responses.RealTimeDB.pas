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
     function AsDataSet(out DataSet: tDataSet) : integer;
  End;

implementation

uses
  System.SysUtils,
  System.Generics.Collections;

{ TeFirebaseRealtimeResponse }

constructor TeFirebaseRealtimeResponse.Create(const Response: string; StatusCode: integer; eTag: string);
begin
  fResponse   := Response;
  fStatusCode := StatusCode;
  fETag       := ETag;
end;

destructor TeFirebaseRealtimeResponse.Destroy;
begin

  inherited;
end;

class function TeFirebaseRealtimeResponse.New(const Response: string; StatusCode: integer; eTag: string): ieFirebaseRealtimeResponse;
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
  Result := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(fResponse), 0) As TJSONObject;
end;

function TeFirebaseRealtimeResponse.AsJSONArray: TJSONArray;
var
 Obj      : TJSONObject;
 Registro : Integer;
 NewObj   : TJSONObject;
 Par      : integer;
 Valor    : TJsonObject;

 function RemoveQuotes(const text: string) : string;
 begin
   Result := text.Replace('"', '');
   Result := Result.TrimLeft;
   Result := Result.TrimRight;
 end;
begin
  Obj := Self.AsJSONObj;
  try
    Result := TJSONArray.Create;

    for Registro := 0 to Obj.Count-1 do
     begin
       NewObj := TJSONObject.Create;
       NewObj.AddPair('id', RemoveQuotes(Obj.Pairs[Registro].JsonString.ToString));
       Valor := Obj.Pairs[Registro].JsonValue as TJSONObject;
       for Par := 0 to Valor.Count-1 do
        begin
          NewObj.AddPair(RemoveQuotes(Valor.Pairs[par].JsonString.ToString), RemoveQuotes(Valor.Pairs[par].JsonValue.ToString));
        end;
       Result.Add(NewObj);
     end;
  finally
    Obj.DisposeOf;
  end;

end;

function TeFirebaseRealtimeResponse.AsDataSet(out DataSet: tDataSet) : integer;
begin
  Result := fStatusCode;
end;

end.
