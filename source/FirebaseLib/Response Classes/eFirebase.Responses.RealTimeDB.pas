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
     {TODO -oRafael -cImplementar : Implementar esta função no futuro, quando descobrir ponto que está dando Access Violation}
     //function AsDataSet(out DataSet: tDataSet) : integer;
  End;

implementation

uses
  System.SysUtils,
  System.Generics.Collections;

{ TeFirebaseRealtimeResponse }

function RemoveQuotes(const text: string) : string;
begin
 Result := text.Replace('"', '');
 Result := Result.TrimLeft;
 Result := Result.TrimRight;
end;

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

{function TeFirebaseRealtimeResponse.AsDataSet(out DataSet: tDataSet) : integer;
var
 arrJSON : TJSONArray;
 Reg     : TJSONObject;
 I       : integer;
 Field   : TField;
 Item    : Integer;
 Valor   : string;
 teste   : string;
 teste1  : Array of TVarRec;
begin
  Result := fStatusCode;
  arrJSON := AsJSONArray;
  try
    if (arrJSON.Count > 0) and Assigned(DataSet) then
     begin
       Reg :=  arrJSON.Items[0] as TJSONObject;

       DataSet.Fields.Clear;

       for I := 0 to Reg.Count - 1 do
        begin
          Field := TStringField.Create(nil);
          Field.FieldKind := fkData;
          Field.FieldName := RemoveQuotes(Reg.Pairs[i].JsonString.ToString);
          DataSet.Fields.Add(Field);
        end;

       DataSet.Open;
       for Item := 0 to arrJSON.Count - 1 do
        begin
         SetLength(teste1, Reg.Count);
         for I := 0 to Reg.Count - 1 do
          begin
            Valor := EmptyStr;
            arrJSON.Items[Item].TryGetValue<string>(RemoveQuotes(Reg.Pairs[i].JsonString.ToString), Valor);
            teste1[i] := TVarRec(Valor);
          end;
         DataSet.AppendRecord(teste1);
        end;
     end;
  finally
    arrJSON.DisposeOf;
  end;
end;}

end.
