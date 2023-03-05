unit eFirebase;

//--------------------------------------------------------------------------------
//  eFirebase - versão 0.0.7-a
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
     function Version: string;
  End;

 const
  eFirebase_version = '0.0.7-a';

implementation

uses
  eFirebase.Auth;

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

class function TeFirebase.New: ieFirebase;
begin
  Result := Self.Create;
end;

function TeFirebase.Version: string;
begin
  Result := eFirebase_version;
end;

end.
