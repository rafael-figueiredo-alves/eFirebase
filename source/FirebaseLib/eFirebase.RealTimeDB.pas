unit eFirebase.RealTimeDB;

interface

uses
  eFirebase.Interfaces,
  eFirebase.Types;

Type

  TeFirebaseRealtimeDB = Class(TInterfacedObject, ieFireBaseRealtime, ieFirebaseRealtimeFilters)
    Private
     fUrl          : string;
     fToken        : string;
     fCollection   : string;
     fEndpoint     : string;
     fOrderBy      : string;
     fstartAt      : string;
     fendAt        : string;
     fequalTo      : string;
     flimitToFirst : string;
     flimittoLast  : string;
     function MountUrl: string;
     function MountUrlSearch: string;
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
     function DeleteRegister(const id: string = ''; Etag: string = ''): ieFirebaseRealtimeResponse;
  End;

  const
   Url_base = '.firebaseio.com/';

implementation

uses System.SysUtils,
     eFirebase.rest, eFirebase.Responses.RealTimeDB;

{ TeFirebaseRealtimeDB }

//-------Métodos básicos da classe---------------------------------------------------------------------------------
constructor TeFirebaseRealtimeDB.Create(const ProjectID: string);
begin
   fUrl          := 'https://' + ProjectID + Url_base;
   fToken        := EmptyStr;
   fCollection   := EmptyStr;
   fEndpoint     := EmptyStr;
   fOrderBy      := EmptyStr;
   fstartAt      := EmptyStr;
   fendAt        := EmptyStr;
   fequalTo      := EmptyStr;
   flimitToFirst := EmptyStr;
   flimittoLast  := EmptyStr;
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
  Result := Self;
  fToken := 'auth=' + Token;
end;

function TeFirebaseRealtimeDB.Endpoint(const url_path: string): ieFirebaseRealtime;
var
 fpath : string;
begin
  Result := Self;
  fpath := url_path;

  if fpath.StartsWith('/') then
   fpath.Remove(1, 1);

  if not fpath.EndsWith('/') then
   fpath := fpath + '/';

  fEndpoint := fpath;
end;

function TeFirebaseRealtimeDB.Collection(const name: string): ieFirebaseRealtime;
var
 fData : string;
begin
  Result := Self;
  fData := name;

  if fData.StartsWith('/') then
   fData.Remove(1, 1);

  fCollection := fData;
end;

//-------Métodos para implementar filtros---------------------------------------------------------------------------------
function TeFirebaseRealtimeDB.endAt(const value: string): ieFirebaseRealtimeFilters;
begin
  Result := self;
  fendAt := 'endAt="' + value + '"';
end;

function TeFirebaseRealtimeDB.endAt(const value: integer): ieFirebaseRealtimeFilters;
begin
  Result := self;
  fendAt := 'endAt=' + value.ToString;
end;

function TeFirebaseRealtimeDB.equalTo(const value: integer): ieFirebaseRealtimeFilters;
begin
  Result := self;
  fequalTo := 'equalTo=' + value.ToString;
end;

function TeFirebaseRealtimeDB.equalTo(const value: string): ieFirebaseRealtimeFilters;
begin
  Result := self;
  fequalTo := 'equalTo="' + value + '"';
end;

function TeFirebaseRealtimeDB.limitToFirst(const value: integer): ieFirebaseRealtimeFilters;
begin
  Result := self;
  flimitToFirst := 'limitToFirst=' + value.ToString;
end;

function TeFirebaseRealtimeDB.limitToLast(const value: integer): ieFirebaseRealtimeFilters;
begin
  Result := self;
  flimittoLast := 'limitToLast=' + value.ToString;
end;

function TeFirebaseRealtimeDB.OrderBy(const fields: string): ieFirebaseRealtimeFilters;
begin
  Result := self;
  fOrderBy := 'orderBy="' + fields + '"';
end;

function TeFirebaseRealtimeDB.OrderBy(const kind: eFirebaseOrderByKind): ieFirebaseRealtimeFilters;
begin
  Result := self;
  case kind of
    obkKey:      fOrderBy := 'orderBy="$key"' ;
    obkValue:    fOrderBy := 'orderBy="$value"';
    obkPriority: fOrderBy := 'orderBy="$priority"';
  end;
end;

function TeFirebaseRealtimeDB.starAt(const value: integer): ieFirebaseRealtimeFilters;
begin
  Result := self;
  fstartAt := 'startAt=' + value.ToString;
end;

function TeFirebaseRealtimeDB.startAt(const value: string): ieFirebaseRealtimeFilters;
begin
  Result := self;
  fstartAt := 'startAt="' + value + '"';
end;

//-------Métodos para executar ações---------------------------------------------------------------------------------
function TeFirebaseRealtimeDB.MountUrl: string;
begin
  Result := fUrl + fEndpoint + fCollection;

  if fToken <> EmptyStr then
   Result := Result + '?' + fToken;
end;

function TeFirebaseRealtimeDB.MountUrlSearch: string;
begin
   if fToken = EmptyStr then
    Result := '?'
   else
    Result := '&';

   if fOrderBy <> EmptyStr then
    begin
      Result := Result + fOrderBy;

      if fstartAt <> EmptyStr then
       begin
         Result := Result + '&' + fstartAt;

         if fendAt <> EmptyStr then
          Result := Result + '&' + fendAt;
       end;

      if fequalTo <> EmptyStr then
       Result := Result + '&' + fequalTo;

      if flimitToFirst <> EmptyStr then
       begin
         Result := Result + '&' + flimitToFirst;
         flimittoLast := EmptyStr;
       end;

      if flimittoLast <> EmptyStr then
       Result := Result + '&' + flimittoLast;
    end;

   if (Result = '?') or (Result = '&') then
    Result := EmptyStr;
end;

function TeFirebaseRealtimeDB.CreateRegister(const body: string): ieFirebaseRealtimeResponse;
var
  cUrl: string;
  ResponseJSON : string;
  Response     : iResponse;
begin
  fCollection := fCollection + '.json';

  cUrl := MountUrl;

  Response := TRest.New
                     .BaseUrl(cUrl)
                     .AddHeaders('X-Firebase-ETag', 'true')
                     .Post;

  ResponseJSON := Response.Content;
  Result := TeFirebaseRealtimeResponse.Create(ResponseJSON, Response.StatusCode, Response.Headers.Values['ETag']);
end;

function TeFirebaseRealtimeDB.DeleteRegister(const id: string; Etag: string): ieFirebaseRealtimeResponse;
var
  cUrl: string;
  ResponseJSON : string;
  Response     : iResponse;
begin
  if id <> EmptyStr then
   fCollection := fCollection + '/' + id + '.json'
  else
   fCollection := fCollection + '.json';

  cUrl := MountUrl;

  if Etag <> EmptyStr then
   Response := TRest.New
                      .BaseUrl(cUrl)
                      .AddHeaders('if-match', Etag)
                      .Delete
  else
      Response := TRest.New
                      .BaseUrl(cUrl)
                      .Delete;

  ResponseJSON := Response.Content;
  Result := TeFirebaseRealtimeResponse.Create(ResponseJSON, Response.StatusCode, Response.Headers.Values['ETag']);
end;

function TeFirebaseRealtimeDB.Read: ieFirebaseRealtimeFilters;
begin
  Result := Self;
end;

function TeFirebaseRealtimeDB.ReadWithoutFilters: ieFirebaseRealtimeResponse;
var
  cUrl: string;
  ResponseJSON : string;
  Response     : iResponse;
begin
  fCollection := fCollection + '.json';

  cUrl := MountUrl;

  Response := TRest.New
                     .BaseUrl(cUrl)
                     .AddHeaders('X-Firebase-ETag', 'true')
                     .Get;

  ResponseJSON := Response.Content;
  Result := TeFirebaseRealtimeResponse.Create(ResponseJSON, Response.StatusCode, Response.Headers.Values['ETag']);
end;

function TeFirebaseRealtimeDB.Search: ieFirebaseRealtimeResponse;
var
  cUrl: string;
  ResponseJSON : string;
  Response     : iResponse;
begin
  fCollection := fCollection + '.json';

  cUrl := MountUrl + MountUrlSearch;

  Response := TRest.New
                     .BaseUrl(cUrl)
                     { Removido pois o Firebase não aceita Etag com query params para pesquisa filtrada
                     .AddHeaders('X-Firebase-ETag', 'true')
                     }
                     .Get;

  ResponseJSON := Response.Content;
  Result := TeFirebaseRealtimeResponse.Create(ResponseJSON, Response.StatusCode, Response.Headers.Values['ETag']);
end;

function TeFirebaseRealtimeDB.UpdateRegister(const body: string; id: string): ieFirebaseRealtimeResponse;
var
  cUrl: string;
  ResponseJSON : string;
  Response     : iResponse;
begin
  if id <> EmptyStr then
   fCollection := fCollection + '/' + id + '.json'
  else
   fCollection := fCollection + '.json';

  cUrl := MountUrl;

  Response := TRest.New
                     .BaseUrl(cUrl)
                     .Body(body)
                     .Patch;

  ResponseJSON := Response.Content;
  Result := TeFirebaseRealtimeResponse.Create(ResponseJSON, Response.StatusCode);
end;

function TeFirebaseRealtimeDB.WriteRegister(const body: string; Etag: string): ieFirebaseRealtimeResponse;
var
  cUrl: string;
  ResponseJSON : string;
  Response     : iResponse;
  feTag         : string;
begin
  fCollection := fCollection + '.json';

  cUrl := MountUrl;

  if Etag <> EmptyStr then
   Response := TRest.New
                      .BaseUrl(cUrl)
                      .AddHeaders('if-match', Etag)
                      .Body(body)
                      .Put
  else
      Response := TRest.New
                      .BaseUrl(cUrl)
                      .Body(body)
                      .Put;

  ResponseJSON := Response.Content;
  feTag         := '';
  feTag := Response.Headers.Values['ETag'];
  Result := TeFirebaseRealtimeResponse.Create(ResponseJSON, Response.StatusCode, feTag);
end;

end.
