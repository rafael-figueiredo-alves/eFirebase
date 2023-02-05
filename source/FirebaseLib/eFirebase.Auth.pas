unit eFirebase.Auth;

interface

uses
 eFirebase.Interfaces;

type

  TeFirebaseAuth = Class(TInterfacedObject, ieFirebaseAuth)
    Private
     fAPI_Key: string;
    Public
     Constructor Create(const API_Key: string);
     Destructor Destroy; Override;
     Class function New(const API_Key: string): ieFirebaseAuth;
     function SignUpWithEmailPassword(const email, password: string): ieFirebaseResponseAuth;
  End;

implementation

{ TeFirebaseAuth }

constructor TeFirebaseAuth.Create(const API_Key: string);
begin
  fAPI_Key := API_Key;
end;

destructor TeFirebaseAuth.Destroy;
begin

  inherited;
end;

class function TeFirebaseAuth.New(const API_Key: string): ieFirebaseAuth;
begin
  Result := Self.Create(API_Key);
end;

function TeFirebaseAuth.SignUpWithEmailPassword(const email,
  password: string): ieFirebaseResponseAuth;
begin

end;

end.
