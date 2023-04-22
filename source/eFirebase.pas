unit eFirebase;

//--------------------------------------------------------------------------------
//  eFirebase - versão 0.0.8-a
//  --------------------------
//  Biblioteca para consumo de recursos do Firebase
//  Desenvolvido por Rafael de Figueiredo Alves (DevPegasus)
//  -------------------------------------------------------
//  Dedicatória: "Dedico esta biblioteca aos grandes amores da minha vida, minha esposa Jailza e meus filhos Rafaela e Davi."
//--------------------------------------------------------------------------------

interface

Uses
  eFirebase.Interfaces;

Type
 TeFirebase = Class(TInterfacedObject, ieFirebase)
    Private
    Public
     Constructor Create;
     Destructor Destroy; Override;
     Class function New: ieFirebase;
     function Auth(const API_Key: string): ieFirebaseAuth;
     function RealTimeDB(const API_Key: string): ieFirebaseRealtime;
     function Storage(const ProjectCode: string): ieFirebaseStorage;
     function Firestore(const API_Key: string): ieFirebaseFirestore;
     function Version: string;
  End;

 const
  eFirebase_VERSION = '0.0.10-a';

implementation

uses
  eFirebase.Auth,
  eFirebase.Storage;

{ TeFirebase }

function TeFirebase.Auth(const API_Key: string): ieFirebaseAuth;
begin
  Result := TeFirebaseAuth.New(API_Key);
end;

constructor TeFirebase.Create;
begin

end;

destructor TeFirebase.Destroy;
begin

  inherited;
end;

function TeFirebase.Firestore(const API_Key: string): ieFirebaseFirestore;
begin
  //Result := TeFirebaseFirestore.New(API_Key);
end;

class function TeFirebase.New: ieFirebase;
begin
  Result := Self.Create;
end;

function TeFirebase.RealTimeDB(const API_Key: string): ieFirebaseRealtime;
begin
  //Result := TeFirebaseRealTimeDB.New(API_Key);
end;

function TeFirebase.Storage(const ProjectCode: string): ieFirebaseStorage;
begin
  Result := TeFirebaseStorage.New(ProjectCode);
end;

function TeFirebase.Version: string;
begin
  Result := eFirebase_VERSION;
end;

end.
