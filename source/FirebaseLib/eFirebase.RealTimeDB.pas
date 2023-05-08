unit eFirebase.RealTimeDB;

interface

uses
  eFirebase.Interfaces,
  eFirebase.Types;

Type

  TeFirebaseRealtimeDB = Class(TInterfacedObject, ieFireBaseRealtime, ieFirebaseRealtimeFilters)
    Private
     fUrl: string;
    Public
     Constructor Create(const ProjectID: string);
     Destructor Destroy; Override;
     Class function New(const ProjectID: string): ieFireBaseRealtime;

     //ieFirebaseFilters
     function OrderBy(const kind: eFirebaseOrderByKind): ieFirebaseRealtimeFilters; overload;
     function OrderBy(const fields: string): ieFirebaseRealtimeFilters; overload;
     function startAt(const value: string): ieFirebaseRealtimeFilters; overload;
     function starAt(const value: integer): ieFirebaseRealtimeFilters; overload;
     function endAt(const value: string): ieFirebaseRealtimeFilters; overload;
     function endAt(const value: integer): ieFirebaseRealtimeFilters; overload;
     function equalTo(const value: string): ieFirebaseRealtimeFilters; overload;
     function equalTo(const value: integer): ieFirebaseRealtimeFilters; overload;
     function limitToFirst(const value: integer): ieFirebaseRealtimeFilters;
     function limitToLast(const value: integer): ieFirebaseRealtimeFilters;
     function Search: ieFirebaseRealtimeResponse;

     //ieFirebaseRealtime
     function AccessToken(const Token: string): ieFirebaseRealtime;
     function Endpoint(const url_path: string): ieFirebaseRealtime;
     function Collection(const name: string): ieFirebaseRealtime;
     function ReadWithoutFilters: ieFirebaseRealtimeResponse;
     function Read: ieFirebaseRealtimeFilters;
     function CreateRegister(const body: string): ieFirebaseRealtimeResponse;
     function UpdateRegister(const body: string; id: string = ''): ieFirebaseRealtimeResponse;
     function WriteRegister(const body: string; Etag: string = ''): ieFirebaseRealtimeResponse;
     function DeleteRegister(const id: string = ''): ieFirebaseRealtimeResponse;
  End;

  const
   Url_base = '.firebaseio.com/';
   auth_prefix = 'auth=';

implementation

{ TeFirebaseRealtimeDB }

//-------Métodos básicos da classe---------------------------------------------------------------------------------
constructor TeFirebaseRealtimeDB.Create(const ProjectID: string);
begin
  fUrl := 'https://' + ProjectID + Url_base;
end;

destructor TeFirebaseRealtimeDB.Destroy;
begin

  inherited;
end;

class function TeFirebaseRealtimeDB.New(const ProjectID: string): ieFireBaseRealtime;
begin
  Result := Self.Create(ProjectID);
end;

//-------Métodos para coletar dados específicos---------------------------------------------------------------------------------
function TeFirebaseRealtimeDB.AccessToken(const Token: string): ieFirebaseRealtime;
begin

end;

function TeFirebaseRealtimeDB.Endpoint(const url_path: string): ieFirebaseRealtime;
begin

end;

function TeFirebaseRealtimeDB.Collection(const name: string): ieFirebaseRealtime;
begin

end;

//-------Métodos para executar ações---------------------------------------------------------------------------------
function TeFirebaseRealtimeDB.CreateRegister(const body: string): ieFirebaseRealtimeResponse;
begin

end;

function TeFirebaseRealtimeDB.DeleteRegister(const id: string): ieFirebaseRealtimeResponse;
begin

end;

function TeFirebaseRealtimeDB.Read: ieFirebaseRealtimeFilters;
begin
  Result := Self;
end;

function TeFirebaseRealtimeDB.ReadWithoutFilters: ieFirebaseRealtimeResponse;
begin

end;

function TeFirebaseRealtimeDB.Search: ieFirebaseRealtimeResponse;
begin

end;

function TeFirebaseRealtimeDB.UpdateRegister(const body: string; id: string): ieFirebaseRealtimeResponse;
begin

end;

function TeFirebaseRealtimeDB.WriteRegister(const body: string; Etag: string): ieFirebaseRealtimeResponse;
begin

end;

//-------Métodos para implementar filtros---------------------------------------------------------------------------------
function TeFirebaseRealtimeDB.endAt(const value: string): ieFirebaseRealtimeFilters;
begin

end;

function TeFirebaseRealtimeDB.endAt(const value: integer): ieFirebaseRealtimeFilters;
begin

end;

function TeFirebaseRealtimeDB.equalTo(const value: integer): ieFirebaseRealtimeFilters;
begin

end;

function TeFirebaseRealtimeDB.equalTo(const value: string): ieFirebaseRealtimeFilters;
begin

end;

function TeFirebaseRealtimeDB.limitToFirst(const value: integer): ieFirebaseRealtimeFilters;
begin

end;

function TeFirebaseRealtimeDB.limitToLast(const value: integer): ieFirebaseRealtimeFilters;
begin

end;

function TeFirebaseRealtimeDB.OrderBy(const fields: string): ieFirebaseRealtimeFilters;
begin

end;

function TeFirebaseRealtimeDB.OrderBy(const kind: eFirebaseOrderByKind): ieFirebaseRealtimeFilters;
begin

end;

function TeFirebaseRealtimeDB.starAt(const value: integer): ieFirebaseRealtimeFilters;
begin

end;

function TeFirebaseRealtimeDB.startAt(const value: string): ieFirebaseRealtimeFilters;
begin

end;

end.
